package com.org.team4.dto;

import java.io.Serializable;

<<<<<<< HEAD
import org.apache.commons.codec.digest.DigestUtils;

=======
>>>>>>> b012bfcf28fa8743dce867b31a84c67f736e98bc
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class LoginDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String email;
	private String password;

<<<<<<< HEAD
	public void setPassword(String password) {
		this.password = DigestUtils.sha512Hex(password);
	}
=======
//	public void setUsr_pw(String usr_pw) {
//		this.usr_pw = DigestUtils.sha512Hex(usr_pw);
//	}
	
>>>>>>> b012bfcf28fa8743dce867b31a84c67f736e98bc
}