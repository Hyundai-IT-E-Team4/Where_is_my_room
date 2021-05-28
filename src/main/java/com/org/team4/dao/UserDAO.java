package com.org.team4.dao;

import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.RegisterDTO;
import com.org.team4.dto.UserDTO;

public interface UserDAO {
	
	UserDTO getUser(LoginDTO loginDTO) throws Exception;
	
	void registerUser(RegisterDTO registerDTO) throws Exception;
	
	Long withdrawUser(LoginDTO loginDTO) throws Exception;
	
	int checkNickname(String nickname) throws Exception;

}
