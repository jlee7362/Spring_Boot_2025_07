package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserHomeController {
	int count = 0;
	
	@RequestMapping("/usr/home/setCountValue")
	@ResponseBody
	public String setCountValue(int value) {
		this.count = value;
		return "count값 "+value+"(으)로 설정.";
	}
	
	@RequestMapping("/usr/home/getCount")
	@ResponseBody
	public String getCount() {
		
		return ("count : " + this.count);
	}

	@RequestMapping("/usr/home/setCount")
	@ResponseBody
	public String setCount() {
		this.count = 0;
		return "count값 초기화";
	}
	
}
