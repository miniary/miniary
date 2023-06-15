package com.example.project.repository;

import java.util.List;

import com.example.project.entity.ReplyDto;
import com.example.project.vo.ReplyVO;

public interface ReplyDao {

	//댓글 번호 시퀀스
	int sequence();
	
	//댓글 목록 조회
	List<ReplyVO> selectList(int boardNo);
	
	//댓글 작성
	void write(ReplyDto replyDto);
	
	//댓글 수정
	boolean edit(ReplyDto replyDto);
	
	//댓글 삭제
	boolean delete(int ReplyNo);
}
