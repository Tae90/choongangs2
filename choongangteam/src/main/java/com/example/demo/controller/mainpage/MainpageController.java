package com.example.demo.controller.mainpage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.SampleService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainpageController {
	private final SampleService service;
	
	@RequestMapping("mainpage")
	public String mainpage() {
		
		return "mainpage/mainpage";
	}

}
