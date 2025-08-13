package com.example.demo.interceptor;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {
	
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
//		System.out.println("인터셉터 실행 부분");
//		Rq rq = new Rq(request, response);
		System.out.println("로그인 중임?"+rq.isLogined());
		request.setAttribute("rq", rq);
		rq.initBeforeActionInterceptor();
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
	
}