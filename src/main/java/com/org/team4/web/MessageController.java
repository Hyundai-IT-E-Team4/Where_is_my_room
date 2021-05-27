 package com.org.team4.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("messages")
public class MessageController {

	@Autowired
	MessageService messageService;

	@GetMapping()
	public String messagemain() {
		return "redirect:messages/";
	}

	@GetMapping("/")
	public String messagemain(Model model, HttpSession session) {

		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			model.addAttribute("messageRoomList", messageService.getMessageRoomListInitial(userInfo.getId()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "message/chat";
	}

	@GetMapping("list/{lastChatId}")
	@ResponseBody
	public List<MessageListDTO> messageListAppend(@PathVariable Long lastChatId, HttpSession session) {

		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			MessageListParamDTO amlDTO = new MessageListParamDTO(userInfo.getId(), lastChatId);
			return messageService.getMessageRoomList(amlDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("detail/{messageId}")
	@ResponseBody
	public List<MessageLogDTO> messageLog(@PathVariable long messageId, HttpSession session) {

		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			MessageLogParamDTO mlpDTO = new MessageLogParamDTO(messageId, 0);
			return messageService.getMessageLogInit(mlpDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("detail/{messageId}/{lastChatId}")
	@ResponseBody
	public List<MessageLogDTO> messageLogAppend(@PathVariable long messageId, @PathVariable long lastChatId, HttpSession session) {
		try {
			UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
			MessageLogParamDTO mlpDTO = new MessageLogParamDTO(messageId, lastChatId);
			return messageService.getMessageLogAppend(mlpDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}