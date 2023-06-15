package com.example.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.example.project.entity.AttachDto;
import com.example.project.entity.MemDto;
import com.example.project.entity.ProfileAttachDto;

@Repository
public class MemDaoImpl implements MemDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	//회원번호 시퀀스
	@Override
	public int seqeunce() {
		return sqlSession.selectOne("mem.sequence");
	}
	
	//회원가입
	@Override
	public void join(MemDto memDto) {
		String pw = memDto.getMemPw();
		String encPw = encoder.encode(pw);
		memDto.setMemPw(encPw);
		sqlSession.insert("mem.join",memDto);
	}
	
	//단일 조회
	@Override
	public MemDto selectOne(int MemNo) {		
		return sqlSession.selectOne("mem.one",MemNo);
	}
	
	@Override
	public MemDto findId(String memId) {
		return sqlSession.selectOne("mem.id",memId);
	}
	
	@Override
	public MemDto findNick(String memNick) {
		return sqlSession.selectOne("mem.nick",memNick);
	}

	//로그인 
	@Override
	public boolean login(MemDto inputDto) {
		//inputDto : 사용자 입력 정보, findDto : 암호화된 DB 정보
		MemDto findDto = sqlSession.selectOne("mem.id",inputDto.getMemId());
		
		if(findDto==null) {//아이디 불일치 시 실패
			return false;
		}
		
		else {//아이디 일치 시 비밀번호 매치 작업 
			return encoder.matches(inputDto.getMemPw(), findDto.getMemPw());			
		}	
	}
	
	//프로필 수정
	@Override
	public boolean editProfile(MemDto memDto) {
		return sqlSession.update("mem.profile",memDto)>0;
	}
	
	//프로필 이미지 추가
	@Override
	public void insertProfile(ProfileAttachDto profileAttachDto) {
		sqlSession.insert("mem.insertProfile",profileAttachDto);
		
	}
	
	//프로필 이미지 조회
	@Override
	public List<AttachDto> findProfile(int memNo) {
		return sqlSession.selectList("mem.findProfile",memNo);
	}
	
	//프로필 이미지 삭제
	@Override
	public boolean deleteProfile(int memNo) {
		return sqlSession.delete("mem.deleteProfile",memNo)>0;
	}
	
	//비밀번호 재설정
	@Override
	public boolean resetPw(MemDto memDto) {
		String pw = memDto.getMemPw();
		String enc = encoder.encode(pw);
		memDto.setMemPw(enc);
		
		boolean judge = sqlSession.update("mem.pw",memDto)>0;
		return judge;
	}

	//개인정보 조회
	@Override
	public MemDto selectInfo(MemDto memDto) {
		return sqlSession.selectOne("mem.infoCheck",memDto);
	}

	
	
}
