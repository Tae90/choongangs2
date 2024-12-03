package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.PaymentService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class PaymentController {
	
	private final PaymentService paymentservice;
    
	@RequestMapping("/payment")
	public String payment() {
		return "payment";
	}
	
	@RequestMapping("/paymentdetail")
	public String paymentdetail() {
		return "paymentdetail";
	}
	

}
