package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.UserSession;
import com.example.demo.service.MypageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {
	 private final MypageService service; 
	
	@RequestMapping("mypage")
		public String mypage(Lesson lesson, Model model, @ModelAttribute Member member, HttpSession session) {
			
			
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		

		model.addAttribute("user", user);	
		
			return "mypage/mypage";
		}
	
	
	@RequestMapping("nickname_update")
		public String nickname_update(@ModelAttribute Member member, HttpSession session) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		
		
		
		return "mypage/mypage";
	}
	
	

}
