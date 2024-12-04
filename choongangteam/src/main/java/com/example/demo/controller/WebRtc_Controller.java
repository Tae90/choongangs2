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

      return "/webrtc/makeVideoRoom";
   }

   @GetMapping("/myVideoRoom")
   public String myVideoRoom(@RequestParam String username, @RequestParam String room, RedirectAttributes rttr) {
      System.out.println("username:"+username+" ,room:"+room);

      if(room == "null" || room.equals("undefined"))
      {
         rttr.addFlashAttribute("msg", "undefined");

         return "redirect:/";
      }
      return "/webrtc/myVideoRoom";
   }
   
   @GetMapping("/subscribeVideoRoom")
   public String subscribeVideoRoom(@RequestParam String room){
      System.out.println("subscribeVideoRoom");
      return "subscribeVideoRoom";
   }

}
