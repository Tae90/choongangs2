package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MainpageDAO;
import com.example.demo.model.lesson;
import com.example.demo.model.subcategory;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainpageService {
	
	private final  MainpageDAO dao;

	public List<lesson> bestclass(lesson lesson) {
		
		return dao.bestclass(lesson);
	}

	public List<subcategory> subcatelist(int maincate_num) {
		
		return dao.subcatelist(maincate_num);
	}

	
	

}
