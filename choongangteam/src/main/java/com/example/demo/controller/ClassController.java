package com.example.demo.controller;

import com.example.demo.service.MyClassService;
import com.example.demo.service.SellerLessonService;
import com.example.demo.model.UserSession;
import com.example.demo.model.Payment;
import com.example.demo.model.SellerLesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ClassController {

    @Autowired
    private MyClassService myClassService;

    @Autowired
    private SellerLessonService sellerLessonService;

    @GetMapping("/classPage")
    public String classPage(HttpSession session, Model model) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");

        if (userSession == null) {
            return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }

        if (userSession.getMember_number() == 0) { // 구매자
            List<Payment> purchasedClasses = myClassService.getPurchasedClasses(userSession.getEmail());
            model.addAttribute("purchasedClasses", purchasedClasses);
            return "myclass"; // myclass.jsp로 이동
        } else if (userSession.getMember_number() == 1) { // 판매자
            List<SellerLesson> soldClasses = sellerLessonService.getSoldLessons(userSession.getEmail());
            model.addAttribute("soldClasses", soldClasses);
            return "mysales"; // mysales.jsp로 이동
        }

        return "error/403"; // 권한이 없을 경우
    }
}
