package com.org.team4.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MessageListDTO {

	long rnum;
	long messageId;
	long partnerId;
	Date startDate;
	String partnerName;
	String message;
	Date sendDate;
	String profileImg;
}
