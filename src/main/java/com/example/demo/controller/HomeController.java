package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @RequestMapping("/usr/home/main")
    public String showMain() {
        return "/usr/home/main"; // → main.jsp가 열림
    }
    
    @RequestMapping("/")
    public String redirectShowMain() {
    	return "redirect:/usr/home/main"; // → main.jsp가 열림
    }
    
    
}
