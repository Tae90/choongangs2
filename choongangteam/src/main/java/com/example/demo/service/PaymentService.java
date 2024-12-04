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

	public void savePayment(Payment payment) {
		dao.savePayment(payment);
	}

	public Lesson getLessonNumber(int lesson_number) {
		return dao.getLessonNumber(lesson_number);
	}

	public Member getMember(String member_email) {
		return dao.getMember(member_email);
	}

	public void updatePaymentState(int payment_number, int state) {
		dao.updatePaymentState(payment_number, state);
	}


	 
}
