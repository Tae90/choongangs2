package com.example.demo.controller;

import com.example.demo.model.ChatLog;
import com.example.demo.model.MessageType;
import com.example.demo.service.ChatLogService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import com.example.demo.model.UserSession;

@Controller
@RequiredArgsConstructor
public class ChatController {

    private final ChatLogService chatLogService;

    @GetMapping("/chat")
    public String chatPage(HttpSession session, Model model, @RequestParam("payment_number") String paymentNumber) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");
        if (userSession == null) {
            return "redirect:/login"; // 로그인되지 않았다면 로그인 페이지로 리다이렉트
        }

        // 채팅 기록 가져오기 (memberNumber 값 추가)
        List<ChatLog> chatLogs = chatLogService.findChatLogsByRoomId(paymentNumber, userSession.getMember_number());

        model.addAttribute("nickname", userSession.getNickname());
        model.addAttribute("roomId", paymentNumber);
        model.addAttribute("chatLogs", chatLogs);

        return "chat";
    }




    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatLog sendMessage(@Payload ChatLog chatLog, SimpMessageHeaderAccessor headerAccessor) {
        UserSession userSession = (UserSession) headerAccessor.getSessionAttributes().get("userSession");
        if (userSession == null) {
            throw new IllegalStateException("User session not found in WebSocket session.");
        }

        String senderEmail = userSession.getEmail();
        chatLog.setSenderEmail(senderEmail);

        String senderNickname;
        String receiverEmail;
        String receiverNickname;

        if (userSession.getMember_number() == 0) { // 구매자 -> 판매자
            senderNickname = chatLogService.getPaymentNicknameByPaymentNumber(chatLog.getRoomId());
            String lessonNumber = chatLogService.getLessonNumberByPaymentNumber(chatLog.getRoomId());
            receiverEmail = chatLogService.getLessonMemberEmail(lessonNumber);
            receiverNickname = chatLogService.getMemberNicknameByEmail(receiverEmail);
        } else { // 판매자 -> 구매자
            senderNickname = chatLogService.getMemberNicknameByEmail(senderEmail);
            receiverEmail = chatLogService.getPaymentMemberEmail(chatLog.getRoomId());
            receiverNickname = chatLogService.getPaymentNicknameByPaymentNumber(chatLog.getRoomId());
        }

        // 값 검증
        if (receiverEmail == null || senderNickname == null || receiverNickname == null) {
            throw new IllegalArgumentException("Required nickname or email cannot be found.");
        }

        // 최종 값 설정
        chatLog.setSenderNickname(senderNickname);
        chatLog.setReceiverEmail(receiverEmail);
        chatLog.setReceiverNickname(receiverNickname);

        chatLogService.saveChatLog(chatLog); // 메시지 저장
        return chatLog;
    }



    @MessageMapping("/chat.addUser")
    public void addUser(@Payload ChatLog chatLog, SimpMessageHeaderAccessor headerAccessor) {
        // WebSocket 세션에 UserSession 설정
        UserSession userSession = (UserSession) headerAccessor.getSessionAttributes().get("userSession");
        if (userSession == null) {
            throw new IllegalStateException("User session not found.");
        }

        // 세션에 사용자 이메일 저장
        headerAccessor.getSessionAttributes().put("email", userSession.getEmail());
    }

}
