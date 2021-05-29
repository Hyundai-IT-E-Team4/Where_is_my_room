package com.org.team4.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
	private long id;
	private String title;
	private String content;
	private double latitude;
	private double longitude;
	private String room_type;
	private String contract_type;
	private int rental_fee;
	private String address;
	private String detailAddress;
	private String write_date;
	private int deleted;
	private long writer_id;
}
