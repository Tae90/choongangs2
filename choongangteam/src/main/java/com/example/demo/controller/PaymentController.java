package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
   public String paymentdetail(@RequestParam("lesson_number")  int lesson_number, HttpSession session, Model model) {
      

//      Lesson lesson = paymentservice.getLessonNumber(lesson_number);
//      lesson.setLesson_number(123456);
//      lesson.setLesson_price(1000);
//      lesson.setLesson_title("나만의 베이킹 만들기");
//      
//      Member member = paymentservice.getMemberEmail(member_email);
//      member.setMember_email("test@naver.com");
//      member.setMember_nickname("manwoman");
//      
//      System.out.println("lesson_number: " + lesson_number);
//      System.out.println("member_email: " + member_email);
//      
//       session.setAttribute("lesson", lesson);
//       session.setAttribute("member", member);
	   
	    String member_email = (String)session.getAttribute("email");
       
        model.addAttribute("lesson_number", 125);
//      model.addAttribute("lesson_number", lesson_number);
//      model.addAttribute("member_email", member_email);
      
      return "paymentdetail";
   }
   
   
   @RequestMapping("/paymentform")
   public String paymentform(@RequestParam(value = "lesson_number", required = false) int lesson_number,
//                       		@RequestParam(value = "member_email", required = false) String member_email,
                       		HttpSession session, Model model) {
      	   
//      Lesson lesson = new Lesson();
//      lesson.setLesson_number(126);
//      lesson.setLesson_price(1000);
//      lesson.setLesson_title("나만의 향수공방 만들기");
//
//      Member member = new Member();
//      member.setMember_email("ziastar@naver.com");
//      member.setMember_nickname("이이이");
      
//      Lesson lesson = (Lesson) session.getAttribute("lesson");
	   UserSession userSession = (UserSession) session.getAttribute("userSession");
//       
//       if (lesson == null || member == null) {
//           return "redirect:/paymentdetail";
//       }
	   
	   Lesson lesson = paymentservice.getLessonNumber(lesson_number);
	   Member member = paymentservice.getMemberEmail(userSession.getEmail()); 
	  
//      session.setAttribute("lesson", lesson);
//      session.setAttribute("member", member);
                   
       model.addAttribute("lesson", lesson);
       model.addAttribute("member", member);
       
      return "payment";
   }   
   
   @PostMapping("/save_payment")
   public Integer savePayment(@RequestBody Payment payment, @RequestParam("lesson_number") int lesson_number,
                             HttpSession session, Model model) {
      
	   System.out.println("payment in");
	   System.out.println("payment:"+ payment);	  	   
	   
	   
	   System.out.println("lesson_number:"+ lesson_number);
	   System.out.println("lesson_number:"+ lesson_number);		   
	   
      
      UserSession member = (UserSession) session.getAttribute("userSession");
      Lesson lesson = paymentservice.getLessonNumber(lesson_number);
      
       payment.setLesson_number(lesson.getLesson_number());
       payment.setMember_email(member.getEmail());
       payment.setPayment_title(lesson.getLesson_title());
       payment.setPayment_price(lesson.getLesson_price());
       payment.setPayment_nickname(member.getNickname());

       System.out.println("Updated Payment: " + payment);
      
        // 결제 정보 저장
      paymentservice.savePayment(payment);
      
      
//      return "redirect:/paymentdetail?lesson_number=125";
      
      return 1;
   }
   
   @RequestMapping("/save_payment/cancel")
   public String cancelPayment(@RequestBody Payment payment) {
      
      // 결제 취소 상태 설정
      payment.setPayment_state(0); // 0: 결제 취소
      
      // 취소 데이터 업데이트
      paymentservice.updatePaymentState(payment.getPayment_number(), payment.getPayment_state());
      
      return "결제 취소";
   }
   

}
