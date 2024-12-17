package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Payment;
import com.example.demo.model.Reply;

@Mapper
public interface PaymentDAO {

	int savePayment(Payment payment);
		    
	Lesson getLessonNumber(@Param("lesson_number") int lesson_number);

	Member getMemberEmail(@Param("member_email") String member_email);

	Payment getPaymentNumber(@Param("payment_number") int payment_number);

	int updatePayment(Payment paymentcancel);

	List<Payment> getPaymentByBuyer(@Param("member_email") String member_email);
	
	List<Payment> getPaymentBySeller(@Param("member_email") String member_email);

	Double getAvgReplyScore(@Param("lesson_number") int lesson_number);

	void lessonCurrentApplyUpdate(@Param("lesson_number") int lesson_number);

	void lessonCurrentApplyDrop(@Param("lesson_number") int lesson_number);



	
}
