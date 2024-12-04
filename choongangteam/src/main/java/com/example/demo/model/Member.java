package com.example.demo.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member")
public class Member {
	
	private String member_email;
	private String member_nickname;
	private String member_password;
	private String member_photo;
	private int member_number;
	private Date member_date;
	
}
