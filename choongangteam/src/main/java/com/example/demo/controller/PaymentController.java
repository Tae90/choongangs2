package com.example.demo.controller;

import java.util.Map;

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

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class PaymentController {
	
	private final PaymentService paymentservice;
	
	@RequestMapping("/paymentform")
	public String paymentform(@RequestParam int lesson_number,
							  @RequestParam String member_email,
							  Model model) {
		
		// 레슨 데이터 조회
        Lesson lesson = paymentservice.getLessonNumber(lesson_number);
        if (lesson != null) {
            model.addAttribute("lesson", lesson);
        }
        
        // 회원 데이터 조회
        Member member = paymentservice.getMember(member_email);
        if (member != null) {
            model.addAttribute("member", member);
        }
		
		return "payment";
	}	
	
	@RequestMapping("/save_payment")
	public String savePayment(@RequestBody Payment payment, Model model) {
		
		System.out.println("payment in");
		System.out.println("payment_title:"+ payment.getPayment_title());
		System.out.println("payment_title:"+ payment.getPayment_price());
		System.out.println("payment_title:"+ payment.getMember_email());
							        
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
	
	@RequestMapping("/paymentdetail")
	public String paymentdetail() {
		
		return "paymentdetail";
	}
	

}
