package com.org.team4.web;

import java.util.Arrays;
import java.util.List;
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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.org.team4.dto.BoardDTO;
import com.org.team4.dto.BoardCheckDTO;
import com.org.team4.dto.BoardDetailDTO;
import com.org.team4.dto.CommentDTO;
import com.org.team4.dto.CommentDeleteDTO;
import com.org.team4.dto.CommentInsertDTO;
import com.org.team4.dto.CommentPagingDTO;
import com.org.team4.dto.CommentUpdateDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.service.BoardService;
import com.org.team4.service.CommentsService;
import com.org.team4.service.S3Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("boards")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentsService commentsService;

	@GetMapping("/enroll")
	public String insert() {
		return "board/enroll";
	}
	
	@PostMapping("")
	public String enroll(BoardDTO boardDTO, HttpSession session, MultipartHttpServletRequest mreq, Model model) {
		log.info("enroll test");
		UserDTO userInfo = getUserInfo(session);
		boardDTO.setWriterId(userInfo.getId()); // 테스트용 임시 게시글 작성자pk 설정
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
	
	@GetMapping("/update/{boardId}")
	public String updateForm(@PathVariable long boardId, HttpSession session, Model model) {
		try {
			UserDTO userInfo = getUserInfo(session);
			if(boardService.writerCheck(new BoardCheckDTO(userInfo.getId(), boardId)) == 0) {
				model.addAttribute("msg", "권한이 없습니다");
				model.addAttribute("url", "/team4");
				return "result";
			}
			BoardDetailDTO boardDetailDTO = boardService.getUpdateInfo(boardId);
			log.info(boardDetailDTO.toString());
			model.addAttribute("boardDetailDTO", boardDetailDTO);
			model.addAttribute("id", boardId);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "board/update";
	}
	
	@PostMapping("/{id}")
	public String update(@PathVariable long id, 
			MultipartHttpServletRequest mreq, 
			@RequestParam(value="img", required = false) List<Long> imgs,
			BoardDTO boardDTO,
			HttpSession session,
			Model model) {
		if(imgs == null) {
			imgs = Arrays.asList(new Long[]{0L});
		}
		UserDTO userInfo = getUserInfo(session);
		Map<String, MultipartFile> files = mreq.getFileMap();
		try {
			if(boardService.writerCheck(new BoardCheckDTO(userInfo.getId(), id)) == 0) {
				model.addAttribute("msg", "권한이 없습니다");
				model.addAttribute("url", "/team4");
				return "result";
			}
			boardDTO.setWriterId(userInfo.getId());
			boardService.update(boardDTO, imgs, files);
			log.info(String.valueOf(id));
			return "redirect:/boards/" + Long.toString(id);
		} catch(Exception e) {
			log.info(e.getMessage());
			e.printStackTrace();
			model.addAttribute("msg", "수정 실패!");
			model.addAttribute("url","javascript:history.back()");
			return "result";
		}
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<String> delete(@PathVariable long id, HttpSession session){
		try {
			UserDTO userInfo = getUserInfo(session);
			boardService.deleteBoard(new BoardCheckDTO(userInfo.getId(), id));
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}
	
	@GetMapping("/{id}/comments")
	@ResponseBody
	public ResponseEntity<List<CommentDTO>> getComment(@PathVariable long id, long page) {
		try {
			List<CommentDTO> comments = commentsService.getComment(new CommentPagingDTO(page, id));
			return new ResponseEntity<List<CommentDTO>>(comments, HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/{id}/comments")
	@ResponseBody
	public ResponseEntity<String> commentEnroll(@PathVariable long id, String content, Long parentId, HttpSession session) {
		try {
			UserDTO userInfo = getUserInfo(session);
			commentsService.enrollComment(new CommentInsertDTO(null, parentId, userInfo.getId(), id, content));
			return new ResponseEntity<>(HttpStatus.CREATED);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
	}

	@PostMapping(value = "/{boardId}/comments/{commentId}")
	@ResponseBody
	public ResponseEntity<String> commentUpdate(@PathVariable long boardId, 
											@PathVariable long commentId,
											String content,
											HttpSession session){
		//세션으로부터 id값 받아와야함
		try {
			UserDTO userInfo = getUserInfo(session); 
			CommentUpdateDTO dto = new CommentUpdateDTO(commentId, userInfo.getId(), content);
			log.info("{} {} {}", new Object[] {boardId, commentId, content});
			commentsService.updateComment(dto);
			return new ResponseEntity<>(HttpStatus.CREATED);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}
	
	@DeleteMapping(value = "/{boardId}/comments/{commentId}")
	@ResponseBody
	public ResponseEntity<String> commentDelete(@PathVariable long boardId, @PathVariable long commentId, HttpSession session) {
		//세션으로부터 id값 받아와야함 
		try {
			UserDTO userInfo = getUserInfo(session);
			CommentDeleteDTO commentDeleteDTO = new CommentDeleteDTO(commentId, userInfo.getId());
			commentsService.deleteComment(commentDeleteDTO);
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}
	
	private UserDTO getUserInfo(HttpSession session) {
		return (UserDTO)session.getAttribute("userInfo");
	}
}