package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Favorite;
import com.example.demo.model.Lesson;
import com.example.demo.model.Member;
import com.example.demo.model.Reply;
import com.example.demo.model.UserSession;
import com.example.demo.service.LoginService;
import com.example.demo.service.MypageService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {
	 private final MypageService service; 
	 private final LoginService login_service;
	 @Autowired
	    private ServletContext servletContext;
	
	 // 회원정보 불러오기
	@RequestMapping("mypage")
		public String mypage(Lesson lesson, Model model, @ModelAttribute Member member, HttpSession session) {
			
			
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		System.out.println("user:"+user);

		model.addAttribute("user", user);	
		
			return "mypage/mypage";
		}
	
	// 닉네임 변경
	@RequestMapping("nickname_update")
		public String nickname_update(@ModelAttribute Member member, HttpSession session , Model model) {
		
	
		UserSession userSession1 = (UserSession) session.getAttribute("userSession");		
		
		Member member1 = new Member();
		
		member1.setMember_email(userSession1.getEmail());
		member1.setMember_nickname(member.getMember_nickname());	
			 
		 service.updatenickname(member1);
		 
		 session.removeAttribute("userSession");
		  
		 UserSession userSession = new UserSession();
		 userSession.setEmail(userSession1.getEmail());
		 userSession.setNickname(member.getMember_nickname());
		 userSession.setUser_photo(userSession1.getUser_photo());
		 userSession.setMember_number(userSession1.getMember_number());
		 
		 session.setAttribute("userSession", userSession);
		 
		 System.out.println("변경 후 세션 : "+userSession);
		
		
		return "redirect:/mypage";
	}
	
	// 프로필 사진변경
	@RequestMapping(value = "profileimg_update", method = RequestMethod.POST)
    public String profileimg_update(@RequestParam("imageFile") MultipartFile imageFile, HttpSession session) throws IOException {
		
		UserSession userSession = (UserSession) session.getAttribute("userSession");
		
		
		if (imageFile != null && !imageFile.isEmpty()) {
			
			// 이미지 저장 로직
            String fileName = saveImage(imageFile);
		
            // 데이터베이스 업데이트
            Member member = new Member();
            member.setMember_email(userSession.getEmail());
            member.setMember_photo(fileName);
            
            service.updateprofileimg(member);
            
            // 세션 업데이트
            userSession.setUser_photo(fileName);
            session.setAttribute("userSession", userSession);
            
            System.out.println("변경 후 세션 : " + userSession);
		
	}
		return "redirect:/mypage";
	}
	
	
	
	private String saveImage(MultipartFile imageFile) throws IOException {
        // 웹 애플리케이션 루트 경로
        String webAppRoot = servletContext.getRealPath("/");

        // "uimg" 폴더 경로
        String imagePath = webAppRoot + "uimg/";

        // 파일명 생성
        String originalFilename = imageFile.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + fileExtension;

        // 디렉토리 생성
        File directory = new File(imagePath);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // 파일 저장
        File file = new File(imagePath + fileName);
        imageFile.transferTo(file);

        return fileName;
    }


	// 내가 찜한 클래스 불러오기
	@RequestMapping("favoritelist")
	public String favoritelist(Favorite favorite, Model model, @ModelAttribute Member member, HttpSession session, Lesson lesson) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		String useremail = user.getEmail();	
		System.out.println("유저 이메일:"+useremail);
		
		Favorite fav = new Favorite();
		fav.setMember_email(useremail);
		
	
		int total = service.totalmyfav(fav);
		System.out.println("찜을 누른 클래스 수 : "+total);
		
		
		List<Favorite> favoritelist = service.myfavorite(fav);
		System.out.println("내가 찜한 클래스 :"+favoritelist);
		
		model.addAttribute("user", user);	
		model.addAttribute("total" , total);
		model.addAttribute("favoritelist" , favoritelist);
		
		return "mypage/favoritelist";
	}
	
	
	// 내가 구매한 클래스, 리뷰 작성한 클래스 불러오기
	@RequestMapping("reviews")
	public String reviews(Reply reply , Model model, @ModelAttribute Member member, HttpSession session, Lesson lesson) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		String useremail = user.getEmail();	
		
		
		Reply rep = new Reply();
		rep.setMember_email(useremail);
		
		List <Reply> myreview = service.myreview(rep);
		System.out.println("내가 리뷰한 클래스:"+myreview);
		
		
		model.addAttribute("user", user);	
		model.addAttribute("myreview", myreview);	
		
		return "mypage/myreview";
	}
	
	
	// 회원 탈퇴 페이지
	@RequestMapping("delete_member")
	public String delete_member( Model model, @ModelAttribute Member member, HttpSession session) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		String pass = login_service.findpass(user.getEmail());
		    
		 System.out.println("회원 비밀번호 : "+ pass);
	
		
		/* model.addAttribute("user", user); */
		return "mypage/memberdelete";
	}
	
	
	// 회원 탈퇴
	@RequestMapping("delete_member_ok")
	public String delete_member_ok(@RequestParam(value="member_password", required = false) String memberpasswd, HttpSession session, Model model, @ModelAttribute Member member) {
		int result = 0;
	    
	    UserSession user = (UserSession) session.getAttribute("userSession");
	    String pass = login_service.findpass(user.getEmail());
	    
		 System.out.println("회원 비밀번호 : "+ pass);
	  
	    System.out.println("memberpasswd:"+memberpasswd);
	    // 세션에 저장된 비밀번호와 입력된 비밀번호 비교
	    if (pass.equals(memberpasswd)) {
	        // 비밀번호가 일치하면 회원 삭제 진행
	        try {
	        	service.updatedeletenum(user.getEmail());
	        	service.deleteMember(user.getEmail());
	            result = 1;
	            // 세션 무효화
	            session.invalidate();
	        } catch (Exception e) {
	            // 삭제 실패 시 예외 처리
	            e.printStackTrace();
	            result = -1;
	        }
	    } else {
	        // 비밀번호가 일치하지 않으면 result는 0으로 유지
	        result = 0;
	    }
	    System.out.println("결과 값: " + result);
	    model.addAttribute("result", result);
	    
	    return "mypage/delete_result";
	}
	
	
	// 내가 등록한 클래스
	@RequestMapping("myregisteredclasses")
	public String myregisteredclasses(Model model, @ModelAttribute Member member, HttpSession session, Lesson lesson) {
		
		UserSession user = (UserSession) session.getAttribute("userSession");
		
		String useremail = user.getEmail();	
		
		Lesson les = new Lesson();
		les.setMember_email(useremail);
		
		List<Lesson> myclass = service.myclass(les);
		
		System.out.println("내가 등록한 클래스: "+myclass);
		
		model.addAttribute("myclass", myclass);
		
		return "mypage/my_upload_class";
	}
	
	
	
}
