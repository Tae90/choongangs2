package com.example.demo.service;

import com.example.demo.dao.SellerLessonMapper;
import com.example.demo.model.SellerLesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SellerLessonService {

    @Autowired
    private SellerLessonMapper sellerLessonMapper;

    public List<SellerLesson> getSoldLessons(String email) {
        return sellerLessonMapper.findSoldLessonsBySeller(email);
    }
}
