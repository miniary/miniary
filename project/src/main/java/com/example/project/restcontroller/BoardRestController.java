package com.example.project.restcontroller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.project.entity.AttachDto;
import com.example.project.entity.BoardAttachDto;
import com.example.project.entity.BoardDto;
import com.example.project.entity.MemDto;
import com.example.project.repository.BoardDao;
import com.example.project.repository.MemDao;
import com.example.project.service.AttachService;
import com.example.project.service.BoardService;
import com.example.project.vo.BoardListSearchVO;
import com.example.project.vo.BoardVO;

import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping("/rest/board")
public class BoardRestController {

	@Autowired
	private BoardDao boardDao; 
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private MemDao memDao;
	
		@GetMapping("")
		@Operation(summary = "게시글 목록")
		public ModelAndView list(BoardListSearchVO boardListSearchVO, HttpSession session){		
			ModelAndView modelAndView = new ModelAndView();
			modelAndView = boardService.list(boardListSearchVO);
			int memNo = (int) session.getAttribute("loginNo");
			MemDto memDto = memDao.selectOne(memNo);
			modelAndView.addObject("profile",memDao.findProfile(memNo));
			
			return modelAndView;
	}
		
		@GetMapping("/post")
		@Operation(summary = "게시글 작성 페이지")
			public ModelAndView write(HttpSession session) {
				ModelAndView modelAndView = new ModelAndView();
				modelAndView.setViewName("board/write");
				
				int memNo = (int) session.getAttribute("loginNo");
				modelAndView.addObject("profile",memDao.findProfile(memNo));
				return modelAndView;
		}
		

		@PostMapping("")
		@Operation(summary = "게시글 작성")
		public int write(@RequestPart(value="board") BoardDto boardDto, HttpSession session, @RequestPart(value="file", required=false) List<MultipartFile> attachments) 
																																					throws IllegalStateException, IOException {		
			//글 번호
			int boardNo = boardDao.sequence();
			boardDto.setBoardNo(boardNo);

			//글 insert
			boardService.write(boardDto, session);	
			
			//첨부파일이 있다면
			if(attachments!=null) {
				for(MultipartFile file : attachments) {
					
					// attach 추가
					int attachNo = attachService.upload(attachments, file); 
					BoardAttachDto boardAttachDto = new BoardAttachDto(boardNo,attachNo);
					
					//boardAttach 추가
					boardDao.addBoardAttach(boardAttachDto);
				}
			}				
			return boardNo;
		}
		
		//글 상세 조회
		@GetMapping("{boardNo}")
		@Operation(summary = "게시글 상세 페이지")
		public ModelAndView detail(@PathVariable int boardNo, HttpSession session) {
			ModelAndView modelAndView = new ModelAndView();
			int memNo = (int) session.getAttribute("loginNo");

			modelAndView = boardService.one(boardNo, session);
			modelAndView.addObject("boardNo",boardNo);
			modelAndView.addObject("profile",memDao.findProfile(memNo));
			return modelAndView;		
		}
		
		//파일 다운로드
		@GetMapping("/file/{attachNo}")
		@Operation(summary = "파일 다운로드")
		public ResponseEntity<ByteArrayResource> download(@PathVariable int attachNo) throws IOException{
			return attachService.download(attachNo);
		}
		
		//글 수정 페이지로 가기 위한 매핑
		@GetMapping("change/{boardNo}")
		@Operation(summary = "게시글 수정 페이지")
		public ModelAndView changePage(@PathVariable int boardNo, HttpSession session) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("board/edit");
			int memNo = (int) session.getAttribute("loginNo");
		
			//글VO
			List<BoardVO> boardVO = boardDao.selectOne(boardNo);
		
			//파일DTO
			List<AttachDto> attachDto = boardDao.findAttach(boardNo);
			
			modelAndView.addObject("boardVO",boardVO.get(0));
			modelAndView.addObject("attachDto",attachDto);
			modelAndView.addObject("profile",memDao.findProfile(memNo));
			
			return modelAndView;
		}
		
		//글 수정
		@PutMapping("{boardNo}")
		@Operation(summary = "게시글 수정")
		public int edit(@RequestPart(value="board") BoardDto boardDto, @RequestPart(value="originAttachNo", required = false) List<Integer> originAttachNo, 
						@RequestPart(value="file", required=false) List<MultipartFile> attachments) throws IllegalStateException, IOException {
			
			 boardService.edit(boardDto);
			 
			 //수정 페이지에서 지우는 파일 번호가 있다면 파일을 지움
			 if(originAttachNo !=null) {
				 for(Integer no : originAttachNo) {
					 attachService.attachDelete(no);
				 }
			 }
			 
				//새로운 첨부파일이 있다면
				if(attachments!=null) {
					for(MultipartFile file : attachments) {
						
						// attach 추가
						int attachNo = attachService.upload(attachments, file); 
						BoardAttachDto boardAttachDto = new BoardAttachDto(boardDto.getBoardNo(),attachNo);
						
						//boardAttach 추가
						boardDao.addBoardAttach(boardAttachDto);
					}
				}			
			 return boardDto.getBoardNo();
		}
		
		//글 삭제
		@DeleteMapping("/{boardNo}")
		@Operation(summary = "게시글 삭제")
		public boolean delete(@PathVariable int boardNo) {
			return boardService.delete(boardNo);
		}
}
