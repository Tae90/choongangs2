package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MypageDAO;
import com.example.demo.model.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageService {
	
	private final  MypageDAO dao;

	public void updatenickname(Member member) {
	
		dao.updatenickname(member);
	}





	

}
