package com.org.team4.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.org.team4.dto.BoardDTO;
import com.org.team4.dto.BoardCheckDTO;
import com.org.team4.dto.BoardDetailDTO;

public interface BoardService {
	long insertBoard(BoardDTO boardDTO, Map<String, MultipartFile> files) throws Exception;
	void update(BoardDTO boardDTO, List<Long> imgs, Map<String, MultipartFile> files) throws Exception;
	BoardDetailDTO detail(long id) throws Exception;
	BoardDetailDTO getUpdateInfo(long id) throws Exception;
	int deleteBoard(BoardCheckDTO boardDeleteDTO) throws Exception;
	int writerCheck(BoardCheckDTO boardCheckDTO) throws Exception;
}