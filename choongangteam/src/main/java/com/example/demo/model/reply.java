package com.example.demo.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("reply")
public class reply {

	private int reply_number;
	private String reply_content; 
	private Date write_date;
	private int reply_score; 
	private String member_email;
	private int lesson_number;
	
}
