package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ReactionPointRepository;
import com.example.demo.vo.ResultData;

@Service
public class ReactionPointService {
	
	@Autowired
    private ArticleService articleService;
	@Autowired
	private ReactionPointRepository reactionPointRepository;
	

    ReactionPointService(ArticleService articleService) {
        this.articleService = articleService;
    }

	public ResultData userCanReaction(int loginedMemberId, String relTypeCode, int relId) {
		//로그인 안한 상태
		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 해야 반응할 수 있어");
		}
		
		 int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPoint(loginedMemberId,relTypeCode,relId);
		 
		 if (sumReactionPointByMemberId != 0) {
			 return ResultData.from("F-1", "추천 불가능", sumReactionPointByMemberId, "sumReactionPointByMemberId");
		 }
		return ResultData.from("S-1", "추천 가능", sumReactionPointByMemberId, "sumReactionPointByMemberId");
	}

	public ResultData increaseReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		
		int affectedRow = reactionPointRepository.increaseReactionPoint(loginedMemberId,relTypeCode,relId);
		
		if(affectedRow != 1) {
			return ResultData.from("F-2", "좋아요 실패.");
			
		}
		
		switch (relTypeCode){
		case "article" : 
			articleService.increaseGoodReactionPoint(relId);
			break;
		}
		
		return ResultData.from("S-1", "좋아요.");
	}

	public ResultData deleteGoodReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.deleteReactionPoint(loginedMemberId,relTypeCode,relId);
		switch(relTypeCode) {
		case "article" :
			articleService.decreaseGoodReactionPoint(relId);
			break;
		
		}
		return ResultData.from("S-1", "좋아요 취소됨.");
	}

}
