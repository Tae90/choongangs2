package com.example.demo.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("favorite")
public class Favorite {
	
	private int favorite_number;
	private String favorite_title;
	private String member_email;
	private int lesson_number;
	
	
	private String lesson_thumbnail;
    private int lesson_price;
    
    private int total;
}
