package com.example.demo.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("maincategory")
public class Maincategory {

	private int maincategory_number;
	private String maincategory_name;
	
}
