package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Favorite;
import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Reply;

@Mapper
public interface MypageDAO {

	void updatenickname(Member member1);

	void updateprofileimg(Member member1);

	List<Favorite> myfavorite(Favorite fav);

	int totalmyfav(Favorite fav);

	List<Reply> myreview(Reply rep);

	void deleteMember(String pass);

	List<Lesson> myclass(Lesson les);





}
