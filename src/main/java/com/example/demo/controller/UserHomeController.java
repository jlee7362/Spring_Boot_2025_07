package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Data;

@Controller
public class UserHomeController {
	int count = 10;
	
	@RequestMapping("/usr/home/getArticle")
	@ResponseBody
	public Article getArticle() {
		Article article = new Article (1, "제목1", "내용1");
		
		System.out.println(article);
		return article;
	}
	
}

@Data
@AllArgsConstructor
class Article{
	int id;
	String title;
	String body;
	
}
