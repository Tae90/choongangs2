package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

/*
마이 페이지에서 
판매자 : 바로 방 생성
구매자 : lesson_number와 member_email이 payment 테이블에 있으면서 payment_state가 y인 경우 수강 가능

test 순서
판매자 : /webrtc/test -> /wetrtc/main(방 개설) -> (publisher)webrtc/detailPersonal 또는 (publisher,subscriber)webrtc/detailMeeting
구매자 : /webrtc/test(방 번호 입력) -> (subscriber)webrtc/detailPersonal 또는 (publisher,subscriber)webrtc/detailMeeting
*/

@Controller
@RequestMapping("/webrtc")
public class WebRtcController {


   @GetMapping("/test")
   public String test1(){
      return "/webrtc/test";
   }
 
   @GetMapping("/main")
   public String webrtc_main(@RequestParam("mode") int mode, HttpSession session, Model model){

     

      model.addAttribute("mode", mode);

      return "/webrtc/main";
   }

   @GetMapping("/detailMeeting") //다:다 회의
   public String detailMeeting(@RequestParam String username, @RequestParam String room, @RequestParam int usermode, RedirectAttributes rttr, Model model) {
      System.out.println("username:"+username+" ,room:"+room + " ,usermode:"+usermode);

      model.addAttribute("username", username);
      model.addAttribute("room", room);
      model.addAttribute("usermode", usermode);

      return "/webrtc/detailMeeting";
   }

   @GetMapping("/detailPersonal") //1:다 개인방송
   public String webrtc_detailPersonal(@RequestParam String username, @RequestParam String room, RedirectAttributes rttr, Model model) {
      System.out.println("username:"+username+" ,room:"+room);

      if(room == "undefined" || room.equals("undefined")){
         //rttr.addFlashAttribute("msg", "undefined");
         //return "redirect:/webrtc/";
         model.addAttribute("msg", "undefined");
         System.err.println("room undefined");
      }
      
      model.addAttribute("username", username);
      model.addAttribute("room", room);
      return "/webrtc/detailPersonal";
   }
   
   @GetMapping("/webrtc_detailPersonalSubscriber") //구독자가 바로 접근
   public String webrtc_detailPersonalSubscriber(){
      System.out.println("webrtc_detailPersonalSubscriber");
      return "/webrtc/webrtc_detailPersonalSubscriber";
   }

   @GetMapping("/shareMyVideoRoom")
   public String shareMyVideoRoom(){
      System.out.println("shareMyVideoRoom");
      return "webrtc/shareMyVideoRoom";
   }

   @GetMapping("/origin")
   public String origin(){
      System.out.println("origin");
      return "/videoroom";
   }
}
