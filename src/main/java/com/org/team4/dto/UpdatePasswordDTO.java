package com.org.team4.dto;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

import lombok.Data;

@Data
public class UpdatePasswordDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String passwordBefore;
	private String passwordAfter;
	private String email;

	public void setPasswordBefore(String passwordBefore) {
		this.passwordBefore = DigestUtils.sha512Hex(passwordBefore);
	}

	public void setPasswordAfter(String passwordAfter) {
		this.passwordAfter = DigestUtils.sha512Hex(passwordAfter);
	}
}