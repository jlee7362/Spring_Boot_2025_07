package com.example.demo.interceptor;



import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
//		System.out.println("인터셉터 실행 부분");
		
		Rq rq = new Rq(request);
		request.setAttribute("rq", rq);
		
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
	
}