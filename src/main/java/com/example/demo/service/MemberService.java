package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.vo.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberRepository memberRepository;
	
	public int doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		
		//아이디 중복체크
		Member existsMember = memberRepository.getMemberByLoginId(loginId);
		if(existsMember != null) {
			return -1;
		}
		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		return memberRepository.getLastInsertId();
	}
	
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}

}
