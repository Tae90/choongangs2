package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ClassRegisterDAO;
import com.example.demo.model.Lesson;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClassRegisterService {
	private final ClassRegisterDAO dao;

	public int insertClass(Lesson lesson) {
		return dao.insertClass(lesson);
	}
}
