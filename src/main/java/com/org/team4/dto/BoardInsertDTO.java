package com.org.team4.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardInsertDTO {
	private String title;
	private String content;
	private double latitude;
	private double longitude;
	private String room_type;
	private String contract_type;
	private int rental_fee;
	private String address;
	private String write_date;
	private int deleted;
	private int writer_id;
}
