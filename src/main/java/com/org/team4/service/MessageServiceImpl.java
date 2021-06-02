package com.org.team4.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.org.team4.dao.MessageDAO;
import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageDTO;
import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;
import com.org.team4.dto.MessageRoomParamDTO;
import com.org.team4.dto.MessageUpdateParamDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageServiceImpl implements MessageService{
	
	@Autowired
	MessageDAO messageDAO;
	
	@Autowired
	S3Service s3Service;

	@Override
	public List<MessageListDTO> getMessageRoomListInit(long id) throws Exception{
		try {			
			List<MessageListDTO> messages = messageDAO.getMessageRoomListInit(id);
			for(MessageListDTO dto : messages) {
				dto.setProfileImg(s3Service.getFileURL("team4", s3Service.getFileURL("team4", dto.getProfileImg())));
				log.info("채팅 내역의 프로필 사진 : {}", dto.getProfileImg());
			}
			return messages;
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageListDTO> getMessageRoomList(MessageListParamDTO mlpDTO) throws Exception {
		try {			
			List<MessageListDTO> messages = messageDAO.getMessageRoomList(mlpDTO);
			for(MessageListDTO dto : messages) {
				//dto.setProfileImg(s3Service.getFileURL("team4", s3Service.getFileURL("team4", "profileThumb/2021/06/02/검사.PNG")));
				dto.setProfileImg(s3Service.getFileURL("team4", dto.getProfileImg()));
				log.info("넘어오는 파일 url은 {}", dto.getProfileImg());
			}
			return messages;
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageLogDTO> getMessageLogInit(MessageLogParamDTO mlpDTO) throws Exception {
		try {
			List<MessageLogDTO> messageLogs =  messageDAO.getMessageLogInit(mlpDTO);
			return messageLogs;
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageLogDTO> getMessageLogAppend(MessageLogParamDTO mlpDTO) throws Exception {
		try {			
			List<MessageLogDTO> messageLogs = messageDAO.getMessageLogAppend(mlpDTO);
			return messageLogs;
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public void insertMessage(MessageDTO messageDTO) throws Exception {
		try {			
			messageDAO.insertMessage(messageDTO);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public void setMessageStartDate(MessageUpdateParamDTO mupDTO) throws Exception {
		try {
			messageDAO.setMessageStartDate(mupDTO);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public void createMessageRoom(MessageRoomParamDTO messageRoomParamDTO) throws SQLException {
		try {
			messageDAO.createMessageRoom(messageRoomParamDTO);
		} catch(Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	
}
