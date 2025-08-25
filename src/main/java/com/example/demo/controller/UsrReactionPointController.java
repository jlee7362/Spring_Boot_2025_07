package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReactionPointService;
import com.example.demo.util.Ut;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrReactionPointController {
	
	@Autowired
    private ReactionPointService reactionPointService;
	
	@Autowired
	private Rq rq;

	@RequestMapping("/usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public String doGoodReaction(String relTypeCode, int relId, String replaceUri) {
		System.out.println("replaceUri : " + replaceUri);
		
		ResultData userReactionRd = reactionPointService.userCanReaction(rq.getLoginedMemberId(),relTypeCode, relId);
				
		int userReaction = (int)userReactionRd.getData1(); //-1: 싫어요, 0:반응안함, 1: 좋아요
		
		if(userReaction == 1) {
			//좋아요 이미 한 상태 -> 좋아요 취소
			reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(),relTypeCode, relId);
			return Ut.jsReplace("S-1", "좋아요 취소.",replaceUri);
		}
		if(userReaction == -1) {
			//이미 싫어요 한 상태
		}
		
		ResultData reactionRd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(),relTypeCode, relId);
		
		
		return Ut.jsReplace(reactionRd.getResultCode(), reactionRd.getMsg(), replaceUri);
		
	}
	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public String doBadReaction(String relTypeCode, int relId, String replaceUri) {
		System.out.println("replaceUri : " + replaceUri);
		
		ResultData userReactionRd = reactionPointService.userCanReaction(rq.getLoginedMemberId(),relTypeCode, relId);
				
		int userReaction = (int)userReactionRd.getData1(); //-1: 싫어요, 0:반응안함, 1: 좋아요
		
		if(userReaction == -1) {
			//싫어요 이미 한 상태 -> 좋아요 취소
			reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(),relTypeCode, relId);
			return Ut.jsReplace("S-1", "싫어요 취소.",replaceUri);
		}
		if(userReaction == 1) {
			//이미 좋아요 한 상태
		}
		
		ResultData reactionRd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(),relTypeCode, relId);
		
		
		return Ut.jsReplace(reactionRd.getResultCode(), reactionRd.getMsg(), replaceUri);
		
	}
	
}
