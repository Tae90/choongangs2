package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.JoinDAO;
import com.example.demo.dao.LoginDAO;
import com.example.demo.model.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JoinService{
	private final JoinDAO dao;

	public int insert(Member member) {
		return dao.insert(member);	
	}

	public int emailcheck(String email) {
		return dao.emailcheck(email);
	}

	public int usercheck(Member member) {
		return dao.usercheck(member);
	}
	
	
}
