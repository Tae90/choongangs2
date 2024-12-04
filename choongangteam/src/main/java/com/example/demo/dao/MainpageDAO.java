package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.lesson;
import com.example.demo.model.subcategory;

@Mapper
public interface MainpageDAO {

	List<lesson> bestclass(lesson lesson);

	List<subcategory> subcatelist(int maincate_num);

}
