package com.org.team4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.org.team4.dao.UserDAO;
import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.UserDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	public UserDTO getUser(LoginDTO loginDTO) throws Exception {
		try {
			UserDTO userInfo = userDAO.getUser(loginDTO);

			if (userInfo == null)
				throw new RuntimeException("아이디 혹은 비밀번호가 틀립니다.");

			return userInfo;
		} catch (Exception e) {
			log.info(e.getMessage());
			throw e;
		}
	}
}
