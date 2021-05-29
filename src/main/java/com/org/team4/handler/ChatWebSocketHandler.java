package com.org.team4.handler;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.org.team4.dto.MessageDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class ChatWebSocketHandler extends TextWebSocketHandler {

	@Autowired
	MessageService messageService;
	private Map<Long, HashSet<WebSocketSession>> messageRooms = new ConcurrentHashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		String uri = session.getUri().getPath();
		long messageId = Long.parseLong(uri.substring(uri.lastIndexOf("/") + 1));
		HashSet<WebSocketSession> set;
		
		if (!messageRooms.containsKey(messageId)) {
			set = new HashSet<WebSocketSession>();
			messageRooms.put(messageId, set);
		} else {
			set = messageRooms.get(messageId);
		}

		set.add(session);
		log.info(messageRooms + "");
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String uri = session.getUri().getPath();
		long messageId = Long.parseLong(uri.substring(uri.lastIndexOf("/") + 1));
		long loginId = Long.parseLong(uri.split("/")[4]);

		messageRooms.get(messageId).remove(session);

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		UserDTO userDTO = (UserDTO) session.getAttributes().get("userInfo");

		try {
			long senderId = userDTO.getId();
			String senderNick = userDTO.getNickname();
			long messageId = Long.parseLong(message.getPayload().split(":")[0]);
			String msg = message.getPayload().split(":")[1];

			MessageDTO messageDTO = new MessageDTO(senderId, messageId, msg);
			messageService.insertMessage(messageDTO);
			HashSet<WebSocketSession> set = messageRooms.get(messageId);

			//log.info("senderId : {" + senderId + "}  senderNick : {" + senderNick + "}  messageId : {" + messageId + "}  msg : {" + msg + "}");

			for (WebSocketSession curSession : set) {
				curSession.sendMessage(new TextMessage(messageId + ":" + senderId + ":" + senderNick + ":" + msg));
			}
		} catch (Exception e) {
			log.warn(e.getMessage());
		}

	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.info(session.getId() + " 익셉션 발생: " + exception.getMessage());
	}
}