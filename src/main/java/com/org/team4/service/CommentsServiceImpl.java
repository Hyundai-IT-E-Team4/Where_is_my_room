package com.org.team4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.org.team4.dao.CommentsDAO;
import com.org.team4.dto.CommentDTO;
import com.org.team4.dto.CommentDeleteDTO;
import com.org.team4.dto.CommentInsertDTO;
import com.org.team4.dto.CommentPagingDTO;
import com.org.team4.dto.CommentUpdateDTO;

@Service
public class CommentsServiceImpl implements CommentsService{

	@Autowired
	CommentsDAO commentsDAO;
	
	@Override
	public int enrollComment(CommentInsertDTO commentInsertDTO) throws Exception {
		// TODO Auto-generated method stub
		return commentsDAO.enrollComment(commentInsertDTO);
	}

	@Override
	public int updateComment(CommentUpdateDTO commentUpdateDTO) throws Exception {
		// TODO Auto-generated method stub
		int x = commentsDAO.updateComment(commentUpdateDTO);
		if(x == 0) throw new Exception();
		return 1;
	}

	@Override
	public int deleteComment(CommentDeleteDTO commentDeleteDTO) throws Exception {
		// TODO Auto-generated method stub
		int x = commentsDAO.deleteComment(commentDeleteDTO);
		if(x == 0) throw new Exception();
		return 1;
	}

	@Override
	public List<CommentDTO> getComment(CommentPagingDTO commentPagingDTO) throws Exception {
		// TODO Auto-generated method stub
		return commentsDAO.getComment(commentPagingDTO);
	}
	
	
}
