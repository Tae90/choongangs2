package com.example.demo.service;

import java.awt.print.Pageable;
import java.util.HashMap;
import java.util.List;

import javax.swing.tree.RowMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ReplyDAO;
import com.example.demo.model.Reply;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyService {
	private final ReplyDAO dao;
	


	public int insert(Reply reply) {
		return dao.insert(reply);
	}

	public List<Reply> commentList(int i) {
		return dao.commentList(i);
	}

	public int replycheck(String member_email) {
		return dao.replycheck(member_email);
	}

	public List<Reply> getReply(HashMap map) {
		return dao.getReply(map);
	}

	public int replyDelete(int reply_number) {
		return dao.replyDelete(reply_number);
	}

	public int pcheck(Reply reply) {
		return dao.pcheck(reply);
	}

	
	
	
	
	
}
