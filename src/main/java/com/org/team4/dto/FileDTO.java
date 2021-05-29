package com.org.team4.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class FileDTO {
	private long boardId;
	private long id;
	private String uploadFileName;
	private String realFileName;
	private String url;
}
