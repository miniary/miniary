package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RootController {
	
	//회원가입
	@RequestMapping("/mem/info/new")
	public String join() {
		return "mem/join";
	}
	
	//로그인
	@RequestMapping("/mem/info/local")
	public String login() {
		return "mem/login";
	}	

}
