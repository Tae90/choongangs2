package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/webrtc")
public class WebRtc_Controller {
 
   @GetMapping("/")
   public String webrtc_main(){
      System.out.println("webrtc main");

      //return "/webrtc/makeVideoRoom";
      return "/webrtc/webrtc_main";
   }

   @GetMapping("/myVideoRoom") //1:다 개인방송
   public String myVideoRoom(@RequestParam String username, @RequestParam String room, RedirectAttributes rttr) {
      System.out.println("username:"+username+" ,room:"+room);

      return "/webrtc/myVideoRoom";
   }
   
   @GetMapping("/webrtc_detailMeeting") //다:다 회의
   public String webrtc_detailMeeting(@RequestParam String username, @RequestParam String room, RedirectAttributes rttr) {
      System.out.println("username:"+username+" ,room:"+room);

      return "/webrtc/webrtc_detailMeeting";
   }

   @GetMapping("/subscribeVideoRoom") //구독자가 바로 접근
   public String subscribeVideoRoom(@RequestParam String room){
      System.out.println("subscribeVideoRoom");
      return "/webrtc/subscribeVideoRoom";
   }

}
