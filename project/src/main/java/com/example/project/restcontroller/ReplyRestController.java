package com.example.project.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.entity.ReplyDto;
import com.example.project.service.ReplyService;
import com.example.project.vo.ReplyVO;

import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

	@Autowired
	private ReplyService replyService;
	
	@GetMapping("{boardNo}")
	@Operation(summary = "댓글 조회")
	public List<ReplyVO> list(@PathVariable int boardNo){
		return replyService.replyList(boardNo);
	}
	
	@PostMapping("")
	@Operation(summary = "댓글 작성")
	public void write(@RequestBody ReplyDto replyDto, HttpSession session) {
		replyService.write(replyDto, session);
	}
	
	@PutMapping("")
	@Operation(summary = "댓글 수정")
	public void edit(@RequestBody ReplyDto replyDto) {
		replyService.edit(replyDto);
	}
	
	@DeleteMapping("/{replyNo}")
	@Operation(summary = "댓글 삭제")
	public boolean delete(@PathVariable int replyNo) {
		return replyService.delete(replyNo);
	}
}
