package com.example.project.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardDto {

	private int boardNo
				,boardWriter;
	private String boardHead
				   ,boardTitle
				   ,boardContent;
	private Date boardWriteTime;
	private int boardRead
				,replyCount;


}
