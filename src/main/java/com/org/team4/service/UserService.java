package com.org.team4.service;

import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.UserDTO;

public interface UserService {
	
	UserDTO getUser(LoginDTO loginDTO) throws Exception;
	
	void registerUser(UserDTO userDTO) throws Exception;

	void withdrawUser(LoginDTO loginDTO) throws Exception;
	
	int checkNickname(String nickname) throws Exception;

}
