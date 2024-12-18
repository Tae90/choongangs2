package com.example.demo.dao;

import com.example.demo.model.ChatLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChatLogMapper {

    // 기존 메서드
    void insertChatLog(ChatLog chatLog);

    String findLessonMemberEmail(@Param("lessonNumber") String lessonNumber);

    String findPaymentMemberEmail(@Param("paymentNumber") String paymentNumber);

    String findLessonNumberByPaymentNumber(@Param("paymentNumber") String paymentNumber);

    // 닉네임을 포함한 채팅 메시지 조회 (최대 20개)
    List<ChatLog> findChatLogsByRoomId(Map<String, Object> params);

    String findMemberNicknameByEmail(@Param("email") String email);
    String findPaymentNicknameByPaymentNumber(@Param("paymentNumber") String paymentNumber);

    // 가장 오래된 메시지 삭제
    void deleteOldestChatLog(@Param("roomId") String roomId);
    
    int countChatLogsByRoomId(@Param("roomId") String roomId);

}