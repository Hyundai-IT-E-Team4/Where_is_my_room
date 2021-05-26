package com.org.team4.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.org.team4.dto.BoardInsertDTO;
import com.org.team4.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	

	@GetMapping("enroll")
	public String insert() {
		return "board/enroll";
	}
	
		
	@PostMapping("enroll")
	public ModelAndView enroll(@ModelAttribute BoardInsertDTO boardinsertDTO, HttpSession session) {
		try {
			boardService.insertBoard(boardinsertDTO);
			ModelAndView mav = new ModelAndView("result");
			mav.addObject("msg", "방이 등록되었습니다!");
			mav.addObject("url", "./");
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("result");
			mav.addObject("msg", "게시글 등록에 실패하였습니다.");
			mav.addObject("url", "./");
			return mav;
		}
	}
}