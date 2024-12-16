package com.example.demo.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.nio.charset.MalformedInputException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.mail.HtmlEmail;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.example.demo.model.Member;
import com.example.demo.model.UserSession;
import com.example.demo.service.JoinService;
import com.example.demo.service.LoginService;
import com.example.demo.service.OAuthService;
import com.fasterxml.jackson.databind.JsonNode;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class LoginController {
	private final LoginService login_service;
	private final JoinService join_service;
	private final OAuthService auth_service;
	
	
	
	// 로그인 선택창
	@RequestMapping("/loginpage")
	public String loginpage() {
		System.out.println("login page in");
		return "/login/login";
	}
	
	// 이메일로 로그인 페이지
	@RequestMapping("/email_loginpage")
	public String email_loginpage() {
		System.out.println("email_loginpage in");
		return "/login/email_loginpage";
	}
	
	// 회원, 비밀번호 체크
	@RequestMapping("/member_check")
	@ResponseBody
	public int password_check(@ModelAttribute Member member) {
		System.out.println("member_check in");
		System.out.println("user : " + member);
		
		int result = join_service.emailcheck(member.getMember_email());
		
		if(result == 1) {
			Member dbmember = login_service.getMember(member);
			System.out.println("dbpass : " + dbmember.getMember_password());
			System.out.println("userpass : " + member.getMember_password());
			
			if(!dbmember.getMember_password().equals(member.getMember_password())) {
				result = 2;
			}
		}
		
		System.out.println("result : " + result);
				
		return result;
	}
	
	
	
	
	// 이메일로 로그인
	@RequestMapping("email_login")
	public String email_login(@ModelAttribute Member member,
            				  Model model,
            				  HttpSession session) {
		System.out.println("email_login in");
		
		System.out.println(member);
		
		int result = join_service.usercheck(member);
		
		Member dbmember = login_service.getMember(member);
		
		UserSession userSession = new UserSession();
		userSession.setEmail(dbmember.getMember_email());
		userSession.setNickname(dbmember.getMember_nickname());
		userSession.setUser_photo(dbmember.getMember_photo());
		userSession.setMember_number(dbmember.getMember_number());

		session.setAttribute("userSession", userSession);
		
		System.out.println("로그인 세션값 : " + userSession);
		
		
		
		return "redirect:/mainpage";		
	}
	
	
	@RequestMapping("/kakao_login")
	public String kakao_login() {
		System.out.println("kakao_login in");
		
		return "/login/kakao_login";
	}

	// 카카오로 로그인 후 콜백으로 코드값을 받는다
	@RequestMapping("/kakaoCallback")
	public String naverCallback(@RequestParam("code") String code,
								Model model,
								HttpSession session){
		System.out.println("kakaoCallback in");
				
		System.out.println("code : " + code);
		
		// 카카오에서 전달받은 코드를 이용해 토큰을 발급받기
		String token = auth_service.getKakaoAccessToken(code);
		
		System.out.println("사용자 정보 : "+ auth_service.getUserInfo(token));
		
		// 발급 받은 토큰으로 사용자 정보조회를 요청
		HashMap<String, String>  userInfo = auth_service.getUserInfo(token);
		
		String email = userInfo.get("id");
		String nickname = userInfo.get("nickname");
		
		System.out.println("email : "+ email);
		System.out.println("nickname : "+ nickname);
		
		Member member = new Member();
		member.setMember_email(email);
		member.setMember_nickname(nickname);
		
		// 로그인한 정보로 비회원인지 회원인지 체크 
		int result = join_service.usercheck(member);
		
		// 비회원이면 db에 회원정보 삽입
		if (result == 0 ) {
			System.out.println("미가입 회원입니다.");
			join_service.insert(member);			
		} 
		
		// 세션생성
		UserSession userSession = new UserSession();
		
		userSession.setEmail(member.getMember_email());
		userSession.setNickname(member.getMember_nickname());
		userSession.setUser_photo(member.getMember_photo());
		userSession.setMember_number(member.getMember_number());
		session.setAttribute("userSession", userSession);
		
		System.out.println("로그인 세션값 : " + userSession);
		
		
		return "redirect:/mainpage";		
	}
	
	@RequestMapping("/naverlogin")
	public String naverlogin() {
		System.out.println("naverlogin in");
		
		return "/login/naver_login";
	}
	
	@RequestMapping("/naverCallback")
    public String naverLogin(){
        System.out.println("naverCallback in");
        
        
        return "login/naver_login";
    }
	
	@RequestMapping("/naverLogin_result")
    @ResponseBody
    public String loginNaverUser(@ModelAttribute Member member,
                                Model model,
                                HttpSession session){
		System.out.println("loginNaverUser in");
		
		System.out.println(member);
		
		int result = join_service.usercheck(member);
		
		UserSession userSession = new UserSession();
		
		if (result == 0) {
			System.out.println("미가입 회원");
			join_service.insert(member);
		}
		
		userSession.setEmail(member.getMember_email());
		userSession.setNickname(member.getMember_nickname());
		userSession.setUser_photo(member.getMember_photo());
		userSession.setMember_number(member.getMember_number());
		session.setAttribute("userSession", userSession);
		
		System.out.println("로그인 세션값 : " + userSession);
    
	return "{ \"status\": \"success\", \"redirectUrl\": \"/mainpage\"}";
	}	
	
	
	// 비밀번호 찾기로 이동
	@RequestMapping("/find_pass")
	public String find_pass() {
		System.out.println("find_pass in");		
		
		return "/login/find_pass";
	}
	
	// 비밀번호 찾기
	@RequestMapping("/find_pass_ok")
	public String find_pass_ok(@RequestParam(value = "member_email") String email, 
							   Model model) {
		System.out.println("find_pass_ok in");
		
		
		String pass = login_service.findpass(email);
		
		System.out.println("pass : "+ pass);
		
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "chokiw1371@naver.com";
		String hostSMTPpwd = "Chlrldnjs!2"; // 비밀번호 입력해야함

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "chokiw1371@naver.com";
		String fromName = "관리자";
		String subject = "비밀번호 찾기";

		try {
			HtmlEmail sendemail = new HtmlEmail();
			sendemail.setDebug(true);
			sendemail.setCharset(charSet);
			sendemail.setSSL(true);
			sendemail.setHostName(hostSMTP);
			sendemail.setSmtpPort(587);

			sendemail.setAuthentication(hostSMTPid, hostSMTPpwd);
			sendemail.setTLS(true);
			sendemail.addTo(email, charSet);
			sendemail.setFrom(fromEmail, fromName, charSet);
			sendemail.setSubject(subject);
			sendemail.setHtmlMsg("<p align = 'center'>비밀번호 찾기</p><br>" + "<div align='center'> 비밀번호:"
					+ pass + "</div>");
			sendemail.send();
		} catch (Exception e) {
			System.out.println(e);
		}
			
		
		
		return "/login/find_pass_ok";
	}
	
	
		// 비밀번호 찾기로 이동
		@RequestMapping("/switchMode")
		public String switchMode(HttpSession session,
								 RedirectAttributes redirectAttributes) {
			System.out.println("switchMode in");		
			
		    UserSession userSession = (UserSession) session.getAttribute("userSession");
		    
		    if (userSession.getMember_number() == 0) {
		        userSession.setMember_number(1);
		        session.setAttribute("userSession", userSession); // 변경된 값 저장
		        redirectAttributes.addFlashAttribute("message", "튜터 모드입니다.");
		        System.out.println("member_number : " + userSession.getMember_number());
		    } else if (userSession.getMember_number() == 1) {
		        userSession.setMember_number(0);
		        session.setAttribute("userSession", userSession); // 변경된 값 저장
		        redirectAttributes.addFlashAttribute("message", "튜티 모드입니다.");
		        System.out.println("member_number : " + userSession.getMember_number());
		    }
			
			
			
			return "redirect:/mainpage";
		}
		
		@PostMapping("/check-login")
		@ResponseBody
		public boolean checkLogin(HttpSession session) {
			
			UserSession userSession = (UserSession) session.getAttribute("userSession");
			
			return userSession != null;
		}
	
	
	
	
	
	
}
