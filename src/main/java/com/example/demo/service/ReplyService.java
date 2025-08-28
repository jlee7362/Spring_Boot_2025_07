package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ReplyRepository;
import com.example.demo.vo.Reply;

@Service
public class ReplyService {
	@Autowired
	private  ReplyRepository replyRepository;

	public List<Reply> getForPrintReplies(String relTypeCode, int id) {
		List<Reply> replies = replyRepository.getForPrintReplies(relTypeCode,id);
		return replies;
	}

}
