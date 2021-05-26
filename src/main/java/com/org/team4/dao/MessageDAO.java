package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.MessageListParamDTO;
import com.org.team4.dto.MessageListDTO;
import com.org.team4.dto.MessageLogDTO;
import com.org.team4.dto.MessageLogParamDTO;

public interface MessageDAO {

	public List<MessageListDTO> getMessageRoomListInitial(long usr_no) throws SQLException;

	public List<MessageListDTO> getMessageRoomList(MessageListParamDTO amlDTO) throws SQLException;

	public List<MessageLogDTO> getMessageLogInit(MessageLogParamDTO mlpDTO) throws SQLException;

	public List<MessageLogDTO> getMessageLogAppend(MessageLogParamDTO mlpDTO) throws SQLException;

}
