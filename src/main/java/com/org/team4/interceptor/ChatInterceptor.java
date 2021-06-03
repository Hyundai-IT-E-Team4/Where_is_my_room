package com.org.team4.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.org.team4.dto.UserDTO;

public class ChatInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		UserDTO userInfo = (UserDTO)session.getAttribute("userInfo");
		if(userInfo == null) {
			response.sendError(401);
			return false;
		}
		return true;
	}
	
}
