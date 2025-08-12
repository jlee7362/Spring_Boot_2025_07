package com.example.demo.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class NeedLogoutInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		Rq rq = (Rq)request.getAttribute("rq");
		
		if(rq.isLogined()) {
			System.out.println("로그아웃 하고 사용하세요. NeedLogoutInterceptor");
			rq.printHistoryBack("로그아웃 하고 사용하세요. NeedLogoutInterceptor");
		}
		
//		Rq rq = (Rq) request.getAttribute("rq");
//		if (rq.isLogined() == false) { // 로그인 안된 상태.
//
//			rq.printHistoryBack("로그인 하고 이용하세요.");
//
//			return false;
//		}

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

}
