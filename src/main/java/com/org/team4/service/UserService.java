package com.org.team4.service;

import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.UserDTO;

public interface UserService {
	
	UserDTO getUser(LoginDTO loginDTO) throws Exception;

}
