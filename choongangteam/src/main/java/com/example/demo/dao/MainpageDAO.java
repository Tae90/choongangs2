package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Lesson;
import com.example.demo.model.Subcategory;

@Mapper
public interface MainpageDAO {

	List<Lesson> bestclass(Lesson lesson);

	List<Subcategory> subcatelist(int maincate_num);


	List<Lesson> cateclass(Map<String, Object> params);


	  List<Lesson> getLessons(HashMap map);

	List<Lesson> searchclass(Map<String, Object> params);
			  


}
