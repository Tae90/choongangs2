package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MypageDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageService {
	
	private final  MypageDAO dao;
	

}
