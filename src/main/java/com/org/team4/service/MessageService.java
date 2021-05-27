package com.org.team4.service;

import java.util.List;

import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageDTO;
import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;

public interface MessageService {

	public List<MessageListDTO> getMessageRoomListInit(long id) throws Exception;

	public List<MessageListDTO> getMessageRoomList(MessageListParamDTO mlpDTO) throws Exception;

	public List<MessageLogDTO> getMessageLogInit(MessageLogParamDTO mlpDTO) throws Exception;

	public List<MessageLogDTO> getMessageLogAppend(MessageLogParamDTO mlpDTO) throws Exception;

	public void insertMessage(MessageDTO messageDTO) throws Exception;

}