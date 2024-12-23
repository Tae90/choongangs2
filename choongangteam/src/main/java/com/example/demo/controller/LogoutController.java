package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@CrossOrigin(origins = "*")
public class LogoutController {
	@RequestMapping("/logout1")
	public String logout(HttpSession session, Model model) {
		System.out.println("logout");
		session.invalidate(); // 세션 무효화하여 로그아웃 처리
		model.addAttribute("result", 1); // 로그아웃 성공 여부를 모델에 추가
		return "logout"; // 로그아웃 JSP 페이지로 이동
	}
	
}
