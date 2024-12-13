package com.example.demo.model;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("sellerLesson")
public class SellerLesson {
    private int lesson_number;
    private String lesson_title;
    private String lesson_thumbnail;
    private String start_time; // 필드 이름이 SQL 별칭과 일치해야 함

    private String payment_date;
    private String payment_nickname;
    private String buyer_email;
    private int payment_number;
}