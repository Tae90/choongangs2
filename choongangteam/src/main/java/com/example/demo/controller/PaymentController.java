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
      	   
	    Lesson lesson = paymentservice.getLessonNumber(lesson_number);
	    
        model.addAttribute("lesson", lesson);
      
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
	   
	   String member_email = userSession.getEmail();
	   System.out.println("member_email: " + member_email);
	   
	   List<Payment> paymentList = paymentservice.getPaymentMemberEmail(member_email);
	   System.out.println("paymentList:" + paymentList);
	   
	   model.addAttribute("paymentList", paymentList);
	   
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
	  
	  System.out.println("token : " + token);
	  
	  int amount = paymentInfo.getPayment_price();
	  
	  String result = iamportservice.cancelPayment(token, imp_uid, reason, amount);
	  
	  System.out.println("취소결과 : " + result);
	  
	  if (result.equals(200)) {
	  // 결제 취소 상태 설정
		  paymentInfo.setPayment_state(0); // 0: 결제 취소
		  paymentservice.updatePayment(paymentInfo);      
	  }
      return 0;
   }
   

}
