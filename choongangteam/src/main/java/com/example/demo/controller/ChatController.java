package com.example.demo.controller;

import com.example.demo.model.ChatLog;
import com.example.demo.model.MessageType;
import com.example.demo.service.ChatLogService;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import com.example.demo.model.UserSession;

@Controller
@RequiredArgsConstructor
public class ChatController {

    private final ChatLogService chatLogService;

    @GetMapping("/chat")
    public String chatPage(
            HttpSession session,
            Model model,
            @RequestParam(name = "payment_number", required = false) String roomId
    ) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");
        if (userSession == null) {
            return "redirect:/login";
        }

        String email = userSession.getEmail();

        // 채팅방 목록과 읽지 않은 메시지 개수
        List<Map<String, Object>> chatRooms = chatLogService.getChatRooms(email);
        Map<String, Integer> unreadCounts = chatLogService.getUnreadMessageCounts(email);

        model.addAttribute("chatRooms", chatRooms);
        model.addAttribute("unreadCounts", unreadCounts);

        // 특정 채팅방 읽음 상태 업데이트 및 메시지 로드
        if (roomId != null) {
            chatLogService.markMessagesAsRead(roomId, email); // 읽음 상태 업데이트
            List<ChatLog> chatLogs = chatLogService.findChatLogsByRoomId(roomId, userSession.getMember_number());
            model.addAttribute("chatLogs", chatLogs);
            model.addAttribute("roomId", roomId);
        } else {
            model.addAttribute("chatLogs", null);
        }

        return "chat";
    }




    @GetMapping("/chat/recentRoomId")
    @ResponseBody
    public String getMostRecentRoomId(HttpSession session) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");
        if (userSession == null) {
            return null; // 로그인되지 않은 경우
        }
        return chatLogService.getMostRecentRoomId(userSession.getEmail());
    }

    @GetMapping("/chat/unreadCount")
    @ResponseBody
    public Map<String, Integer> getUnreadMessageCount(HttpSession session) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");
        if (userSession == null) {
            return Map.of("unreadCount", 0); // 로그인되지 않은 경우 0 반환
        }
        String email = userSession.getEmail();
        int unreadCount = chatLogService.getTotalUnreadCount(email);
        return Map.of("unreadCount", unreadCount);
    }
    
    @GetMapping("/chat/unreadDot")
    @ResponseBody
    public boolean getUnreadDotStatus(HttpSession session) {
        UserSession userSession = (UserSession) session.getAttribute("userSession");
        if (userSession == null) {
            return false; // 로그인되지 않은 경우 빨간 점 표시하지 않음
        }
        String email = userSession.getEmail();
        int unreadCount = chatLogService.getTotalUnreadCount(email);
        return unreadCount > 0; // 읽지 않은 메시지가 있으면 true 반환
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