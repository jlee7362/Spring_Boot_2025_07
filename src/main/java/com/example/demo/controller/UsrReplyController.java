package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrReplyController {
	
	@Autowired
    private ReplyService replyService;
	
	@Autowired
	private Rq rq;

//	@RequestMapping("/usr/doReply")
//	@ResponseBody
//	public void doReply(String relTypeCode, int relId, int memberId, String body) {
//		
//		replyService.doReply(relTypeCode, relId, memberId, body);
//
//	}
	
	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(int relId, String relTypeCode, String body) {
//		System.out.println("relId : "+relId);
//		System.out.println("relTypeCode : "+relTypeCode);
//		System.out.println("body : "+body);
		if(Ut.isEmptyOrNull(body)) {
			return Ut.jsHistoryBack("F-1", "내용 입력하세요.");
		}
		ResultData writeReplyRd = replyService.doWrite(rq.getLoginedMemberId(),relId, relTypeCode, body);

		return Ut.jsReplace(writeReplyRd.getResultCode(), writeReplyRd.getMsg(), "../article/detail?id=" + relId);
		
	}
	
}
