package com.org.team4.handler;

import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

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
   //
   private Map<Long, HashSet<WebSocketSession>> messageRooms = new ConcurrentHashMap<>();
   private Map<String, WebSocketSession> globalUsers = new ConcurrentHashMap<String, WebSocketSession>();

   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {

      HashSet<WebSocketSession> set;
      long messageId = getMessageId(session);
      String nickname = getNickname(session);

      globalUsers.put(getNickname(session), session);
      log.info(nickname);
      log.info("현재 접속자 수 : {}", globalUsers.size());
      
      if (messageId == 0) {
         return;
      }

      if (!messageRooms.containsKey(messageId)) {
         set = new HashSet<WebSocketSession>();
         messageRooms.put(messageId, set);
      } else {
         set = messageRooms.get(messageId);
      }

      set.add(session);

   }

   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      long messageId = getMessageId(session);
      
      if (messageId != 0)
         messageRooms.get(messageId).remove(session);
      
      globalUsers.remove(getNickname(session));
   }

   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      try {
         long senderId = getUserId(session);
         String senderNick = getNickname(session);
         long messageId = getMessageId(session);
         String msg = message.getPayload();
         log.info("메시지 : {}", msg);
         String msgcontent = msg.split(":")[1];

         // 메세지 형식 "댓글:보낸이:알림내용"
         if (messageId == 0) {
            msg = message.getPayload(); //만약 연락하기 보낸거라면 쪽지:받는이:내용 BUT 댓글 알림에는 받는이:내용
            String[] strArr = msg.split(":");
            String command = strArr[0];
            String content = msg.substring(msg.indexOf(":") + 1);
            String formatMsg = makeGlobalMesssage(command, senderNick, content);
            WebSocketSession receiver = getReceiver(content);
            if(receiver != null) {
               receiver.sendMessage(new TextMessage(formatMsg));
            } else {
               log.info("receiver is null");
            }
         } else {

            if (msg == null)
               throw new RuntimeException("메세지를 입력하지 않았습니다");

            messageService.insertMessage(new MessageDTO(senderId, messageId, msgcontent));
            
            HashSet<WebSocketSession> set = messageRooms.get(messageId);
            if (set.size() == 1) {
               WebSocketSession receiver = getReceiver(msg);
               if(receiver != null) {
            	   String link = String.format("/team4/messages", messageId);
            	   log.info(msg);
            	   String content = msg.split(":")[1];
            	   String newMsg = String.format("<a href='%s'>%s</a>", link, content);
            	   newMsg = "1:"+newMsg;
            	   log.info(newMsg);
            	   //
                  receiver.sendMessage(new TextMessage(makeMesssage("쪽지", senderNick, newMsg)));
            	   //receiver.sendMessage(new TextMessage(makeMesssage("쪽지", senderNick, msg)));
               } else {
                  log.info("receiver is null");
               }
            }

            for (WebSocketSession curSession : set) {
               curSession.sendMessage(new TextMessage(messageId + ":" + senderId + ":" + senderNick + ":" + msgcontent));
            }
         }

      } catch (Exception e) {
         log.warn(e.getMessage());
      }

   }

   @Override
   public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
      log.info(session.getId() + " 익셉션 발생: " + exception.getMessage());
   }

   private long getMessageId(WebSocketSession session) {
      String path = session.getUri().getPath();
      return Long.parseLong(path.substring(path.lastIndexOf("/") + 1));
   }

   private long getUserId(WebSocketSession session) {
      UserDTO userDTO = (UserDTO) session.getAttributes().get("userInfo");
      return userDTO.getId();
   }

   private String getNickname(WebSocketSession session) {
      UserDTO userDTO = (UserDTO) session.getAttributes().get("userInfo");
      return userDTO.getNickname();
   }

   private void sendAlarm(String payload) throws IOException {
      String[] parseArr = payload.split(":");
      String nickname = parseArr[0];
      String content = parseArr[1];
      WebSocketSession session = globalUsers.get(nickname);
      session.sendMessage(new TextMessage(content));
   }
   private String makeMesssage(String ... messages) { //첫번째는 명령어, 두번째는 발송자, 세번 째는 내용
      StringBuffer sb = new StringBuffer();
      String payload = messages[2];
      String[] parseData = payload.split(":");
      String msg = parseData[1]; // 내용
      sb.append(messages[0]);
      sb.append(":");
      sb.append(messages[1]);
      sb.append(":");
      sb.append(msg);
      return sb.toString();
   }
   
   private String makeGlobalMesssage(String ... messages) { //첫번째는 명령어, 두번째는 발송자, 세번 째는 내용
	   StringBuffer sb = new StringBuffer();
	   String payload = messages[2];
	   String[] parseData = payload.split(":");
	   String msg = parseData[1]; // 내용
	   sb.append(messages[0]);
	   sb.append(":");
	   sb.append(messages[1]);
	   sb.append(":");
	   sb.append(msg);
	   return sb.toString();
   }
   
   private WebSocketSession getReceiver(String payload) {
      String[] parseArr = payload.split(":");
      String nickname = parseArr[0];
      WebSocketSession session = globalUsers.get(nickname);
      return session;
   }
}