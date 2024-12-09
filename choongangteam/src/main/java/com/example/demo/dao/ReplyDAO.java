package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Reply;


@Mapper
public interface ReplyDAO {

	int insert(Reply reply);

	List<Reply> commentList(int i);

	int replycheck(String member_email);

	List<Reply> getReply(HashMap map);

	
	


}
