package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ArticleRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public ResultData writeArticle(int memberId, String title, String body, String boardId) {
		articleRepository.writeArticle(memberId, title, body, boardId);
		int id = articleRepository.getLastInsertId();
		return ResultData.from("S-1", Ut.f("%d번 글이 등록되었습니다.", id),id, "등록된 게시글의 id");
	}

	public List<Article> getArticles() {
		return articleRepository.getArticles();
	}

	public Article getArticleById(int id) {
		Article article = articleRepository.getArticleById(id);
		
		return article;
	}
	
	public Article getForPrintArticle(int loginedMemberId, int id) {
		Article article = articleRepository.getForPrintArticle(id);
		
		controlForPrintData(loginedMemberId, article);
		
		return article;
	}
	

	private void controlForPrintData(int loginedMemberId, Article article) {
		if(article == null) {
			return;
		}
		ResultData userCanModifyRd = userCanModify(loginedMemberId, article);
		article.setUserCanModify(userCanModifyRd.isSuccess());
		
		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, article);
		article.setUserCanDelete(userCanDeleteRd.isSuccess());
		
	}

	public void modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
		
	}

	public ResultData userCanModify(int loginedMemberId, Article article) {
		if(article.getMemberId()!=loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 게시글 권한이 없음.", article.getId()));
		}
		
		return ResultData.from("S-1", Ut.f("%d번 게시글을 수정 됨", article.getId()));
	}

	public ResultData userCanDelete(int loginedMemberId, Article article) {
		if(article.getMemberId()!=loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 게시글 권한이 없음.", article.getId()));
		}
		
		return ResultData.from("S-1", Ut.f("%d번 게시글을 삭제 됨", article.getId()));
	}

	public List<Article> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword) {
//		limit 0, 10 1번부터 9번글까지. 1page
//		limit 10, 10
		int limitFrom = (page-1)*10;
		int limitTake = itemsInAPage;
		
		return articleRepository.getForPrintArticles(boardId, limitFrom, limitTake,searchKeywordTypeCode, searchKeyword);
	}

	public int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticleCount(boardId,searchKeywordTypeCode,searchKeyword);
	}

	public void increaseHitCount(int id) {
		articleRepository.increaseHitCount(id);
		
	}

}