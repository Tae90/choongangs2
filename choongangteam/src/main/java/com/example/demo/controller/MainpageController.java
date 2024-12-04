package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.lesson;
import com.example.demo.model.maincategory;
import com.example.demo.model.subcategory;
import com.example.demo.service.MainpageService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainpageController {
	private final MainpageService service;
	
	@RequestMapping("mainpage")
	public String mainpage(lesson lesson, Model model ) {
		
		// 메인페이지에 나오는 best 20 클래스중 8개만 보여줌
		List<lesson> bestclass = service.bestclass(lesson); 
		
		System.out.println(bestclass);
		
		model.addAttribute("bestclass", bestclass);
		
		return "mainpage/mainpage";
	}
	
	@RequestMapping("bestclass")
	public String bestclass(lesson lesson, Model model) {
		
		List<lesson> bestclass = service.bestclass(lesson); 
		

		
		model.addAttribute("bestclass", bestclass);
		
		return "mainpage/bestclasspage";
	}
	
	
	@RequestMapping("category_page")
	public String category_page(lesson lesson, Model model, maincategory maincategory, subcategory subcategory ) {
		
		int maincate_num = maincategory.getMaincategory_number();
		int subcate_num = subcategory.getSubcategory_number();
		
		System.out.println(maincate_num);
		System.out.println(subcate_num);
		
		List<subcategory> subcate = service.subcatelist(maincate_num);
		
		System.out.println(subcate);
		
		
		
		
	
		
		model.addAttribute("subcate", subcate);
		model.addAttribute("maincate_num", maincate_num);
		model.addAttribute("subcate_num", subcate_num);
		model.addAttribute("selectedSubcategory", subcate_num);
		
		return "category_page_list";
	}

}
