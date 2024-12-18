package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Reply;


@Mapper
public interface ReplyDAO {

	int insert(Reply reply);

	List<Reply> commentList(String i);

	int replycheck(Reply reply);

	List<Reply> getReply(HashMap map);

	int replyDelete(int reply_number);

	int pcheck(Reply reply);

	int addCount(int lesson_number);
	
	int deleteCount(int lesson_number);
	


}
