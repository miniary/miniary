package com.example.project.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardVO {
	
	private int boardNo;
	private String boardHead
			      ,boardTitle
			      ,boardContent
				  ,memNick;
	private Date boardWriteTime;
	private int boardRead
		       ,replyCount;	

}
