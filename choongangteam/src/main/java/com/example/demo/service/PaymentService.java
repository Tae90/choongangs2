package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.PaymentDAO;
import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Payment;
import com.example.demo.model.Reply;

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

	public Payment getPaymentNumber(int payment_number) {
		return dao.getPaymentNumber(payment_number);
	}

	public int updatePayment(Payment payment) {
		return dao.updatePayment(payment);
	}

	public List<Payment> getPaymentByBuyer(String member_email) {
		return dao.getPaymentByBuyer(member_email);
	}
	
	public List<Payment> getPaymentBySeller(String member_email) {
		return dao.getPaymentBySeller(member_email);
	}

	public Double getAvgReplyScore(int lesson_number) {
		return dao.getAvgReplyScore(lesson_number);
	}

	public void lessonCurrentApplyUpdate(int lesson_number) {
		dao.lessonCurrentApplyUpdate(lesson_number);
	}


	
}
