package com.org.team4.dao;

import java.sql.SQLException;
import java.util.List;

import com.org.team4.dto.FileDTO;
import com.org.team4.dto.FileUpdateDTO;

public interface FilesDAO {
	public void insertFile(FileDTO fileDTO) throws SQLException;
	public List<FileDTO> getFileList(long boardId) throws SQLException;
	public void deleteFileList(long boardId) throws SQLException;
	public void updateAndDelete(FileUpdateDTO fileDTO) throws SQLException;
}
