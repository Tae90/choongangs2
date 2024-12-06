package com.example.demo.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("lesson")
public class lesson {
	
	private int lesson_number;
	private String lesson_title;
	private String lesson_content;
	private Date write_date;
	private String start_time;
	private String end_time;
	private String lesson_keyword;
	private int lesson_price;
	private int reply_count;
	private int favorite_count;
	private String lesson_thumbnail;
	private String content_image;
	private int member_count;
	private String member_email;
	
	private int subcategory_number;
	private int maincategory_number;
	
	// 댓글 별점 평균
	private String avg_reply_score;
	
	
	
	
}
