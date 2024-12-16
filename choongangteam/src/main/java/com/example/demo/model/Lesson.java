package com.example.demo.model;


import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("lesson")
public class Lesson {
	
	private int lesson_number;
	private String lesson_title;
	private String lesson_content;
	private Date write_date;
	private Date start_date;
	private String start_hour;
	private String start_min;
	private String class_hour;
	private String class_min;
	private String lesson_keyword;
	private int lesson_price;
	private int lesson_apply;
	private int lesson_delete;

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
