package com.example.demo.dao;

import com.example.demo.model.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {
    // 이메일로 회원 조회
    Member findMemberByEmail(@Param("email") String email);

    // 닉네임으로 회원 조회
    Member findMemberByNickname(@Param("nickname") String nickname);
}
