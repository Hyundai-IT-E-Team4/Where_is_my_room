package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.BoardDTO;
import com.org.team4.dto.BoardCheckDTO;
import com.org.team4.dto.BoardDetailDTO;
import com.org.team4.dto.LocationDTO;
import com.org.team4.dto.MapDTO;

public interface BoardDAO {

	 void insertBoard(BoardDTO boardinsertDTO) throws SQLException;
	 
	 BoardDetailDTO detail(long id) throws SQLException;
	 
	 int updateBoard(BoardDTO boardDTO) throws SQLException;
	 
	 BoardDetailDTO getUpdateInfo(long id) throws SQLException;

	 List<MapDTO> getMapListWithLoction(LocationDTO locationDTO) throws SQLException;
	 
	 int delete(BoardCheckDTO boardCheckDTO) throws SQLException;
	 
	 int writerCheck(BoardCheckDTO boardCheckDTO) throws SQLException;
}
