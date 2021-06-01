package com.org.team4.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentInsertDTO {
	private Long id;
	private Long parentId;
	private Long writerId;
	private Long boardId;
	private String content;
}
