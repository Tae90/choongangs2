package com.example.demo.model;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("sellerLesson")
public class SellerLesson {
    private int lesson_number;
    private String lesson_title;
    private String lesson_thumbnail;

    // 추가: Payment 관련 필드
    private String payment_date;      // 결제 날짜
    private String payment_nickname;  // 구매자 닉네임
    private String buyer_email;       // 구매자 이메일
    private int payment_number;
}
