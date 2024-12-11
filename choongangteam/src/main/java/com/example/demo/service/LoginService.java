package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.LoginDAO;
import com.example.demo.model.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {
	private final LoginDAO dao;

	
	public String findpass(String email) {
		return dao.findpass(email);
	}


	public Member getMember(Member member) {
		return dao.getMember(member);
	}




	
}
