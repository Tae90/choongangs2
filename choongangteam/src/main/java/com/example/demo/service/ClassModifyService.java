package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ClassModifyDAO;
import com.example.demo.model.Lesson;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClassModifyService {
	private final ClassModifyDAO dao;
	
	public int insertClass(Lesson lesson) {
		return dao.insertClass(lesson);
	}

	public Lesson getLesson(int lesson_number) {
		return dao.getLesson(lesson_number);
	}

	public int updateClass(Lesson lesson) {
		return dao.updateClass(lesson);
	}

	public int deleteLesson(int lesson_number) {
		return dao.deleteLesson(lesson_number);
	}
}
