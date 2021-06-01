package com.org.team4.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CommentDTO {
	private long id;
	private long parentId;
	private long boardId;
	private long writerId;
	private String nickname;
	private String content;
	private String commentDate;
	private int read;
	private int deleted;
	private long totalCount;
}
