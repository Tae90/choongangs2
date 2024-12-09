package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Lesson;

@Mapper
public interface ClassRegisterDAO {

	int insertClass(Lesson lesson);
}
