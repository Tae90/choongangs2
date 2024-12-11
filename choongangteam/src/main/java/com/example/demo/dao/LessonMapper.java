package com.example.demo.dao;

import com.example.demo.model.Lesson;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface LessonMapper {
    List<Lesson> findLessonsBySellerEmail(String email);
}
