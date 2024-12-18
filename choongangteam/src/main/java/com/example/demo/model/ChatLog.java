package com.example.demo.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatLog {
    private String roomId;        // 채팅방 ID
    private String senderEmail;   // 발신자 이메일
    private String senderNickname; // 발신자 닉네임
    private String receiverEmail; // 수신자 이메일
    private String receiverNickname; // 수신자 닉네임
    private String content;       // 메시지 내용
    private MessageType messageType; // 메시지 타입
    private Timestamp createdAt;  // 생성 시간
}