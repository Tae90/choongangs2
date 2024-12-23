package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Member;


@Mapper
public interface LoginDAO {

	int idchk(Member member);

	int insert(Member member);

	String findpass(String email);

	Member getMember(Member member);
}
