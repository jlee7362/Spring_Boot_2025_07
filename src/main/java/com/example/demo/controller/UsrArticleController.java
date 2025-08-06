package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;

import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {

	@Autowired
	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public ResultData<Integer> doModify(HttpSession session, int id, String title, String body) {
		// 로그인 체크
		boolean isLogined = false;
		int loginedMemberId = -1;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}
		if (isLogined == false) {
			return ResultData.from("F-A", "권한이 없습니다.");
		}

		Article article = articleService.getArticleById(id);
		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 글이 없습니다.", id));
		} else {
			articleService.modifyArticle(id, title, body);

		}
		article = articleService.getArticleById(id);

		return ResultData.from("S-1", Ut.f("%d번 글이 수정되었습니다.", id));
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public ResultData<Integer> doDelete(HttpSession session, int id) {

		// 로그인 체크
		boolean isLogined = false;
		int loginedMemberId = -1;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}
		if (isLogined == false) {
			return ResultData.from("F-A", "권한이 없습니다.");
		}

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 글이 없습니다.", id));
		} else {
			articleService.deleteArticle(id);
		}
		article = articleService.getArticleById(id);

		return ResultData.from("S-1", Ut.f("%d번 글이 삭제되었습니다.", id));
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData<Article> doWrite(HttpSession session, String title, String body) {
		// 로그인 체크
		boolean isLogined = false;
		int loginedMemberId = -1;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}
		if (isLogined == false) {
			return ResultData.from("F-A", "로그인하고 이용하세요.");
		}

		if (Ut.isEmptyOrNull(title)) {
			return ResultData.from("F-1", "제목을 입력하세요");
		}
		if (Ut.isEmptyOrNull(body)) {
			return ResultData.from("F-2", "내용을 입력하세요");
		}
		ResultData writeArticleRd = articleService.writeArticle(loginedMemberId, title, body);

		int id = (int) writeArticleRd.getData1();
		Article article = articleService.getArticleById(id);

		return ResultData.newData(writeArticleRd, article);
	}

	@RequestMapping("/usr/article/getArticle")
	@ResponseBody
	public ResultData<Article> getArticle(int id) {

		Article article = articleService.getArticleById(id);
		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시글은 없습니다.", id));
		}

		return ResultData.from("S-1", Ut.f("%d번 게시글입니다.", id), article);
	}

	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public ResultData<List<Article>> getArticles() {

		List<Article> articles = articleService.getArticles();

		return ResultData.from("S-1", "Article 목록", articles);
	}

}
