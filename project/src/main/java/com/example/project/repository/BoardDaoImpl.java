package com.example.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.project.entity.AttachDto;
import com.example.project.entity.BoardAttachDto;
import com.example.project.entity.BoardDto;
import com.example.project.vo.BoardListSearchVO;
import com.example.project.vo.BoardVO;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession sqlSession;
	
	//글 번호 시퀀스
	@Override
	public int sequence() {
		return sqlSession.selectOne("board.sequence");
	}
	
	//게시글 갯수
	@Override
	public int count(BoardListSearchVO vo) {
		if(vo.isSearch()) {
			return sqlSession.selectOne("board.searchCount",vo);
		}
		else {
			return sqlSession.selectOne("board.listCount",vo);			
		}
	}
	
	//게시글 목록
	@Override
	public List<BoardVO> selectList(BoardListSearchVO vo) {
		if(vo.isSearch()) {//검색이라면
			return sqlSession.selectList("board.search",vo);
		}
		else {			
			return sqlSession.selectList("board.list",vo);
		}
	}
	
	//닉넴 포함 게시글 목록
	@Override
	public List<BoardVO> selectList2() {
		return sqlSession.selectList("board.list2");
	}
	
	//게시글 작성
	@Override
	public void write(BoardDto boardDto) {
		sqlSession.insert("board.insert",boardDto);
	}
	
	//게시글 파일 첨부
	@Override
	public void addBoardAttach(BoardAttachDto boardAttachDto) {
		sqlSession.insert("board.insertAttach", boardAttachDto);
	}
	
	//게시글 상세 조회
	@Override
	public List<BoardVO> selectOne(int boardNo) {
		return sqlSession.selectList("board.one", boardNo);
	}
	
	//조회수 증가
	@Override
	public boolean updateReadCount(int boardNo) {
		return sqlSession.update("board.read",boardNo)>0;
	}
	
	//파일 조회
	@Override
	public List<AttachDto> findAttach(int boardNo) {
		return sqlSession.selectList("board.findAttach", boardNo);
	}
	
	//게시글 수정
	@Override
	public boolean edit(BoardDto boardDto) {
		return sqlSession.update("board.edit",boardDto)>0;
	}
	
	//게시글 삭제
	@Override
	public boolean delete(int boardNo) {
		return sqlSession.update("board.delete",boardNo)>0;
	}
}
