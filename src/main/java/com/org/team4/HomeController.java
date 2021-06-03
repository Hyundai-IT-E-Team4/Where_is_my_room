package com.org.team4;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
   
   
   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home() {

      return "home";
   }
   
   @PostMapping("/")
   public String SearchHome(@RequestParam String keyword ,Model model) {
      model.addAttribute("keyword",keyword);
      log.info(keyword);
      return "map/map";
   }
   
}