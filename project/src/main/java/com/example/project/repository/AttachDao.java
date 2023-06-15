package com.example.project.repository;

import com.example.project.entity.AttachDto;

public interface AttachDao {
	
	//파일 번호 시퀀스
	int sequence();
	
	//파일 추가
	void upload(AttachDto attachmentDto);
	
	//파일 탐색
	AttachDto selectOne(int attachNo);
	
	//파일 삭제
	boolean delete(int attachNo);
}
