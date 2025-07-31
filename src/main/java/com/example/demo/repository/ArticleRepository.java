package com.example.demo.repository;



import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.example.demo.vo.Article;

@Component
public class ArticleRepository {

	public int lastArticleId;
	public List<Article> articles;

	public ArticleRepository() {
		this.lastArticleId = 0;
		this.articles = new ArrayList<>();
	}

	public Article writeArticle(String title, String body) {
		int id = ++this.lastArticleId;

		Article article = new Article(id, title, body);
		this.articles.add(article);

		return article;
	}

	public Article getArticleById(int id) {
		for (Article article : articles) {
			if (article.getId() == id) {
				return article;
			}
		}
		return null;
	}

	public List<Article> getArticles() {
		return articles;
	}

	public Object modifyArticle(int id, String title, String body) {
		
		Article article = getArticleById(id);
		article.setTitle(title);
		article.setBody(body);
		
		return null;
		
	}

	public void deleteArticle(int id) {
		Article article = getArticleById(id);
		articles.remove(article);
	}

}
