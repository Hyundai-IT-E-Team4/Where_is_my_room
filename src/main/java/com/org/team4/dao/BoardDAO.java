package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.BoardInsertDTO;
import com.org.team4.dto.MapDTO;

public interface BoardDAO {

	 void insertBoard(BoardInsertDTO boardinsertDTO) throws SQLException;
	
	 List<MapDTO> getMapList() throws SQLException;

}
