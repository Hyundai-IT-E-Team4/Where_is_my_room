package com.org.team4.dto;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

import lombok.Data;

@Data
public class UpdateEmailDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String emailBefore;
	private String emailAfter;
	private String password;

	public void setPassword(String password) {
		this.password = DigestUtils.sha512Hex(password);
	}
}