package com.example.demo.controller;

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
import com.example.demo.service.PaymentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class PaymentController {
   
   private final PaymentService paymentservice;
   
   @RequestMapping("/paymentdetail")
   public String paymentdetail(@RequestParam("lesson_number") int lesson_number,
		   					   HttpSession session, Model model) {
      	   
	    String member_email = (String)session.getAttribute("email");
       
	    // 125는 임의의 값
        model.addAttribute("lesson_number", 125);
      
      return "paymentdetail";
   }
   
   
   @RequestMapping("/paymentform")
   public String paymentform(@RequestParam("lesson_number") int lesson_number,
                       		HttpSession session, Model model) {
      	   
	   UserSession userSession = (UserSession) session.getAttribute("userSession");
     	   
	   Lesson lesson = paymentservice.getLessonNumber(lesson_number);
	   Member member = paymentservice.getMemberEmail(userSession.getEmail()); 
	                     
       model.addAttribute("lesson", lesson);
       model.addAttribute("member", member);
       
       return "payment";
   }   
   
   @PostMapping("/save_payment")
   @ResponseBody
   public Integer savePayment(@RequestBody Payment payment, 
                              HttpSession session, Model model) {
      
	   System.out.println("payment in");
	   System.out.println("payment:"+ payment);	  	   
	   
      UserSession userSession = (UserSession) session.getAttribute("userSession");
      Lesson lesson = paymentservice.getLessonNumber(payment.getLesson_number());
      
       // 결제 정보 저장
       int result = 0;
       result = paymentservice.savePayment(payment);
            
       return result;
   }
   
   @PostMapping("/save_payment/cancel")
   @ResponseBody
   public String cancelPayment(@RequestBody Payment payment,
		   						HttpSession session, Model model) {
      
      // 결제 취소 상태 설정
      payment.setPayment_state(0); // 0: 결제 취소
      
      // 취소 데이터 업데이트
      paymentservice.updatePaymentState(payment.getPayment_number(), payment.getPayment_state());
      
      return "결제 취소";
   }
   

}
