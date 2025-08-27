package com.example.demo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrArticleController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ReactionPointService reactionPointService;
	@Autowired
	private Rq rq;

	UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) throws IOException {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		
		if(article == null) {
			rq.printHistoryBack(Ut.f("%d번 글은 없습니다.", id));
			return null;
		}

		model.addAttribute("article",article);
		return "/usr/article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {
		// 로그인 체크
//		Rq rq = (Rq)req.getAttribute("rq");

		Article article = articleService.getArticleById(id);
		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글이 없습니다.", id));
		}

		// 권한 체크
		ResultData userCanModify = articleService.userCanModify(rq.getLoginedMemberId(), article);

		if (userCanModify.getResultCode().startsWith("F")) {
			return Ut.jsHistoryBack("F-A", userCanModify.getMsg());
		}
		articleService.modifyArticle(id, title, body);

		article = articleService.getArticleById(id);

		return Ut.jsReplace(userCanModify.getResultCode(), userCanModify.getMsg(),"../article/detail?id="+id);
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		// 로그인 체크
//		Rq rq = (Rq)req.getAttribute("rq");
		

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

	@RequestMapping("/usr/article/write")
	public String showWrite() {
		
		return "/usr/article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, String boardId) {

		if (Ut.isEmptyOrNull(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력하세요");
		}
		if (Ut.isEmptyOrNull(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력하세요");
		}
		if (Ut.isEmptyOrNull(boardId)) {
			return Ut.jsHistoryBack("F-3", "게시판을 선택하세요");
		}
		System.out.println("boardId: " + boardId);
		
		ResultData writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

		int id = (int) writeArticleRd.getData1();
		Article article = articleService.getArticleById(id);

		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id="+id);
	}

	@RequestMapping("/usr/article/detail")
	public String getArticle(int id, Model model){
	
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
	
		//-1은 싫어요, 0 표현 안 함, 1 좋아요, -2 로그인 안함.
		ResultData userCanReactionRd = reactionPointService.userCanReaction(rq.getLoginedMemberId(), "article", id);
		
		model.addAttribute("isLogined", rq.isLogined());
		model.addAttribute("article",article);
		model.addAttribute("isAlreadyAddGoodRp",reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
		model.addAttribute("isAlreadyAddBadRp",reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));
	
	return"/usr/article/detail";
	}
	
	@RequestMapping("/usr/article/hitCount")
	@ResponseBody
	public ResultData doincreaseHitCountRd(int id) throws IOException {
		
		ResultData increaseHitCountRd = articleService.increaseHitCount(id);
		
		if(increaseHitCountRd.isFail()) {
			rq.printHistoryBack(increaseHitCountRd.getMsg());
			return null;
		}
//		return ResultData.newData(increaseHitCountRd, articleService.getArticleHitCount(id), "hitCouint");
		return ResultData.from(increaseHitCountRd.getResultCode(), increaseHitCountRd.getMsg(), articleService.getArticleHitCount(id),"hitCount", id, "articleId");
		
		
	}

	@RequestMapping("/usr/article/list")
	public String getArticles(Model model,@RequestParam(defaultValue = "0")int boardId, @RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "title")String searchKeywordTypeCode, @RequestParam(defaultValue = "")String searchKeyword) throws IOException {

		int articlesCount = articleService.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);
		int itemsInAPage =  10;
		int pagesCount = (int)Math.ceil(articlesCount/(double)itemsInAPage);
		
		List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page,searchKeywordTypeCode, searchKeyword);
		
		Board board = null;
		if(boardId != 0) {
			board = boardService.getBoardById(boardId);
		
		if(board == null) {
			rq.printHistoryBack("존재하지 않는 게시판");
			return null;
			}
		}
		
		
		model.addAttribute("articlesCount",articlesCount);
		model.addAttribute("page",page);
		model.addAttribute("searchKeywordTypeCode",searchKeywordTypeCode);
		model.addAttribute("searchKeyword",searchKeyword);
		
		model.addAttribute("boardId",boardId);
		model.addAttribute("articles",articles);
		model.addAttribute("pagesCount",pagesCount);
		model.addAttribute("board",board);
		
		return "/usr/article/list";
	}

}
