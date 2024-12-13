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
	
	@PostMapping("/favorite/add")
	@ResponseBody
	public boolean addFavorite(@RequestParam("lesson_number") int lesson_number,
							   HttpSession session) {
		
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		if (userSession == null) {
	        return false;
	    }
		
		String member_email = userSession.getEmail();
				
		return favoriteservice.addFavorite(member_email, lesson_number);
	}
	
	@PostMapping("/favorite/remove")
	@ResponseBody
	public boolean removeFavorite(@RequestParam("lesson_number")int lesson_number,
								  HttpSession session) {
		
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		if (userSession == null) {
	        return false;
	    }
		
		String member_email = userSession.getEmail();
			
		return favoriteservice.removeFavorite(member_email, lesson_number);
	}
	
	@PostMapping("/favorite/check")
	@ResponseBody
	public boolean getFavorite(@RequestParam("lesson_number")int lesson_number,
								   HttpSession session) {
		
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		String member_email = userSession.getEmail();
		
		return favoriteservice.isFavorite(member_email, lesson_number);
	}
	
}
