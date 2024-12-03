package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.PaymentDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentService {
	
	private final PaymentDAO dao;
	 
}
