package com.example.demo.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.ChatMessage;

@Controller
public class ChatController {
	
	@RequestMapping("/WebSocket")
	 public String getWebSocketPage() {
	        // /WEB-INF/views/sample.jsp를 반환
	        return "WebSocket";
	}
	
	@MessageMapping("/controller.sendMessage")
	@SendTo("/topic/public")
	public ChatMessage sendMessage(
			@Payload ChatMessage chatMessage
			) {
		return chatMessage;
	}
	
	@MessageMapping("/controller.adduser")
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