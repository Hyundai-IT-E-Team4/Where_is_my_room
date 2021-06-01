package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.CommentDTO;
import com.org.team4.dto.CommentDeleteDTO;
import com.org.team4.dto.CommentInsertDTO;
import com.org.team4.dto.CommentPagingDTO;
import com.org.team4.dto.CommentUpdateDTO;

public interface CommentsDAO {
	int enrollComment(CommentInsertDTO commentInsertDTO) throws SQLException;
	int updateComment(CommentUpdateDTO commentUpdateDTO) throws SQLException;
	int deleteComment(CommentDeleteDTO commentDeleteDTO) throws SQLException;
	List<CommentDTO> getComment(CommentPagingDTO commentPagingDTO) throws SQLException;
}