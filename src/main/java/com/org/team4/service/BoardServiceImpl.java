package com.org.team4.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.org.team4.dao.BoardDAO;
import com.org.team4.dto.BoardInsertDTO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	@Qualifier(value="boardDAO")
	private BoardDAO boardDAO;
	
	@Override
	public void insertBoard(BoardInsertDTO boardinsertDTO) throws Exception {
		try {
			boardDAO.insertBoard(boardinsertDTO);
		} catch (Exception e) {
			log.info(e.getMessage());
			throw e;
		}
		
	}

}