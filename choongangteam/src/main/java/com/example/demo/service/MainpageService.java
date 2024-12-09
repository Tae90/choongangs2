package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MainpageDAO;
import com.example.demo.model.Lesson;
import com.example.demo.model.Subcategory;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainpageService {
	
	private final  MainpageDAO dao;

	public List<Lesson> bestclass(Lesson lesson) {
		
		return dao.bestclass(lesson);
	}

	public List<Subcategory> subcatelist(int maincate_num) {
		
		return dao.subcatelist(maincate_num);
	}

	

	public List<Lesson> cateclass(Map<String, Object> params) {
		
		return dao.cateclass(params);
	}

	
	 public List<Lesson> getLessons(HashMap map) {
	        return dao.getLessons( map);
	    }
	 
	 

	public List<Lesson> searchclass(Map<String, Object> params) {
		
		return dao.searchclass(params);
	}




	
	

}
