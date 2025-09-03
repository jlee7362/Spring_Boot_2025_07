package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ReplyRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;

@Service
public class ReplyService {
	@Autowired
	private  ReplyRepository replyRepository;

	public List<Reply> getForPrintReplies(String relTypeCode, int id) {
		List<Reply> replies = replyRepository.getForPrintReplies(relTypeCode,id);
		return replies;
	}

	public ResultData doWrite(int memberId, int relId, String relTypeCode, String body) {
		
		replyRepository.doWrite(memberId, relId, relTypeCode, body);
		
		int id = replyRepository.getLastInsertId();
		
		return ResultData.from("S-1", Ut.f("%d번 댓글이 등록되었습니다.", id), id, "등록 된 댓글의 아이디");
	}

	public Reply getReplyById(int id) {
		Reply reply = replyRepository.getReplyById(id);
		return reply;
	}

	public ResultData userCanDelete(int loginedMemberId, Reply reply) {
		if(reply.getMemberId()!=loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 댓글 권한이 없음.", reply.getId()));
		}
		
		return ResultData.from("S-1", Ut.f("%d번 댓글을 삭제 됨", reply.getId()));
		 
	}

	public void deleteReply(int id) {
		replyRepository.deleteReply(id);
		
	}

}
