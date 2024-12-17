package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.UserSession;
import com.example.demo.service.FavoriteService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class FavoriteController {

	private final FavoriteService favoriteservice;
	
	// 찜 추가
	@PostMapping("/favorite/add")
	@ResponseBody
	public boolean addFavorite(@RequestParam("lesson_number") int lesson_number,
							   HttpSession session) {
		
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		if (userSession == null) {
	        return false; 
	    }
		
		String member_email = userSession.getEmail();
		boolean result = favoriteservice.addFavorite(member_email, lesson_number);
		
		// favorite_count 증가 확인
		if(result) {
			favoriteservice.plusFavoriteCount(lesson_number);
		}
		
		return result;
	}
	
	// 찜 감소
	@PostMapping("/favorite/remove")
	@ResponseBody
	public boolean removeFavorite(@RequestParam("lesson_number")int lesson_number,
								  HttpSession session) {
		
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		if (userSession == null) {
	        return false;
	    }
		
		String member_email = userSession.getEmail();
		boolean result = favoriteservice.removeFavorite(member_email, lesson_number);
		
		// favorite_count 감소 확인
		if(result) {
			favoriteservice.minusFavoriteCount(lesson_number);
		}
			
		return result;
	}
	
	// 찜 상태 확인
	@PostMapping("/favorite/check")
	@ResponseBody
	public boolean getFavorite(@RequestParam("lesson_number")int lesson_number,
								   HttpSession session) {
		
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		String member_email = userSession.getEmail();
		
		return favoriteservice.isFavorite(member_email, lesson_number);
	}
	
	// 찜 횟수 실시간 반영
	@PostMapping("/favorite/count")
	@ResponseBody
	public int getFavoriteCount(@RequestParam("lesson_number")int lesson_number) {
		
		return favoriteservice.getFavoriteCount(lesson_number);
	}
	
}
