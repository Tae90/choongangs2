package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Payment;
import com.example.demo.service.PaymentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class PaymentController {
	
	private final PaymentService paymentservice;
	
	@RequestMapping("/paymentdetail")
	public String paymentdetail(HttpSession session, Model model) {
	    
		return "paymentdetail";
	}
	
	
	@RequestMapping("/paymentform")
	public String paymentform(@RequestParam(value="lesson_number", required=false) int lesson_number,
	        				  @RequestParam(value="member_email", required=false) String member_email,
	        				  HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("member"); // 세션에서 회원 정보 가져오기
	    Lesson lesson = (Lesson) session.getAttribute("lesson"); // 세션에서 레슨 정보 가져오기

	    // 데이터가 없으면 리다이렉트
	    if (member == null || lesson == null) {
	        return "redirect:/paymentform"; // 데이터가 없으면 결제 페이지로 리다이렉트
	    }

	    model.addAttribute("member", member);
	    model.addAttribute("lesson", lesson);
		 
		return "payment";
	}	
	
	@RequestMapping("/save_payment")
	public String savePayment(@RequestBody Payment payment,
							 @RequestParam("lesson_number") int lesson_number,
							 @RequestParam("member_email") String member_email,
							 Model model) {
		
		System.out.println("payment in");
		System.out.println("payment_title:"+ payment.getPayment_title());
		System.out.println("payment_price:"+ payment.getPayment_price());
		System.out.println("payment_price:"+ payment.getPayment_nickname());
		System.out.println("member_email:"+ member_email);
		System.out.println("lesson_number:"+ lesson_number);
			
		// Payment 객체에 추가 정보를 설정
        payment.setLesson_number(lesson_number);
        payment.setMember_email(member_email);
        
        model.addAttribute("lesson_number", lesson_number);
        model.addAttribute("member_email", member_email);
        
        // 닉네임, 레슨명, 가격
		
        // 결제 정보 저장
		paymentservice.savePayment(payment);
		
		return "redirect:/paymentform";
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
