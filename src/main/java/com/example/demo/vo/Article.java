package com.example.demo.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Article {
	
	private int id;
	private String title;
	private String body;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	
	private int memberId;
	private String extra__writer;
	private boolean userCanModify;
	private boolean userCanDelete;
	
	public Article(String title, String body) {
		this.title = title;
		this.body = body;
	}

}
