package com.org.team4.dao;

import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.RegisterDTO;
import com.org.team4.dto.UpdateEmailDTO;
import com.org.team4.dto.UpdatePasswordDTO;
import com.org.team4.dto.UserDTO;

public interface UserDAO {

	UserDTO getUser(LoginDTO loginDTO) throws Exception;

	void registerUser(RegisterDTO registerDTO) throws Exception;

	int withdrawUser(LoginDTO loginDTO) throws Exception;

	int checkNickname(String nickname) throws Exception;

	int updateUser(UserDTO userDTO) throws Exception;

	int updateEmail(UpdateEmailDTO updateEmailDTO) throws Exception;

	int updatePassword(UpdatePasswordDTO updatePasswordDTO) throws Exception;

}
