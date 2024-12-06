package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.model.lesson;
import com.example.demo.model.subcategory;

@Mapper
public interface MainpageDAO {

	List<lesson> bestclass(lesson lesson);

	List<subcategory> subcatelist(int maincate_num);


	List<lesson> cateclass(Map<String, Object> params);


	  List<lesson> getLessons(HashMap map);
			  


}
