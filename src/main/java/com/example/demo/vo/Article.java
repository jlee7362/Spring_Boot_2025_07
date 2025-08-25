package com.example.demo.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	
	private int id;
	private String title;
	private String body;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private String goodReactionPoint;
	private String badReactionPoint;
	
	private int memberId;
	private String extra__writer;
	private int hitCount;
	private String extra__sumReactionPoint;
	
	private boolean userCanModify;
	private boolean userCanDelete;
	
	
	
	public Article(String title, String body) {
		this.title = title;
		this.body = body;
	}

}
