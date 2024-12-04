package com.example.demo.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("payment")
public class payment {

	private int payment_number; 
	private Date  payment_date; 
	private String payment_title;
	private String payment_method;
	private String payment_agency;
	private int payment_price;
	private int payment_state; 
	private String payment_nickname;
	private String member_email;
	private int lesson_number; 
	
}
