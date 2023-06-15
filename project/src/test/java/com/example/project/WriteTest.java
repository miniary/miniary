package com.example.project;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.project.entity.BoardDto;
import com.example.project.repository.BoardDao;

@SpringBootTest
public class WriteTest {

	@Autowired
	private BoardDao boardDao;
	
	@Test
	public void write() {
		
		BoardDto boardDto = new BoardDto();
		//글 번호
		int boardNo = boardDao.sequence();
		
		//세션 값 작성자 번호로 저장
		int boardWriter = 1;
		
		boardDto.setBoardNo(boardNo);;
		boardDto.setBoardWriter(boardWriter);
		
//		boardDao.write(boardDto.builder()
//				.boardNo(boardNo)
//				.boardWriter(boardWriter)
//				.boardHead("이슈")
//				.boardTitle("zz")
//				.boardContent("zz")
//			.build());		
	}
	
}
