package com.org.team4.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MapDTO {

	private long boardId;
	private String title;
	private double latitude;
	private double longitude;
	private String address;
	private int rentalFee;
	private String contractType;
	private String roomType;
	private String nickName;
	private String repreFile;
	
	
}