package com.org.team4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.org.team4.dao.UserDAO;
import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.RegisterDTO;
import com.org.team4.dto.UpdateEmailDTO;
import com.org.team4.dto.UpdatePasswordDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.util.Util;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private S3Service s3Service;

	public UserDTO getUser(LoginDTO loginDTO) throws Exception {

		UserDTO userInfo = userDAO.getUser(loginDTO);

		if (userInfo == null)
			throw new RuntimeException("이메일 주소 혹은 비밀번호가 틀립니다.");
		
		log.info("db의 프로필 경로는 {} " , userInfo.getProfile_img());
		log.info("로그인 정보는 {}", userInfo.toString());
		if(userInfo.getProfile_img() != null) userInfo.setProfile_img(s3Service.getFileURL("team4", Util.profileThumbFolder + userInfo.getProfile_img()));
		else userInfo.setProfile_img("/team4/resources/img/user.png");
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
	
	public int updateUser(UserDTO userDTO, MultipartFile uploadProfileImg) throws Exception {	
		String newFileName = Util.makeFileName(uploadProfileImg);
		String filePath = Util.getCurrentUploadPath() + newFileName;
		s3Service.fileUpload("team4", Util.profileFolder + filePath, uploadProfileImg.getBytes());
		s3Service.fileUpload("team4", Util.profileThumbFolder + filePath, Util.mamkeThumbnail(Util.getType(uploadProfileImg.getOriginalFilename()) , s3Service.getFileURL("team4", Util.profileFolder + filePath)));
		userDTO.setProfile_img(filePath);
		int result = userDAO.updateUser(userDTO);
		userDTO.setProfile_img(s3Service.getFileURL("team4", Util.profileThumbFolder + filePath));
		log.info(userDTO.getProfile_img());
		return result;
	}

	public int updateEmail(UpdateEmailDTO updateEmailDTO) throws Exception {
		return userDAO.updateEmail(updateEmailDTO);
	}

	public int updatePassword(UpdatePasswordDTO updatePasswordDTO) throws Exception {
		return userDAO.updatePassword(updatePasswordDTO);
	}
}
