package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface FavoriteDAO {

	int addFavorite(@Param("member_email")String member_email, @Param("lesson_number")int lesson_number);

	int removeFavorite(@Param("member_email")String member_email, @Param("lesson_number")int lesson_number);

	int isFavorite(@Param("member_email")String member_email, @Param("lesson_number")int lesson_number);

}
