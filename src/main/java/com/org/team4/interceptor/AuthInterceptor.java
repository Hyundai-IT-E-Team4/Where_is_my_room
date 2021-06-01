package com.org.team4.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.org.team4.dto.UserDTO;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if (handler instanceof HandlerMethod == false) 
			return true;
		

		HandlerMethod handlerMethod = (HandlerMethod) handler;

		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);

		if (auth == null) 
			return true;
		
		HttpSession session = request.getSession();
		
		if (session == null) {
			response.sendRedirect(request.getContextPath() + "/users/login");
//			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			return false;
		}

		UserDTO authUser = (UserDTO) session.getAttribute("userInfo");
		
		if (authUser == null) {
			response.sendRedirect(request.getContextPath() + "/users/login");			
//			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			return false;
		}

		// 관리자
		String role = auth.role().toString();
		
		if ("ADMIN".equals(role)) {
			
			if ("root".equals(authUser.getId()) == false) {
				response.sendRedirect(request.getContextPath());
				return false;
			}
		}

		return true;
	}
}