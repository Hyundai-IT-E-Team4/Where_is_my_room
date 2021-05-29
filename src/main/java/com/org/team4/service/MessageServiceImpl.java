package com.org.team4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.org.team4.dao.MessageDAO;
import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageDTO;
import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;
import com.org.team4.dto.MessageUpdateParamDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageServiceImpl implements MessageService{
	
	@Autowired
	MessageDAO messageDAO;

	@Override
	public List<MessageListDTO> getMessageRoomListInit(long id) throws Exception{
		try {			
			return messageDAO.getMessageRoomListInit(id);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageListDTO> getMessageRoomList(MessageListParamDTO mlpDTO) throws Exception {
		try {			
			return messageDAO.getMessageRoomList(mlpDTO);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageLogDTO> getMessageLogInit(MessageLogParamDTO mlpDTO) throws Exception {
		try {			
			return messageDAO.getMessageLogInit(mlpDTO);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageLogDTO> getMessageLogAppend(MessageLogParamDTO mlpDTO) throws Exception {
		try {			
			return messageDAO.getMessageLogAppend(mlpDTO);
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

}
