package com.example.project.cofigration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.project.interceptor.MemInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private MemInterceptor memInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(memInterceptor)
				.addPathPatterns(
						"/rest/mem/**",
						"/rest/board/**",
						"/rest/reply/**"
						)
				.excludePathPatterns(
						"/rest/mem/id", //아이디 중복검사
						"/rest/mem/nick", //닉네임 중복검사
						"/rest/mem/info/new", //회원가입
						"/rest/mem/info/local",//로그인
						"/rest/mem/info/check",//비밀번호 재설정-개인정보 확인
						"/rest/mem/pw/new"//비밀번호 재설정
						);
				
				
				
	}
	
}
