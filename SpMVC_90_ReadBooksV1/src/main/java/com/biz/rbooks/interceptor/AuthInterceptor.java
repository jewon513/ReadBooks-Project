package com.biz.rbooks.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

				log.debug("나는 인터셉터입니다.");
		
				HttpSession httpSession = request.getSession();
				
				Object sessionObj = httpSession.getAttribute("MEMBER");
				
				if(sessionObj == null) {
					
					response.sendRedirect(
							request.getContextPath() + "/member/login");
					return false;
					
				}
		
		return super.preHandle(request, response, handler);
	}

	
	
}
