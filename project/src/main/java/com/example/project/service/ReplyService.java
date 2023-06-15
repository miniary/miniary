package com.example.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.entity.ReplyDto;
import com.example.project.repository.ReplyDao;
import com.example.project.vo.ReplyVO;

@Service
public class ReplyService {

	@Autowired
	private ReplyDao replyDao;
	
	//댓글 목록
	public List<ReplyVO> replyList(int boardNo){
		List<ReplyVO> replyVO = replyDao.selectList(boardNo);
		return replyVO;
	}
	
	//댓글 작성
	public void write(ReplyDto replyDto, HttpSession session) {
		int replyNo = replyDao.sequence();
		int replyWriter = (int)session.getAttribute("loginNo");
		
		replyDto.setReplyNo(replyNo);
		replyDto.setReplyWriter(replyWriter);
		replyDao.write(replyDto);
	}
	
	//댓글 수정
	public boolean edit(ReplyDto replyDto) {
		return replyDao.edit(replyDto);
	}
	
	//댓글 삭제
	public boolean delete(int replyNo) {
		return replyDao.delete(replyNo);
	}
} 
