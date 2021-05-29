package com.org.team4.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.org.team4.dto.BoardDTO;
import com.org.team4.dto.BoardDeleteDTO;
import com.org.team4.dto.BoardDetailDTO;
import com.org.team4.service.BoardService;
import com.org.team4.service.S3Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("boards")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/enroll")
	public String insert() {
		return "board/enroll";
	}
	
	@PostMapping("")
	public String enroll(BoardDTO boardDTO, MultipartHttpServletRequest mreq, Model model) {
		log.info("enroll test");
		boardDTO.setWriter_id(1); // 테스트용 임시 게시글 작성자pk 설정
		Map<String, MultipartFile> files = mreq.getFileMap();
		try {
			long id = boardService.insertBoard(boardDTO, files);
			log.info(String.valueOf(id));
			return "redirect:boards/" + Long.toString(id);
		} catch(Exception e) {
			log.info(e.getMessage());
			e.printStackTrace();
			model.addAttribute("msg", "글 작성 실패!");
			model.addAttribute("url","javascript:history.back()");
			return "result";
		}
	}
	
	@GetMapping("/{id}")
	public String detail(@PathVariable long id, Model model) {
		try {
			BoardDetailDTO boardDetailDTO = boardService.detail(id);
			model.addAttribute("boardDetailDTO", boardDetailDTO);
			return "board/detail";
		} catch(Exception e) {
			model.addAttribute("msg", "게시글을 조회하는데 실패했습니다");
			model.addAttribute("url", "/team4");
			return "result";
		}
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<String> delete(@PathVariable long id){
		try {
			log.info(Long.toString(id));
			boardService.deleteBoard(new BoardDeleteDTO(2, id));
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}
}