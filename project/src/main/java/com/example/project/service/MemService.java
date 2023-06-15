package com.example.project.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.entity.AttachDto;
import com.example.project.entity.BoardAttachDto;
import com.example.project.entity.MemDto;
import com.example.project.entity.ProfileAttachDto;
import com.example.project.repository.MemDao;

@Service
public class MemService {
	
	@Autowired
	private MemDao memDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private AttachService attachService;
	
	//회원가입
	public void join(MemDto memDto) {
		int memNo = memDao.seqeunce();
		memDao.join(memDto.builder()
				.memNo(memNo)
				.memId(memDto.getMemId())
				.memPw(memDto.getMemPw())
				.memNick(memDto.getMemNick())
				.memBirth(memDto.getMemBirth())
			.build());
	}
	
	//로그인
	public boolean login(MemDto inputDto, HttpSession session) {
		//inputDto : 사용자 입력 정보
		boolean judge = memDao.login(inputDto);
		MemDto findDto = memDao.findId(inputDto.getMemId());
		
		if(judge) { //정보가 맞을 시 세션에 저장
			session.setAttribute("loginNo", findDto.getMemNo());
			session.setAttribute("loginNick", findDto.getMemNick());
			return true;
		}
		else {
			return false;
		}
	}
	
	//로그아웃
	public void logout(HttpSession session) {
		session.removeAttribute("loginNo");
		session.removeAttribute("loginNick");
	}
	
	//비밀번호 확인
	public boolean pwCheck(String inputPw, HttpSession session) {
		int memNo = (int) session.getAttribute("loginNo");
		MemDto loginDto = memDao.selectOne(memNo);
		boolean judge = encoder.matches(inputPw, loginDto.getMemPw());
		return judge;
	}
	
	//프로필 수정
	public boolean editProfile(HttpSession session, MemDto inputDto, List<MultipartFile> attachments) throws IllegalStateException, IOException {
		int memNo = (int) session.getAttribute("loginNo");
		inputDto.setMemNo(memNo);
		
		//새로운 프로필 파일이 있으면
		if(attachments!=null) {
			for(MultipartFile file : attachments) {
				//새로운 dto를 생성하고
				int attachNo = attachService.upload(attachments, file); 
				ProfileAttachDto profileAttachDto = new ProfileAttachDto(attachNo,memNo);
				//이전 파일들은 profiles로 조회 후 삭제
				List<AttachDto> profiles = memDao.findProfile(memNo);
				attachService.attahmentsDelete(profiles);
				memDao.deleteProfile(memNo);
				//새로운 파일 dto 삽입
				memDao.insertProfile(profileAttachDto);
			}
		}
		return memDao.editProfile(inputDto);
	}
	
	//비밀번호 수정
	public boolean editPw(HttpSession session, String newPw) {
		int memNo = (int) session.getAttribute("loginNo");
		MemDto loginDto= memDao.selectOne(memNo);
		loginDto.setMemPw(newPw);
		boolean judge = memDao.resetPw(loginDto);
		
		return judge;
	}
	
	//비밀번호 재설정 전 개인정보 확인
	public MemDto infoCheck(MemDto inputDto) {
		MemDto findDto = memDao.selectInfo(inputDto);
		return findDto;
	}
	
	//비밀번호 재설정
	public boolean resetPw(MemDto inputDto) {
		int memNo = inputDto.getMemNo();
		MemDto memDto = memDao.selectOne(memNo);
		memDto.setMemPw(inputDto.getMemPw());
		boolean judge = memDao.resetPw(memDto);
		
		return judge;
	}
}
