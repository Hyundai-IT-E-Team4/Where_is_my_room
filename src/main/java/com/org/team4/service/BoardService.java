package com.org.team4.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.org.team4.dto.BoardDTO;
import com.org.team4.dto.BoardDeleteDTO;
import com.org.team4.dto.BoardDetailDTO;

public interface BoardService {
	long insertBoard(BoardDTO boardDTO, Map<String, MultipartFile> files) throws Exception;
	BoardDetailDTO detail(long id) throws Exception;
	int deleteBoard(BoardDeleteDTO boardDeleteDTO) throws Exception;
}