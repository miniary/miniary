package com.example.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.project.entity.ReplyDto;
import com.example.project.vo.ReplyVO;

@Repository
public class ReplyDaoImpl implements ReplyDao{
	
	@Autowired
	private SqlSession sqlSession;

	//댓글 번호 시퀀스
	@Override
	public int sequence() {
		return sqlSession.selectOne("reply.sequence");
	}
	
	//댓글 목록 조회
	@Override
	public List<ReplyVO> selectList(int boardNo) {
		return sqlSession.selectList("reply.list",boardNo);
	}
	
	//댓글 작성
	@Override
	public void write(ReplyDto replyDto) {
		sqlSession.insert("reply.insert",replyDto);
	}
	
	//댓글 수정
	@Override
	public boolean edit(ReplyDto replyDto) {
		return sqlSession.update("reply.edit",replyDto)>0;
	}
	
	//댓그 삭제
	@Override
	public boolean delete(int replyNo) {
		return sqlSession.update("reply.delete",replyNo)>0;
	}
}
