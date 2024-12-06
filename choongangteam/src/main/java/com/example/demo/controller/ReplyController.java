package com.example.demo.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.nio.charset.MalformedInputException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.demo.model.Member;
import com.example.demo.model.Reply;
import com.example.demo.model.UserSession;
import com.example.demo.service.LoginService;
import com.example.demo.service.ReplyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ReplyController {
	
	@Autowired
	private final ReplyService service;
	
	
	// 리뷰 페이지로 이동
	@RequestMapping("/reply")
	public String comment() {
		System.out.println("comment page in");
		
		return "/reply/reply";
	}
	
	// 리뷰 리스트 출력
	@RequestMapping("/reply_list")
	public String comment_list(
							   Model model) {
		System.out.println("comment_list in");
		
		List<Reply> clist = service.commentList(123);
		System.out.println(clist);
		
		model.addAttribute("clist", clist);
				
		return "/reply/reply_list";
	}
	
	
	// 리뷰 등록
	@RequestMapping("/reply_insert")
	public String comment_insert(@ModelAttribute Reply reply){
		
		System.out.println("comment_insert in");
		
		System.out.println("comment : " + reply);
		
		System.out.println("score : " + reply.getReply_score());
		System.out.println("content : " + reply.getReply_content());
		
		
		
		int result = service.insert(reply);
		
		if(result == 1) System.out.println("리뷰등록 성공");
	
		return "";
	}
	
		// 리뷰 중복 확인
		@RequestMapping("/reply_check")
		@ResponseBody
		public int reply_check(@ModelAttribute Reply reply){
			
			System.out.println("reply_check in");
			System.out.println("reply : "+reply);
			
			int result = service.replycheck(reply.getMember_email());
			
			System.out.println("result : " + result);
								
			return result;
		}
	
		
		
		
	
	
}
