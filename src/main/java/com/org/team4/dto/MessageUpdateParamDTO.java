package com.org.team4.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class MessageUpdateParamDTO {
	
	long messageId;
	long userId;

}
