package com.org.team4.dto;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class LoginDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String email;
	private String password;

	public void setPassword(String password) {
		this.password = DigestUtils.sha512Hex(password);
	}
}