package com.org.team4.dto;

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
}