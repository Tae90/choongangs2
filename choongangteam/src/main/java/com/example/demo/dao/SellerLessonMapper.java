package com.example.demo.dao;

import com.example.demo.model.SellerLesson;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SellerLessonMapper {
    List<SellerLesson> findSoldLessonsBySeller(@Param("email") String email);
}