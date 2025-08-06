package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;

	public ResultData<Integer> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		
		// 로그인 중복체크
		Member existsMember = memberRepository.getMemberByLoginId(loginId);
		if(existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용 중인 아이디입니다.(%s)", loginId));
		}
		// 이름 + 이메일 중복체크 
		existsMember = memberRepository.getMemberByNameAndEmail(name, email);
		if(existsMember != null) {
			return ResultData.from("F-8", Ut.f("이름(%s)과 이메일(%s)이 중복되었습니다. 다시 입력하세요.", name, email));
		}
		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		int id = memberRepository.getLastInsertId();
		
		return ResultData.from("S-1", "회원가입 성공", id);
		
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
	
	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

}