package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Controller
public class UsrMemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

		if (Ut.isEmptyOrNull(loginId)) {
			return ResultData.from("F-1","아이디를 입력하시오.");
		}
		if (Ut.isEmptyOrNull(loginPw)) {
			return ResultData.from("F-2","비밀번호를 입력하시오.");
		}
		if (Ut.isEmptyOrNull(name)) {
			return ResultData.from("F-3","이름을 입력하시오.");
		}
		if (Ut.isEmptyOrNull(nickname)) {
			return ResultData.from("F-4","닉네임을 입력하시오.");
		}
		if (Ut.isEmptyOrNull(cellphoneNum)) {
			return ResultData.from("F-5","전화번호를 입력하시오.");
		}
		if (Ut.isEmptyOrNull(email)) {
			return ResultData.from("F-6","이메일을 입력하시오.");
		}

		
		ResultData doJoinRd = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		if(doJoinRd.isFail()) {
			return doJoinRd;
		}
		Member member = memberService.getMemberById((int) doJoinRd.getData1());
		
		
//		int id = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
//
//		// 중복된 데이터 체크 알림
//		System.out.println("id : " + id);
//		if (id == -1) {
//			return Ut.f("이미 사용 중인 아이디입니다.(%s)", loginId);
//		}
//		if (id == -2) {
//			return Ut.f("이름(%s)과 이메일(%s)이 중복되었습니다. 다시 입력하세요.", name, email);
//		}
//
//		Member member = memberService.getMemberById(id);

		return ResultData.newData(doJoinRd, member);
	}

}