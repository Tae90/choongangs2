package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Favorite;
import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Reply;
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
	
	 // 회원정보 불러오기
	@RequestMapping("mypage")
		public String mypage(Lesson lesson, Model model, @ModelAttribute Member member, HttpSession session) {
			
			
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		

		model.addAttribute("user", user);	
		
			return "mypage/mypage";
		}
	
	// 닉네임 변경
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
	
	// 프로필 사진변경
	@RequestMapping("profileimg_update")
		public String profileimg_update(@ModelAttribute Member member, HttpSession session , Model model) {
		
		UserSession userSession1 = (UserSession) session.getAttribute("userSession");		
		
		Member member1 = new Member();
		
		member1.setMember_email(userSession1.getEmail());
		member1.setMember_nickname(member.getMember_photo());	
		
		 service.updateprofileimg(member1); 
		 
		 
		 session.removeAttribute("userSession");
		  
		 UserSession userSession = new UserSession();
		 userSession.setEmail(userSession1.getEmail());
		 userSession.setNickname(userSession1.getNickname());
		 userSession.setUser_photo(member.getMember_photo());
		 userSession.setMember_number(userSession1.getMember_number());
		 
		 session.setAttribute("userSession", userSession);
		 
		 System.out.println("변경 후 세션 : "+userSession);
		
		
		return "redirect:/mypage";
	}
	
	
	@RequestMapping("favoritelist")
	public String favoritelist(Favorite favorite, Model model, @ModelAttribute Member member, HttpSession session, Lesson lesson) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		String useremail = user.getEmail();	
		System.out.println("유저 이메일:"+useremail);
		
		Favorite fav = new Favorite();
		fav.setMember_email(useremail);
		
	
		int total = service.totalmyfav(fav);
		System.out.println("찜을 누른 클래스 수 : "+total);
		
		
		List<Favorite> favoritelist = service.myfavorite(fav);
		System.out.println("내가 찜한 클래스 :"+favoritelist);
		
		model.addAttribute("user", user);	
		model.addAttribute("total" , total);
		model.addAttribute("favoritelist" , favoritelist);
		
		return "mypage/favoritelist";
	}
	
	
	
	@RequestMapping("reviews")
	public String reviews(Reply reply , Model model, @ModelAttribute Member member, HttpSession session, Lesson lesson) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		String useremail = user.getEmail();	
		
		
		Reply rep = new Reply();
		rep.setMember_email(useremail);
		
		List <Reply> myreview = service.myreview(rep);
		System.out.println("내가 리뷰한 클래스:"+myreview);
		
		
		model.addAttribute("user", user);	
		model.addAttribute("myreview", myreview);	
		
		return "mypage/myreview";
	}

}
