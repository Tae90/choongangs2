package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Lesson;

@Mapper
public interface ClassModifyDAO {
	int insertClass(Lesson lesson);

	Lesson getLesson(int lesson_number);

	int updateClass(Lesson lesson);

	int deleteLesson(int lesson_number);
}
