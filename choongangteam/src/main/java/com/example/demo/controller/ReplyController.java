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

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
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
	@RequestMapping("/test")
	public String comment() {
		System.out.println("comment page in");
		
		
		return "/test";
	}
	
	// 리뷰 페이지로 이동
	@RequestMapping("/reply")
	public String comment(@RequestParam("lesson_number") int lesson_number,
						  Model model) {
		System.out.println("comment page in");
		
		model.addAttribute("lesson_number", lesson_number);
		
		return "/reply/reply";
	}
	
	// 리뷰 리스트 출력
	@RequestMapping("/reply_list")
	public String comment_list(@RequestParam(name ="page", defaultValue = "0") int page,
							   @RequestParam(name = "size", defaultValue = "4") String size,
							   @RequestParam("lesson_number") int lesson_number,
							   Model model) {
		System.out.println("comment_list in");
		
		System.out.println("lesson_number : "+lesson_number);
		
		// 글넘버에 댓글들 불러오기
		List<Reply> clist = service.commentList(Integer.toString(lesson_number));
		System.out.println(clist);
		
		model.addAttribute("clist", clist);
		model.addAttribute("lesson_number", lesson_number);
				
		return "/reply/reply_list";
	}
	
	@GetMapping("/loadMoreReply")
	@ResponseBody
	public List<Reply> loadMoreReply(@RequestParam ("page") int page,
									 @RequestParam("lesson_number") int lesson_number,
									 @RequestParam("loadedReplyNum") List<Integer> loadedReplyNum){
		
		System.out.println("loadedReply in");
		System.out.println("page : "+ page);
		System.out.println("lesson_number : " + lesson_number);
		
		int pageSize = 4;
		int offset = (page - 1) * pageSize;
		
		
		HashMap map = new HashMap();
		map.put("lesson_number", lesson_number);
		map.put("limit", 5);
		map.put("offset", offset);
		map.put("loadedReplyNum", loadedReplyNum);
		
		System.out.println("map : " + map);
		
		List<Reply> reply = service.getReply(map);
		System.out.println("reply : "+ reply);
		
		return reply;
	}
	
	
	
	// 리뷰 등록
	@RequestMapping("/reply_insert")
	public String comment_insert(@ModelAttribute Reply reply){
		
		System.out.println("comment_insert in");
		
		System.out.println("comment : " + reply);
		
		System.out.println("score : " + reply.getReply_score());
		System.out.println("content : " + reply.getReply_content());	
		
		
		int result = service.insert(reply);
		
		int result1 = service.addCount(reply.getLesson_number());
		if(result1 == 1) System.out.println("reply count + 1");
				
		if(result == 1) System.out.println("리뷰등록 성공");
	
		return "redirect:paymentdetail?lesson_number="+reply.getLesson_number();
	}
	
	// 리뷰 중복 확인
	@RequestMapping("/reply_check")
	@ResponseBody
	public int reply_check(@ModelAttribute Reply reply){
			
		System.out.println("reply_check in");
		System.out.println("reply : "+reply);
		
		int result = service.replycheck(reply);
		
		System.out.println("result1 : " + result);

		
		int pcheck = service.pcheck(reply);
		
		if (pcheck == 0) result = 2;
		
		System.out.println("result2 : " + result);
								
		return result;
	}
	
	
	// 리뷰 삭제
	@RequestMapping("/reply_delete")
	public String reply_delete(@RequestParam("reply_number") int reply_number,
							   @RequestParam("lesson_number") int lesson_number) {
		System.out.println("reply_delete in");
		
		
		System.out.println("reply_number : " + reply_number);
		
		service.replyDelete(reply_number);
		int result = service.deleteCount(lesson_number);
		if (result == 1)System.out.println("reply count -1");
		
		return "redirect:paymentdetail?lesson_number="+lesson_number;
	}
		
	
	
}
