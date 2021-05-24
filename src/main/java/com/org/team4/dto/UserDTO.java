package com.org.team4.dto;

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
	
}