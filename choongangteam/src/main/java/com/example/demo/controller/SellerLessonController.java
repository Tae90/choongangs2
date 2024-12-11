package com.example.demo.controller;

import com.example.demo.model.UserSession;
import com.example.demo.service.SellerLessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class SellerLessonController {

    @Autowired
    private SellerLessonService sellerLessonService;

    @GetMapping("/mysales")
    public String mySalesPage(HttpSession session, Model model) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");
        if (userSession == null || userSession.getMember_number() != 1) { // 판매자 확인
            model.addAttribute("error", "권한이 없습니다.");
            return "error/403";
        }

        model.addAttribute("soldClasses", sellerLessonService.getSoldLessons(userSession.getEmail()));
        return "mysales";
    }
}
