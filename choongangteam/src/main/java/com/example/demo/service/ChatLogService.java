package com.example.demo.service;

import com.example.demo.dao.ChatLogMapper;
import com.example.demo.model.ChatLog;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ChatLogService {

    private final ChatLogMapper chatLogMapper;

    public void saveChatLog(ChatLog chatLog) {
        // 채팅 메시지 저장
        chatLogMapper.insertChatLog(chatLog);

        // 채팅 메시지 개수 확인
        int messageCount = chatLogMapper.countChatLogsByRoomId(chatLog.getRoomId());

        // 20개 초과 시 오래된 메시지 삭제
        if (messageCount > 20) {
            chatLogMapper.deleteOldestChatLog(chatLog.getRoomId());
        }
    }

    // lesson 테이블에서 판매자 email 조회
    public String getLessonMemberEmail(String lessonNumber) {
        return chatLogMapper.findLessonMemberEmail(lessonNumber);
    }

    // payment 테이블에서 구매자 email 조회
    public String getPaymentMemberEmail(String paymentNumber) {
        return chatLogMapper.findPaymentMemberEmail(paymentNumber);
    }

    // payment 테이블에서 lesson_number 조회
    public String getLessonNumberByPaymentNumber(String paymentNumber) {
        return chatLogMapper.findLessonNumberByPaymentNumber(paymentNumber);
    }
    
    // 닉네임 포함 채팅 로그 조회
    public List<ChatLog> findChatLogsByRoomId(String roomId, int memberNumber) {
        Map<String, Object> params = new HashMap<>();
        params.put("roomId", roomId);
        params.put("memberNumber", memberNumber); // 올바른 값 전달 확인
        return chatLogMapper.findChatLogsByRoomId(params);
    }


    public String getMemberNicknameByEmail(String email) {
        return chatLogMapper.findMemberNicknameByEmail(email);
    }

    public String getPaymentNicknameByPaymentNumber(String paymentNumber) {
        return chatLogMapper.findPaymentNicknameByPaymentNumber(paymentNumber);
    }
    
    // 채팅방 목록 조회
    public List<Map<String, Object>> getChatRooms(String email) {
        return chatLogMapper.findChatRoomsByEmail(email);
    }
    
    public Map<String, Integer> getUnreadMessageCounts(String email) {
        List<Map<String, Object>> unreadCounts = chatLogMapper.findUnreadMessageCountsByEmail(email);
        Map<String, Integer> unreadMap = new HashMap<>();
        for (Map<String, Object> entry : unreadCounts) {
            unreadMap.put((String) entry.get("roomId"), ((Long) entry.get("unreadCount")).intValue());
        }
        return unreadMap;
    }

    public void markMessagesAsRead(String roomId, String email) {
        chatLogMapper.markMessagesAsRead(Map.of("roomId", roomId, "email", email));
    }
    
    public String getMostRecentRoomId(String email) {
        return chatLogMapper.findMostRecentRoomId(email);
    }

    public int getTotalUnreadCount(String email) {
        return chatLogMapper.countTotalUnreadMessages(email);
    }

}