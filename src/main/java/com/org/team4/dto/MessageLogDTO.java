package com.org.team4.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MessageLogDTO {
	long rnum;
	long id;
	long messageId;
	long senderId;
	String nickname;
	String message;
	Date sendDate;
	int read;
	String profileImg;
}
