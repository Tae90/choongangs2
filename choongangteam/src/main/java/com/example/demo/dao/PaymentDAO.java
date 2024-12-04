package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Payment;

@Mapper
public interface PaymentDAO {

	void savePayment(Payment payment);

	Lesson getLessonNumber(@Param("lesson_number")int lesson_number);

	Member getMember(@Param("member_email")String member_email);

	void updatePaymentState(@Param("payment_number")int payment_number, @Param("state")int state);
	
}
