package com.example.project.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ReplyDto {

	private int replyNo
			   ,replyWriter
			   ,boardNo;
	private Date ReplyWritetime;
	private String replyContent;
}
