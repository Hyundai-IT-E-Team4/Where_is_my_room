package com.org.team4.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class LocationDTO {
	private double swLat;
	private double swLng;
	private double neLat;
	private double neLng;
	private long pageNum;
}
