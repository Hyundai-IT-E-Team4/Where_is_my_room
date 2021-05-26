package com.org.team4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.org.team4.dao.BoardDAO;
import com.org.team4.dto.LocationDTO;
import com.org.team4.dto.MapDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MapServiceImpl implements MapService{

	@Autowired
	@Qualifier(value="boardDAO")
	private BoardDAO boardDAO;
	
	
	@Override
	public List<MapDTO> getMapList() throws Exception {
		try {
			return boardDAO.getMapList();
		} catch (Exception e) {
			log.info(e.getMessage());
			throw e;
		}	
	}


	@Override
	public List<MapDTO> getMapListWithLoction(LocationDTO locationDTO) throws Exception {
		try {
			return boardDAO.getMapListWithLoction(locationDTO);
		} catch (Exception e) {
			log.info(e.getMessage());
			throw e;
		}	
	}




}