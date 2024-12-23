package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.FavoriteDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FavoriteService {
	
	private final FavoriteDAO dao;

	public boolean addFavorite(String member_email, int lesson_number) {
		return dao.addFavorite(member_email, lesson_number) > 0;
	}

	public boolean removeFavorite(String member_email, int lesson_number) {
		return dao.removeFavorite(member_email, lesson_number) > 0;
	}

	public boolean isFavorite(String member_email, int lesson_number) {
		return dao.isFavorite(member_email, lesson_number) > 0;
	}

	public void plusFavoriteCount(int lesson_number) {
		dao.plusFavoriteCount(lesson_number);
	}

	public void minusFavoriteCount(int lesson_number) {
		dao.minusFavoriteCount(lesson_number);
	}

	public int getFavoriteCount(int lesson_number) {
		return dao.getFavoriteCount(lesson_number);
	}
}
