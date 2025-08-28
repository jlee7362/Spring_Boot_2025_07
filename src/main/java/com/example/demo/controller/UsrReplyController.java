package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReplyService;
import com.example.demo.vo.Rq;

@Controller
public class UsrReplyController {
	
	@Autowired
    private ReplyService replyService;
	
	@Autowired
	private Rq rq;

	@RequestMapping("/usr/doReply")
	@ResponseBody
	public void doReply(String relTypeCode, int relId, int memberId, String body) {
		
		replyService.doReply(relTypeCode, relId, memberId, body);

	}
	
	
}
