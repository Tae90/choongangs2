package com.example.demo.service;

import com.example.demo.dao.LessonMapper;
import com.example.demo.dao.MemberMapper;
import com.example.demo.dao.PaymentMapper;
import com.example.demo.model.Lesson;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MySalesService {

    @Autowired
    private LessonMapper lessonMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private MemberMapper memberMapper;

    public List<Lesson> getSoldClasses(String email) {
        return lessonMapper.findLessonsBySellerEmail(email);
    }
}
