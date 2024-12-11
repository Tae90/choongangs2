package com.example.demo.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.model.ChatMessage;
import com.example.demo.model.UserSession;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {
	
	
	@GetMapping("/chat")
	public String chatPage(HttpSession session, Model model) {
	    UserSession userSession = (UserSession) session.getAttribute("userSession");
	    if (userSession == null) {
	        return "redirect:/login"; // 로그인되지 않았다면 로그인 페이지로 리다이렉트
	    }

	    // UserSession의 nickname을 모델에 추가
	    model.addAttribute("nickname", userSession.getNickname());
	    return "chat"; // chat.jsp 반환
	}

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessage sendMessage(
            @Payload ChatMessage chatMessage
    ) {
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessage addUser(
            @Payload ChatMessage chatMessage,
            SimpMessageHeaderAccessor headerAccessor
    ) {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage;
    }
}