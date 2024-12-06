package com.example.demo.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.nio.charset.MalformedInputException;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Member;
import com.example.demo.model.UserSession;
import com.example.demo.service.JoinService;
import com.example.demo.service.LoginService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class JoinController {
	private final JoinService join_service;
	private final LoginService login_service;
	
	// 회원가입 페이지 이동
	@RequestMapping("/join")
	public String join() {
		System.out.println("join in");
		
		return "/join/join";
	}
	
	// 사용가능한 이메일인지 체크
	@RequestMapping("/member_emailcheck")
	@ResponseBody
	public int member_emailcheck(@RequestParam(value = "member_email") String member_email) {
		System.out.println("member_emailcheck in");
		System.out.println("member_email : " + member_email);
		
		int result = join_service.emailcheck(member_email);
				
		System.out.println("result : " + result);
		return result;
	}
	
	// db에 회원정보 삽입	
	@RequestMapping("/member_join")
	public String member(@ModelAttribute Member member, 
						 HttpSession session,
						 Model model) {
		
		System.out.println("member in");
		
		UserSession userSession = new UserSession();

		
		System.out.println("email : " + member.getMember_email());
		System.out.println("nickname : " + member.getMember_nickname());
		System.out.println("password : " + member.getMember_password());
		
		
		// 회원가입 정보 삽입
		join_service.insert(member);
		
		// 세션 생성		
		userSession.setEmail(member.getMember_email());
		userSession.setNickname(member.getMember_nickname());
		userSession.setUser_photo(member.getMember_photo());
		session.setAttribute("userSession", userSession);
			
		
		return "";
	}
	
	
}
