package com.org.team4.service;

import java.util.List;

import com.org.team4.dto.CommentDTO;
import com.org.team4.dto.CommentDeleteDTO;
import com.org.team4.dto.CommentInsertDTO;
import com.org.team4.dto.CommentPagingDTO;
import com.org.team4.dto.CommentUpdateDTO;

public interface CommentsService {
	int enrollComment(CommentInsertDTO commentInsertDTO) throws Exception;
	int updateComment(CommentUpdateDTO commentUpdateDTO) throws Exception;
	int deleteComment(CommentDeleteDTO commentDeleteDTO) throws Exception;
	List<CommentDTO> getComment(CommentPagingDTO commentPagingDTO) throws Exception;
}
