package com.org.team4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.org.team4.dao.UserDAO;
import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.RegisterDTO;
import com.org.team4.dto.UpdateEmailDTO;
import com.org.team4.dto.UpdatePasswordDTO;
import com.org.team4.dto.UserDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	public UserDTO getUser(LoginDTO loginDTO) throws Exception {

		UserDTO userInfo = userDAO.getUser(loginDTO);

		if (userInfo == null)
			throw new RuntimeException("이메일 주소 혹은 비밀번호가 틀립니다.");

		return userInfo;
	}

	public void registerUser(RegisterDTO registerDTO) throws Exception {
		userDAO.registerUser(registerDTO);
	}

	public int withdrawUser(LoginDTO loginDTO) throws Exception {
		return userDAO.withdrawUser(loginDTO);
	}

	public int checkNickname(String nickname) throws Exception {
		return userDAO.checkNickname(nickname);
	}

	public int updateUser(UserDTO userDTO) throws Exception {
		return userDAO.updateUser(userDTO);
	}

	public int updateEmail(UpdateEmailDTO updateEmailDTO) throws Exception {
		return userDAO.updateEmail(updateEmailDTO);
	}

	public int updatePassword(UpdatePasswordDTO updatePasswordDTO) throws Exception {
		return userDAO.updatePassword(updatePasswordDTO);
	}
}
