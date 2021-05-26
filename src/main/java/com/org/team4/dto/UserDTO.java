package com.org.team4.dto;

<<<<<<< HEAD
=======
<<<<<<< HEAD
import java.io.Serializable;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class UserDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long id;
	private String password;
	private String name;
	private String nickname;
	private String email;
	private String gender;


//	public void setUsr_pw(String usr_pw) {
//		this.usr_pw = DigestUtils.sha512Hex(usr_pw);
//	}
	
=======

>>>>>>> b012bfcf28fa8743dce867b31a84c67f736e98bc
import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

import lombok.Data;

@Data
public class UserDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long id;
	private String password;
	private String name;
	private String nickname;
	private String email;
	private String gender;

	public void setPassword(String password) {
		this.password = DigestUtils.sha512Hex(password);
	}
>>>>>>> 7a5a54682726f07d8cee10e7d9ee1e94318f7a75
}