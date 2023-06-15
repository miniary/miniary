package com.example.project.repository;

import java.util.List;

import com.example.project.entity.AttachDto;
import com.example.project.entity.MemDto;
import com.example.project.entity.ProfileAttachDto;

public interface MemDao {
	
	//회원가입
	int seqeunce();
	void join(MemDto memDto);
	
	//단일 조회
	MemDto selectOne(int memNo);
	MemDto findId(String memId);
	MemDto findNick(String memNick);
	
	//로그인
	boolean login(MemDto memDto);
	
	//프로필 수정
	boolean editProfile(MemDto memDto);
	
	//프로필 이미지 추가
	void insertProfile(ProfileAttachDto profileAttachDto);
	
	//프로필 조회
	List<AttachDto> findProfile(int memNo);
	
	//프로필 삭제
	boolean deleteProfile(int memNo);

	//비밀번호 재설정
	boolean resetPw(MemDto memDto);
	
	//개인정보 조회
	MemDto selectInfo(MemDto memDto);
}
