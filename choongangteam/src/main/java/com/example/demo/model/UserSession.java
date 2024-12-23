package com.example.demo.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("userSession")
public class UserSession {
	private String email;
	private String nickname;
	private String user_photo;
	
	private int member_number;
}
