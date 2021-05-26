package com.org.team4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.org.team4.dao.MessageDAO;
import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageServiceImpl implements MessageService{
	
	@Autowired
	MessageDAO messageDAO;

	@Override
	public List<MessageListDTO> getMessageRoomListInitial(long id) throws Exception{
		try {			
			return messageDAO.getMessageRoomListInitial(id);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<MessageListDTO> getMessageRoomList(MessageListParamDTO amlDTO) throws Exception {
		try {			
			return messageDAO.getMessageRoomList(amlDTO);
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

}
