package com.example.demo.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ArticleRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;
	@Autowired
	private Rq rq;

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
	
	public Article getForPrintArticle(int loginedMemberId, int id){
		
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

	public ResultData increaseHitCount(int id) {
		
		int affectedRow = articleRepository.increaseHitCount(id);
		
		if(affectedRow == 0) {
			return ResultData.from("F-1", "해당 게시글 없음ResultData", id, "id");
		}
		return ResultData.from("S-1", "조회수 증가", id, "id");
	}

	public Object getArticleHitCount(int id) {
		
		return articleRepository.getArticleHitCount(id);
	}

	public ResultData increaseGoodReactionPoint(int relId) {
		int affectedRow = articleRepository.increaseGoodReactionPoint(relId);
		
		if(affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시글");
			
		}
		return ResultData.from("S-1", "좋아요 증가");
		
	}

	public ResultData decreaseGoodReactionPoint(int relId) {
		int affectedRow = articleRepository.decreaseGoodReactionPoint(relId);
		
		if(affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시글");
			
		}
		return ResultData.from("S-1", "좋아요 감소");
	}

}