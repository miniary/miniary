package com.example.project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.project.entity.AttachDto;

@Repository
public class AttachDaoImpl implements AttachDao{
	
	@Autowired
	private SqlSession sqlSession;

	//파일 번호 시퀀스
	@Override
	public int sequence() {
		return sqlSession.selectOne("attach.sequence");
	}
	
	//파일 추가
	@Override
	public void upload(AttachDto attachmentDto) {
		sqlSession.insert("attach.insert",attachmentDto);
	}
	
	//파일 조회
	@Override
	public AttachDto selectOne(int attachNo) {
		return sqlSession.selectOne("attach.one",attachNo);
	}
	
	//파일 삭제
	@Override
	public boolean delete(int attachNo) {
		return sqlSession.delete("attach.delete",attachNo)>0;
	}
	
	
}
