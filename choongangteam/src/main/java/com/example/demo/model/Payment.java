package com.example.demo.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("payment")
public class Payment {

	private int payment_number;			// 결제 번호(주문 번호)(pk)
	private Date payment_date;			// 결제 날짜
	private String payment_title;		// 레슨 이름
	private String payment_method;		// 결제 수단
	private String payment_agency;		// 결제 대행사
	private int payment_price;			// 가격
	private int payment_state;			// 결제 상태(결제 완료:0, 결제 취소:1)
	private String payment_nickname;	// 회원 닉네임
	private String member_email;		// 회원 이메일(fk)
	private int lesson_number;			// 레슨 번호(fk)
}
