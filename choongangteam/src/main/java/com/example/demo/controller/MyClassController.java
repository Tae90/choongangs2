package com.example.demo.controller;

import com.example.demo.service.MyClassService;
import com.example.demo.model.UserSession;
import com.example.demo.model.Payment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MyClassController {

    @Autowired
    private MyClassService myClassService;

    @GetMapping("/myclass")
    public String myClassPage(HttpSession session, Model model) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");

        if (userSession == null || userSession.getMember_number() != 0) { // Ensure the user is a buyer
            model.addAttribute("error", "권한이 없습니다.");
            return "error/403";
        }

        List<Payment> purchasedClasses = myClassService.getPurchasedClasses(userSession.getEmail());
        model.addAttribute("purchasedClasses", purchasedClasses);

        return "myclass";
    }
}
