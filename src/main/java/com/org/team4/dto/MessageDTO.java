package com.org.team4.dto;

import java.util.Date;

import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@RequiredArgsConstructor
public class MessageDTO {

	long id;
	@NonNull
	long senderId;
	@NonNull
	long messageId;
	@NonNull
	String message;
	Date sendDate;
	long read;
	
}
