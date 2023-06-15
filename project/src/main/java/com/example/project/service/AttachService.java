package com.example.project.service;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.entity.AttachDto;
import com.example.project.repository.AttachDao;


@Service
public class AttachService {
	@Autowired
	private AttachDao attachDao;

	private final File dir = new File(System.getProperty("user.home"),"/upload");
	
	//업로드
	public int upload(List<MultipartFile> attachments, MultipartFile file) throws IllegalStateException, IOException {
		
		//DB(attach테이블) 정보 저장
		int attachNo = attachDao.sequence();
		attachDao.upload(AttachDto.builder()
				.attachNo(attachNo)
				.attachName(file.getOriginalFilename())
				.attachType(file.getContentType())
				.attachSize(file.getSize())
			.build());
		dir.mkdir(); //폴더 생성
		
		//target에 파일 저장
		File target = new File(dir, String.valueOf(attachNo));//파일 이름 : 번호로 지정
		file.transferTo(target);//파일 저장
		
		return attachNo;
	}
	
//	- 다운로드란 현재의 서버에서 사용자에게 파일을 전송하는 것
//	- 전송을 부탁하려면 ResponseEntity<ByteArrayResource> 형태가 반환되어야 한다
	//다운로드
	public ResponseEntity<ByteArrayResource> download (int attachNo) throws IOException{
		
		//1.DB에서 파일 탐색
		AttachDto attachDto = attachDao.selectOne(attachNo);
		if(attachDto == null) {
			return null;
		}
		
		//2.파일 불러오기
		File target = new File(dir, String.valueOf(attachNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//3. 응답 객체 생성하여 데이터 전송
		return ResponseEntity.ok()
		.header(HttpHeaders.CONTENT_ENCODING, 
										StandardCharsets.UTF_8.name())
		.header(HttpHeaders.CONTENT_TYPE, 
							attachDto.getAttachType())
		.header(HttpHeaders.CONTENT_DISPOSITION, 
							ContentDisposition.attachment()
									.filename(
											attachDto.getAttachName(), 
											StandardCharsets.UTF_8)
									.build().toString())
					.contentLength(attachDto.getAttachSize())
					.body(resource);
	}
	
	//파일 1개 삭제
	public void attachDelete(int originAttachNo) {
		attachDao.delete(originAttachNo);
		
		String attachNo = String.valueOf(originAttachNo);
		File target = new File(dir, attachNo);
		target.delete();	
	}
	
	//파일리스트 삭제
	public void attahmentsDelete(List<AttachDto> attachments) {
		for(AttachDto attachDto : attachments) {
			//DB(attach 테이블)에서 삭제
			attachDao.delete(attachDto.getAttachNo());
			
			//target에 지정된 실제파일 삭제
			String attachNo = String.valueOf(attachDto.getAttachNo());
			File target = new File(dir, attachNo);
			target.delete();			
		}
	}
	
}