package com.example.demo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Payment;
import com.example.demo.model.Reply;
import com.example.demo.model.UserSession;
import com.example.demo.service.IamportService;
import com.example.demo.service.PaymentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class PaymentController {
   
   private final PaymentService paymentservice;
   private final IamportService iamportservice;
   
   @RequestMapping("/paymentdetail")
   public String paymentdetail(@RequestParam("lesson_number") int lesson_number,
		   					   HttpSession session, Model model) {
      
	   UserSession userSession = (UserSession) session.getAttribute("userSession");
	   Lesson lesson = paymentservice.getLessonNumber(lesson_number);
	   Double avgReplyScore = paymentservice.getAvgReplyScore(lesson_number);
	   
	   // 모집 마감 여부 계산
	   boolean applyCount = lesson.getLesson_currentapply() >= lesson.getLesson_apply();
	   
	   // 소수점 첫째 자리로 포맷팅
	   String AverageScore = String.format("%.1f", avgReplyScore);
	    
      model.addAttribute("lesson", lesson);
      model.addAttribute("avgReplyScore", AverageScore);
      model.addAttribute("user", userSession);
      model.addAttribute("applyCount", applyCount);
      model.addAttribute("lesson_number", lesson_number);
      
      return "payment/paymentdetail";
   }
   
   
   @RequestMapping("/paymentform")
   public String paymentform(@RequestParam("lesson_number") int lesson_number,
                       		HttpSession session, Model model) {
      	   
	   UserSession userSession = (UserSession) session.getAttribute("userSession");
     	   
	   Lesson lesson = paymentservice.getLessonNumber(lesson_number);
	   Member member = paymentservice.getMemberEmail(userSession.getEmail());
	                     
       model.addAttribute("lesson", lesson);
       model.addAttribute("member", member);
       
       return "payment/payment";
   }   
   
   @PostMapping("/save_payment")
   @ResponseBody
   public Integer savePayment(@RequestBody Payment payment, HttpSession session) {
      
	   System.out.println("payment in");
	   System.out.println("payment:"+ payment);	  	   
	   
      UserSession userSession = (UserSession) session.getAttribute("userSession");
      Lesson lesson = paymentservice.getLessonNumber(payment.getLesson_number());
      
      // 결제 정보 저장
      int result = paymentservice.savePayment(payment);
            
       return result;
   }
   
   @RequestMapping("/paymentcancel")
   public String paymentList(HttpSession session, Model model) {
	   
	   UserSession userSession = (UserSession)session.getAttribute("userSession");
	   String nickname = userSession.getNickname();
	   
	   if (userSession.getMember_number() == 0) {
	       
		   // 구매자 데이터
	       String buyer_email = userSession.getEmail();
	       List<Payment> buyer_paymentList = paymentservice.getPaymentByBuyer(buyer_email);
	        
	       System.out.println("buyer_paymentList:" + buyer_paymentList);
	 	   System.out.println("buyer_email:" + buyer_email);
	        
	       model.addAttribute("buyer_paymentList", buyer_paymentList);
	       model.addAttribute("mode", "buyer");		// 구매자 모드
	   
	   }else if(userSession.getMember_number() == 1) {
		   
		   // 판매자 데이터
		   String seller_email = userSession.getEmail();	   
		   List<Payment> seller_paymentList = paymentservice.getPaymentBySeller(seller_email);
		   
		   System.out.println("seller_paymentList:" + seller_paymentList);
		   System.out.println("seller_email:" + seller_email);
		   
		   model.addAttribute("seller_paymentList", seller_paymentList);
		   model.addAttribute("mode", "seller");	// 판매자 모드
	   }
	   
	   model.addAttribute("user", userSession);
	   model.addAttribute("nickname", nickname);
	   	   
	   return "payment/paymentcancel";
   }
   
   
   @RequestMapping("/save_payment/cancel")
   @ResponseBody
   public Integer cancelPayment(@RequestBody Payment payment, 
		   						HttpSession session) throws IOException {
	   
	  UserSession userSession = (UserSession)session.getAttribute("userSession");
	  String member_email = userSession.getEmail();
	  
	  Payment paymentInfo = paymentservice.getPaymentNumber(payment.getPayment_number());
	  if (paymentInfo == null) {
	        throw new IllegalArgumentException("결제 정보를 찾을 수 없습니다.");
	    }
  
	  // 아임포트 결제 취소 요청
	  String imp_uid = paymentInfo.getPayment_imp_uid();
	  String reason = "사용자 요청";
	  String token = iamportservice.getAccessToken();
	  
	  int amount = paymentInfo.getPayment_price();
	  
	  System.out.println("token : " + token);

	  String iamportCancel = iamportservice.cancelPayment(token, imp_uid, reason, amount);
	  	  
      // 결제 취소 상태 설정
	  paymentInfo.setPayment_state(0); // 0: 결제 취소
	  int result = paymentservice.updatePayment(paymentInfo);
	  	  
      return result;

   }
   

}
