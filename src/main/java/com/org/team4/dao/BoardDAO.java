package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.BoardDTO;
import com.org.team4.dto.BoardDeleteDTO;
import com.org.team4.dto.BoardDetailDTO;
import com.org.team4.dto.LocationDTO;
import com.org.team4.dto.MapDTO;

public interface BoardDAO {

	 void insertBoard(BoardDTO boardinsertDTO) throws SQLException;
	 
	 BoardDetailDTO detail(long id) throws SQLException;
	
	 List<MapDTO> getMapList() throws SQLException;

	 List<MapDTO> getMapListWithLoction(LocationDTO locationDTO) throws SQLException;
	 
	 int delete(BoardDeleteDTO boardDeleteDTO) throws SQLException;

	
}
