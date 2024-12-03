package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.SampleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SampleService {
	
	private final  SampleMapper dao;
	

}
