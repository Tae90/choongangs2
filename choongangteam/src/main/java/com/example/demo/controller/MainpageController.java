package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Lesson;
import com.example.demo.model.Maincategory;
import com.example.demo.model.Member;
import com.example.demo.model.Subcategory;
import com.example.demo.model.UserSession;
import com.example.demo.service.MainpageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainpageController {
	private final MainpageService service;
	

	@RequestMapping("mainpage")
	public String mainpage(Lesson lesson, Model model, @ModelAttribute Member member, HttpSession session) {

		// 메인페이지에 나오는 best 20 클래스중 8개만 보여줌
		List<Lesson> bestclass = service.bestclass(lesson);
		
		
		System.out.println(bestclass);
	
		UserSession user = (UserSession) session.getAttribute("userSession");

		model.addAttribute("user", user);
		model.addAttribute("bestclass", bestclass);		

		return "mainpage/mainpage";
	}

	@RequestMapping("bestclass")
	public String bestclass(Lesson lesson, Model model, @ModelAttribute Member member, HttpSession session) {

		List<Lesson> bestclass = service.bestclass(lesson);

		UserSession user = (UserSession) session.getAttribute("userSession");

		model.addAttribute("user", user);

		model.addAttribute("bestclass", bestclass);

		return "mainpage/bestclasspage";
	}

	@RequestMapping("category_page")
	public String category_page(@RequestParam(name = "page", defaultValue = "0") int page,
			@RequestParam(name = "size", defaultValue = "8") int size,
			@RequestParam(name = "order", defaultValue = "latest") String order, Lesson lesson, Model model,
			Maincategory maincategory, Subcategory subcategory,
			@ModelAttribute Member member, HttpSession session) {

		int maincate_num = maincategory.getMaincategory_number();
		int subcate_num = subcategory.getSubcategory_number();

		System.out.println(maincate_num);
		System.out.println(subcate_num);

		List<Subcategory> subcate = service.subcatelist(maincate_num);

		System.out.println(subcate);

		// Map 생성 및 파라미터 추가
		Map<String, Object> params = new HashMap<>();
		params.put("lesson", lesson);
		params.put("page", page);
		params.put("size", size);
		params.put("subcategory_number", subcate_num); // 추가
		params.put("order", order); // order 파라미터 추가

		// Service 호출
		List<Lesson> cateclass = service.cateclass(params);

		System.out.println("Loaded lessons: " + cateclass);
		System.out.println("lessons_siize: " + cateclass.size());
		
		UserSession user = (UserSession) session.getAttribute("userSession");

		model.addAttribute("user", user);

		model.addAttribute("subcate", subcate);
		model.addAttribute("maincate_num", maincate_num);
		model.addAttribute("subcate_num", subcate_num);
		model.addAttribute("selectedSubcategory", subcate_num);
		model.addAttribute("cateclass", cateclass);
		model.addAttribute("order", order); // 뷰에서 사용할 수 있도록 order 추가

		return "category_page_list";
	}

	@GetMapping("/loadMoreLessons")
	@ResponseBody
	public List<Lesson> loadMoreLessons(@RequestParam("page") int page,
			@RequestParam("subcategory_number") int subcategory_number,
			@RequestParam(name = "order", defaultValue = "latest") String order,
			@RequestParam("loadedLessonIds") List<Integer> loadedLessonIds) {

		System.out.println("page:" + page);
		System.out.println("subcategory_number:" + subcategory_number);

		int pageSize = 4; // 한 번에 불러올 강의 수
		int offset = (page - 1) * pageSize;

		HashMap map = new HashMap();
		map.put("subcategory_number", subcategory_number);
		map.put("limit", 4);
		map.put("offset", offset);
		map.put("order", order); // order 파라미터 추가
		map.put("loadedLessonIds", loadedLessonIds);

		List<Lesson> list = service.getLessons(map);
		System.out.println("list:" + list);

		return list;
	}

	@RequestMapping("keyword_search")
	public String keyword_search(@RequestParam(name = "lesson_keyword") String lesson_keyword, Lesson lesson,
			Model model, @RequestParam(name = "order", defaultValue = "latest") String order,
			@ModelAttribute Member member, HttpSession session) {

		Map<String, Object> params = new HashMap<>();
		params.put("lesson_keyword", lesson_keyword);
		params.put("lesson", lesson);
		params.put("order", order); // order 파라미터 추가

		List<Lesson> searchclass = service.searchclass(params);

		System.out.println("searchlist" + searchclass);

		List<Lesson> bestclass = service.bestclass(lesson);
		
		UserSession user = (UserSession) session.getAttribute("userSession");

		model.addAttribute("user", user);

		model.addAttribute("bestclass", bestclass);
		model.addAttribute("searchclass", searchclass);
		model.addAttribute("lesson_keyword", lesson_keyword);
		model.addAttribute("order", order); // 뷰에서 사용할 수 있도록 order 추가

		return "mainpage/keyword_resultpage";

	}

	@GetMapping("/loadMoreSearchLessons")
	@ResponseBody
	public List<Lesson> loadMoreSearchLessons(@RequestParam("page") int page,
			@RequestParam(name = "order", defaultValue = "latest") String order,
			@RequestParam(name = "lesson_keyword") String lesson_keyword,
			@RequestParam("loadedLessonIds") List<Integer> loadedLessonIds) {

		System.out.println("page:" + page);
		System.out.println("lesson_keyword:" + lesson_keyword);

		int pageSize = 4; // 한 번에 불러올 강의 수
		int offset = (page - 1) * pageSize;

		HashMap<String, Object> map = new HashMap<>();
		map.put("limit", 4);
		map.put("offset", offset);
		map.put("order", order); // order 파라미터 추가
		map.put("loadedLessonIds", loadedLessonIds);
		map.put("lesson_keyword", lesson_keyword);

		List<Lesson> list = service.getSearchLessons(map);
		System.out.println("list:" + list);

		return list;
	}

}