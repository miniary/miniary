package com.example.project.restcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.project.entity.MemDto;
import com.example.project.repository.MemDao;
import com.example.project.service.MemService;

import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping("/rest/mem")
public class MemRestController {

	@Autowired
	private MemDao memDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private MemService memService;
	
	@RequestMapping("/id")
	@Operation(summary = "아이디 중복검사")
	public String id(@RequestParam String memId) {
		MemDto memDto = memDao.findId(memId);
		if(memDto==null) {
			return "NNNNY"; //사용 가능
		}
		else {
			return "NNNNN"; //사용 불가
		}
	}

	@RequestMapping("/nick")
	@Operation(summary = "닉네임 중복검사")
	public String nick(@RequestParam String memNick) {
		MemDto memDto = memDao.findNick(memNick);
		if(memDto==null) {
			return "NNNNY"; //사용 가능
		}
		else {
			return "NNNNN"; //사용 불가
		}
	}
	
	@PostMapping("/info/new")
	@Operation(summary = "회원가입")
	public void join(@RequestBody MemDto memDto) {
		memService.join(memDto);
	}
	
	
	@PostMapping("/info/local")
	@Operation(summary = "로그인")
	public String login(@RequestBody MemDto inputDto, HttpSession session) { 
		boolean judge = memService.login(inputDto, session);
		if(judge) {
			return "OK";
		}
		else {
			return "NO";
		}
	}
	
	@DeleteMapping("/info/local")
	@Operation(summary="로그아웃")
	public void logout(HttpSession session) {
		memService.logout(session);
	}
	
	//마이페이지로 가기 위한 매핑
	@GetMapping("/info")
	@Operation(summary = "비밀번호 확인 페이지")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mem/pwCheck");
		int memNo = (int) session.getAttribute("loginNo");
		modelAndView.addObject("profile",memDao.findProfile(memNo));
		return modelAndView;
	}
	
	//마이페이지 전 비밀번호 확인
	@PostMapping("/info/pw")
	@Operation(summary = "비밀번호 확인")
	public String pwCheck(@RequestBody Map<String, String> requestData, HttpSession session) {
		//클라이언트 측에서 JSON 형식으로 전송하므로 서버측에서 Map으로 전달 받아야함
		String inputPw = requestData.get("inputPw");
		boolean judge = memService.pwCheck(inputPw, session);
		if(judge) {
			return "OK";
		}
		else {
			return "NO";
		}
	}
	
	//개인정보 수정 페이지
	@GetMapping("/info/profile")
	@Operation(summary = "개인정보 수정 페이지")
	public ModelAndView profile(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mem/profile");
		int memNo = (int) session.getAttribute("loginNo");
		MemDto memDto = memDao.selectOne(memNo);
		modelAndView.addObject("memDto",memDto);
		modelAndView.addObject("profile",memDao.findProfile(memNo));

		return modelAndView;
	}
	
	//개인정보 수정
	@PutMapping("/info")
	@Operation(summary = "개인정보 수정")
	public boolean profileEdit(@RequestPart(value="inputDto") MemDto inputDto, @RequestPart(value="file", required=false)List<MultipartFile> attachments, HttpSession session) throws IllegalStateException, IOException {	
		
		boolean judge = memService.editProfile(session, inputDto, attachments);
	
		if(judge) {
			session.removeAttribute("loginNick");
			session.setAttribute("loginNick", inputDto.getMemNick());
		}
		
		return judge; 
	}
	
	//프로필 이미지 삭제
	@DeleteMapping("/info/profileImage/{memNo}")
	@Operation(summary = "프로필 이미지 삭제")
	public void profileDelete(@PathVariable int memNo) {
		memDao.deleteProfile(memNo);
	}
	
	//비밀번호 변경 페이지
	@GetMapping("/info/pw")
	@Operation(summary = "비밀번호 변경 페이지")
	public ModelAndView pwPage(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mem/editPw");
		int memNo = (int) session.getAttribute("loginNo");
		MemDto memDto = memDao.selectOne(memNo);
		modelAndView.addObject("memDto",memDto);
		modelAndView.addObject("profile",memDao.findProfile(memNo));
		return modelAndView;
	}
	
	//비밀번호 변경
	@PutMapping("/info/pw")
	@Operation(summary = "비밀번호 변경")
	public String editPw(@RequestBody Map<String, String> requestData, HttpSession session) {
		String newPw = requestData.get("newPw");
		boolean judge = memService.editPw(session, newPw);
		
		if(judge) {
			return "OK";
		}
		else {
			return "NO";
		}
	}
	
	//개인정보 확인 페이지
	@GetMapping("/info/check")
	@Operation(summary = "개인정보 확인 페이지")
	public ModelAndView infoPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mem/infoCheck");
		return modelAndView;
	}
	
	@PostMapping("/info/check")
	@Operation(summary = "개인정보 확인")
	public String infoCheck(@RequestBody MemDto inputDto, HttpSession session) {
		MemDto findDto = memService.infoCheck(inputDto);	
		if(findDto!=null) {
			List<Integer> memNoMemory = (List<Integer>) session.getAttribute("memNoMemory");
			
			if(memNoMemory==null) {
				memNoMemory = new ArrayList<>();
			}
			else {
				memNoMemory.removeAll(memNoMemory);				
			}
			
			memNoMemory.add(findDto.getMemNo());
			
			session.setAttribute("memNoMemory", memNoMemory);		
			return "OK";
		}
		else {
			return "NO";
		}
	}
	

	@GetMapping("/pw/new")
	@Operation(summary = "비밀번호 재설정 페이지")
	public ModelAndView pwRestPage(HttpSession session) {
		List<Integer> memNoMemory = (List<Integer>) session.getAttribute("memNoMemory");
		int memNo = memNoMemory.get(0);
		MemDto memDto = memDao.selectOne(memNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mem/resetPw");
		modelAndView.addObject("memId",memDto.getMemId());		
		return modelAndView;
	}
	
	@PutMapping("/pw/new")
	@Operation(summary = "비밀번호 재설정")
	public String resetPw(@RequestBody Map<String, String> requestData, HttpSession session) {
		List<Integer> memNoMemory = (List<Integer>) session.getAttribute("memNoMemory");
		int memNo = memNoMemory.get(0); 
		String newPw = requestData.get("newPw");
		
		MemDto memDto = memDao.selectOne(memNo);
		memDto.setMemPw(newPw);
		boolean judge = memService.resetPw(memDto);
		
		if(judge) {
			return "OK";			
		}
		else {
			return "NO";
		}
	}
	
}
