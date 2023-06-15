package com.example.project;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.project.entity.MemDto;

@SpringBootTest
public class MybatisSelectTest {
	
	@Autowired
	private SqlSession sqlSession; //마이바티스 실행 도구
	
	@Test
	public void test() {
		int memNo = 1;
		MemDto memDto = sqlSession.selectOne("mem.one",memNo);
		System.out.println(memDto);
		 
	}
}
