package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageDTO;
import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;

public interface MessageDAO {

	public List<MessageListDTO> getMessageRoomListInit(long usr_no) throws SQLException;

	public List<MessageListDTO> getMessageRoomList(MessageListParamDTO mlpDTO) throws SQLException;

	public List<MessageLogDTO> getMessageLogInit(MessageLogParamDTO mlpDTO) throws SQLException;

	public List<MessageLogDTO> getMessageLogAppend(MessageLogParamDTO mlpDTO) throws SQLException;

	public void insertMessage(MessageDTO messageDTO) throws SQLException;

}
