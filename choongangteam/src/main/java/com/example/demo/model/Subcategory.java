package com.example.demo.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("subcategory")
public class subcategory {
	
	private int subcategory_number;
	private String subcategory_name;
	private int maincategory_number;

}
