package com.example.project.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AttachDto {

	private int attachNo;
	private String attachName
				  ,attachType;
	private long attachSize;
	private Date attachTime;
	
}
