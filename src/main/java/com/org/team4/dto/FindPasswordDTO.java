package com.org.team4.dto;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class FindPasswordDTO implements Serializable {

   private static final long serialVersionUID = 1L;

   private String email;
   private String name;
   private String newPassword;

   public void setNewPassword(String newPassword) {
      this.newPassword = DigestUtils.sha512Hex(newPassword);
   }
}