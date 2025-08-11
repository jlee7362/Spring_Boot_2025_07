package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
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
	public ResultData doModify(HttpServletRequest req, int id, String title, String body) {
		// 로그인 체크
	
		Rq rq = new Rq(req);
		if(rq.isLogined() == false) {
			return ResultData.from("F-A", "로그인 하고 오세요.");
		}

		Article article = articleService.getArticleById(id);
		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 글이 없습니다.", id));
		}

		// 권한 체크
		ResultData userCanModify = articleService.userCanModify(rq.getLoginedMemberId(), article);

		if (userCanModify.getResultCode().startsWith("F")) {
			return ResultData.from("F-A", userCanModify.getMsg());
		}
		articleService.modifyArticle(id, title, body);

		article = articleService.getArticleById(id);

		return ResultData.from(userCanModify.getResultCode(), userCanModify.getMsg(), article,
				"수정한 글");
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {

		// 로그인 체크
		Rq rq = new Rq(req);
		if(rq.isLogined() == false) {
			return Ut.jsReplace("F-A", "로그인 하고 오세요.", "../member/login");
		}

		Article article = articleService.getArticleById(id);

		if (article == null) {
//			return ResultData.from("F-1", Ut.f("%d번 글이 없습니다.", id));
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글이 없습니다.", id));
		}

		// 권한 체크
		ResultData userCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

		if (userCanDeleteRd.getResultCode().startsWith("F")) {
//			return ResultData.from("F-A", userCanDelete.getMsg());
			return Ut.jsHistoryBack("F-A", userCanDeleteRd.getMsg());
		}

		articleService.deleteArticle(id);

//		return ResultData.from("S-1", Ut.f("%d번 글을 삭제했습니다.", id));
		return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../article/list");
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData<Article> doWrite(HttpServletRequest req, String title, String body) {
		// 로그인 체크
		Rq rq = new Rq(req);
		if(rq.isLogined() == false) {
			return ResultData.from("F-A", "로그인하고 이용하세요.");
		}

		if (Ut.isEmptyOrNull(title)) {
			return ResultData.from("F-1", "제목을 입력하세요");
		}
		if (Ut.isEmptyOrNull(body)) {
			return ResultData.from("F-2", "내용을 입력하세요");
		}
		ResultData writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body);

		int id = (int) writeArticleRd.getData1();
		Article article = articleService.getArticleById(id);

		return ResultData.newData(writeArticleRd, article, "새로 작성한 글");
	}

	@RequestMapping("/usr/article/detail")
	public String getArticle(HttpServletRequest req, int id, Model model) {

		Rq rq = new Rq(req);

	Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

	model.addAttribute("article",article);
	
	return"/usr/article/detail";
	}

	@RequestMapping("/usr/article/list")
	public String getArticles(Model model) {

		List<Article> articles = articleService.getArticles();

		model.addAttribute("articles",articles);
		
		return "/usr/article/list";
	}

}
