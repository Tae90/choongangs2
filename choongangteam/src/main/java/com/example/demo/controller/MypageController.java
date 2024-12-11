package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.UserSession;
import com.example.demo.service.LoginService;
import com.example.demo.service.MypageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {
	 private final MypageService service; 
	 private final LoginService login_service;
	
	@RequestMapping("mypage")
		public String mypage(Lesson lesson, Model model, @ModelAttribute Member member, HttpSession session) {
			
			
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		

		model.addAttribute("user", user);	
		
			return "mypage/mypage";
		}
	
	
	@RequestMapping("nickname_update")
		public String nickname_update(@ModelAttribute Member member, HttpSession session , Model model) {
		
	
		 UserSession userSession1 = (UserSession) session.getAttribute("userSession");
		
		
		Member member1 = new Member();
		
		member1.setMember_email(userSession1.getEmail());
		member1.setMember_nickname(member.getMember_nickname());
		
	
		 
		 service.updatenickname(member1);
		 
		 session.removeAttribute("userSession");
		 
		
		 
		 UserSession userSession = new UserSession();
		 userSession.setEmail(userSession1.getEmail());
		 userSession.setNickname(member.getMember_nickname());
		 userSession.setUser_photo(userSession1.getUser_photo());
		 userSession.setMember_number(userSession1.getMember_number());
		 
		 session.setAttribute("userSession", userSession);
		 
		 System.out.println("변경 후 세션 : "+userSession);
		
		
		
		return "redirect:/mypage";
	}
	
	

}
