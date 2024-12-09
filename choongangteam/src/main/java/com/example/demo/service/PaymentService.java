package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.PaymentDAO;
import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Payment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentService {
	
	 private final PaymentDAO dao;

	public int savePayment(Payment payment) {
		return dao.savePayment(payment);
	}
	
	public Lesson getLessonNumber(int lesson_number) {
		return dao.getLessonNumber(lesson_number);
	}

	public Member getMemberEmail(String member_email) {
		return dao.getMemberEmail(member_email);
	}
	
	public void updatePaymentState(int payment_number, int state) {
		dao.updatePaymentState(payment_number, state);
	}

}
