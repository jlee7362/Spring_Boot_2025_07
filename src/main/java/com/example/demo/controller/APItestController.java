package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class APItestController {
	@RequestMapping("/usr/home/APItest")
	public String showAPITest() {
		return "/usr/home/APItest";
	}
	@RequestMapping("/usr/home/APItest2")
	public String showAPITest2() {
		return "/usr/home/APItest2";
	}
	
}