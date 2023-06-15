package com.example.project.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.example.project.entity.AttachDto;
import com.example.project.entity.BoardDto;
import com.example.project.repository.AttachDao;
import com.example.project.repository.BoardDao;
import com.example.project.vo.BoardListSearchVO;
import com.example.project.vo.BoardVO;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private AttachService attachService;
	
	//글 목록
	public ModelAndView list(BoardListSearchVO boardListSearchVO) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/list"); //가져올 jsp 경로
		
		//페이지 게시글 수
		int count = boardDao.count(boardListSearchVO);
		boardListSearchVO.setCount(count);
		
		//페이지네이션 startRow, endRow 설정
		boardListSearchVO.setStartRow(boardListSearchVO.startRow());
		boardListSearchVO.setEndRow(boardListSearchVO.endRow());
		boardListSearchVO.setType(boardListSearchVO.getType());
		boardListSearchVO.setKeyword(boardListSearchVO.getKeyword());
		
		List<BoardVO> boardListVO = boardDao.selectList(boardListSearchVO);
		
		//목록, pageVO 첨부
		modelAndView.addObject("boardList",boardListVO); //modelAndView에 boardList란 이름으로 첨부
		modelAndView.addObject("page",boardListSearchVO);
		return modelAndView;
	}
	
	
	//글 작성
	public void write(BoardDto boardDto,HttpSession session) {
		
		//세션 값 작성자 번호로 저장
		int boardWriter = (int)session.getAttribute("loginNo");	
		boardDto.setBoardWriter(boardWriter);
		boardDao.write(boardDto);
	}
	
	//글 상세 조회
	public ModelAndView one(int boardNo, HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/post");
	
		//파일DTO
		List<AttachDto> attachDto = boardDao.findAttach(boardNo);
		
		//조회수 증가(중복 방지)
		//(1) 세션에 게시글 번호 저장소 구현(이름 지정 : history)
		//(2) 현재 history가 있을지 없을지 모르므로 꺼내서 없으면 생성하도록 처리
		Set<Integer> history = (Set<Integer>) session.getAttribute("history");
		if(history==null) {
			history = new HashSet<>();
		}
		
		//(3)현재 글 번호를 읽은 적 있는지 검사
		if(history.add(boardNo)) {
			boardDao.updateReadCount(boardNo);
			List<BoardVO> boardList = boardDao.selectOne(boardNo);
			BoardVO boardVO = boardList.get(0);
			modelAndView.addObject("boardVO",boardVO);
		}
		else {
			//글VO
			List<BoardVO> boardList = boardDao.selectOne(boardNo);
			BoardVO boardVO = boardList.get(0);
			modelAndView.addObject("boardVO",boardVO);
		}
			
		//(4) 갱신된 저장소를 세션에 저장
		session.setAttribute("history", history);
		
		modelAndView.addObject("attachDto",attachDto);
		
		return modelAndView;
	}

	//글 수정
	public boolean edit(BoardDto boardDto) {	
		return boardDao.edit(boardDto);
	}
	
	//글 수정에서 기존 파일 삭제
	public AttachDto originFileDelte(int AttachNo) {
		AttachDto attachDto = attachDao.selectOne(AttachNo);
		return attachDto;
	}
	
	//글 삭제
	public boolean delete(int boardNo) {
		List<AttachDto> attachments = boardDao.findAttach(boardNo);
		attachService.attahmentsDelete(attachments);
		return boardDao.delete(boardNo);
	}
}
