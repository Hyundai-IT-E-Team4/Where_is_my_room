package com.org.team4.dto;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDTO implements Serializable {

	long id;
	String password;
	String name;
	String nickname;
	String email;
	String gender;

	public UserDTO(long id, String password, String name, String nickname, String email, String gender) {
		this.id = id;
		setPassword(password);
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.gender = gender;
	}

	public void setPassword(String password) {
		this.password = DigestUtils.sha512Hex(password);
	}
}