package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.SampleService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class sampleController {

	private final SampleService service;

	@GetMapping("/")
	public String sample() {
		return "sample";
	}
	
	@RequestMapping("room_enter")
	public String roomenter() {		
		return "videoroom";
	}
	
	
	
	
}
