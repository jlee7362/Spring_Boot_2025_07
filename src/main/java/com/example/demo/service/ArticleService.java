package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.vo.Article;

@Service
public class ArticleService {
	private int lastArticleId;
	public List<Article> articles;
	
	public ArticleService() {

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
	
	public Article writeArticle(String title, String body) {
		int id = ++this.lastArticleId;
		Article article = new Article(id, title, body);
		
		this.articles.add(article);
		
		return article;
	}
	
	public Article getArticleById(int id){
		for(Article article : articles) {
			if(article.getId() == id) {
				return article;
			}
		}
		return null;
	}
	
	
}
