package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MypageDAO;
import com.example.demo.model.Favorite;
import com.example.demo.model.Member;
import com.example.demo.model.Reply;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageService {
	
	private final  MypageDAO dao;

	public void updatenickname(Member member1) {
	
		dao.updatenickname(member1);
	}

	public void updateprofileimg(Member member1) {
		
		 dao.updateprofileimg(member1); 
	}

	public List<Favorite> myfavorite(Favorite fav) {
		
		return dao.myfavorite(fav);
	}

	public int totalmyfav(Favorite fav) {
		
		return dao.totalmyfav(fav);
	}

	public List<Reply> myreview(Reply rep) {
		
		return dao.myreview(rep);
	}





	

}
