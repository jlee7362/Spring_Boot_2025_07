package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Article;

@Controller
public class UserArticleController {
	private int lastArticleId;
	private List<Article> articles;
	private String title;
	private String body;
	
	public UserArticleController() {
		
		this.lastArticleId = 0;
		this.articles = new ArrayList<>();
		
		makeTestData();
	}
	
	private void makeTestData() {
		for(int i = 1; i <=10; i++) {
			String title = "제목 " + i;
			String body = "내용 " + i;
			writeArticle(title, body);
		}		
	}
	
	private Article writeArticle(String title, String body) {
		int id = ++this.lastArticleId;
		Article article = new Article(id, title, body);
		
		this.articles.add(article);
		
		return article;
	}

	@RequestMapping("/usr/article/doAdd")
	@ResponseBody
	public Article doAdd (String title, String body) {
		Article article = writeArticle(title,body);
		return article;
	}

	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {
		return this.articles;
	}

	private Article getArticleById(int id){
		for(Article article : articles) {
			if(article.getId() == id) {
				return article;
			}
		}
		return null;
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		Article article = getArticleById(id);
		if(article == null) {
			return id+"번 글이 없습니다.";
		}else {
			articles.remove(article);
		}
		return id+"번 글이 삭제되었습니다.";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public Object doModify(int id, String title, String body) {
		
		Article article = getArticleById(id);
		if(article == null) {
			return id+"번 글이 없습니다.";
		}else {
			article.setTitle(title);
			article.setBody(body);
			
		}
		return article;
	}
	
}

