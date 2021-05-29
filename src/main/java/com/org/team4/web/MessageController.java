 package com.org.team4.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;
import com.org.team4.dto.MessageUpdateParamDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("messages")
public class MessageController {

	@Autowired
	MessageService messageService;

	@GetMapping("home1")
	public String home() {
		return "message/home";
	}
	
	@GetMapping("home2")
	public String home2() {
		return "message/home2";
	}

	@GetMapping()
	public String messagemain() {
		return "redirect:messages/";
	}

	@GetMapping("/")
	public String messagemain(Model model, HttpSession session) {

		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			model.addAttribute("messageRoomList", messageService.getMessageRoomListInit(userInfo.getId()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "message/chat";
	}

	@GetMapping("list")
	@ResponseBody
	public List<MessageListDTO> messageListAppend(HttpSession session) {
		
		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			MessageListParamDTO mlpDTO = new MessageListParamDTO(userInfo.getId());
			return messageService.getMessageRoomList(mlpDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("detail")
	@ResponseBody
	public List<MessageLogDTO> messageLog(@RequestParam("messageId") long messageId, @RequestParam("startDate") String startDate, HttpSession session) {
		try {
			log.info(startDate);
			
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			MessageLogParamDTO mlpDTO = new MessageLogParamDTO(messageId, 0, startDate);
			return messageService.getMessageLogInit(mlpDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	@GetMapping("detailappend")
	@ResponseBody
	public List<MessageLogDTO> messageLogAppend(@RequestParam("messageId") long messageId, @RequestParam("lastChatId") long lastChatId, @RequestParam("startDate") String startDate, HttpSession session) {
		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			MessageLogParamDTO mlpDTO = new MessageLogParamDTO(messageId, lastChatId, startDate);
			return messageService.getMessageLogAppend(mlpDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("delete")
	@ResponseBody
	public void updateStartdate(@RequestParam("messageId") long messageId, HttpSession session) {
		try {
			long userId = ((UserDTO) session.getAttribute("userInfo")).getId();
			MessageUpdateParamDTO mupDTO = new MessageUpdateParamDTO(messageId, userId);
			messageService.setMessageStartDate(mupDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}