package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Member;


@Mapper
public interface JoinDAO {


	int insert(Member member);

	int emailcheck(String email);

	int usercheck(Member member);



	
}
