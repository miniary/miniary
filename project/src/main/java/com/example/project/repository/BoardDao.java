package com.example.project.repository;

import java.util.List;

import com.example.project.entity.AttachDto;
import com.example.project.entity.BoardAttachDto;
import com.example.project.entity.BoardDto;
import com.example.project.vo.BoardListSearchVO;
import com.example.project.vo.BoardVO;

public interface BoardDao {

	//게시글 번호 시퀀스
	int sequence();
	
	//게시글 갯수
	int count(BoardListSearchVO vo);
	
	//게시글 목록 조회(목록 or 검색)
	List<BoardVO> selectList(BoardListSearchVO vo);
	
	//닉넴 포함 목록 조회
	List<BoardVO> selectList2();
	
	//게시글 작성
	void write(BoardDto boardDto);
	
	//파일 첨부
	void addBoardAttach(BoardAttachDto boardAttachDto);
	
	//게시글 상세 조회
	List<BoardVO> selectOne(int boardNo);
	
	//조회수 증가
	boolean updateReadCount(int boardNo);

	//파일 조회
	List<AttachDto> findAttach(int boardNo);
	
	//게시글 수정
	boolean edit(BoardDto boardDto);
	
	//게시글 삭제
	boolean delete(int boardNo);
	
}
