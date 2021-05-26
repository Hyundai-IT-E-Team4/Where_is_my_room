package com.org.team4.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@AllArgsConstructor
@Getter
@Setter
public class MessageLogParamDTO {

	long messageId;
	long lastChatId;
}
