package com.biz.rbooks.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.rbooks.domain.MemberDTO;
import com.biz.rbooks.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "member")
@Controller
public class MemberController {
	
	
	MemberService memberservice;
	
	@ModelAttribute("memberDTO")
	public MemberDTO memberDTO() {
		return new MemberDTO();
	}
	
	@Autowired
	public MemberController(MemberService memberservice) {
		super();
		this.memberservice = memberservice;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpSession httpSession) {
		
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("MEMBER");
		
		if(memberDTO != null) {
			return "redirect:/";
		}
		
		return "login";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpSession httpSession, @RequestParam("m_id")String user_id, @RequestParam("m_password")String user_pw) {
		
		MemberDTO memberDTO = memberservice.loginCheck(user_id, user_pw);
		
		if(memberDTO == null) {
			return "FALSE";
		}else {
			httpSession.setAttribute("MEMBER", memberDTO);
			return "OK";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logout(HttpSession httpSession) {
	
		httpSession.removeAttribute("MEMBER");
		
		return "OK";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGet(@ModelAttribute("memberDTO") MemberDTO memberDTO) {
		
		return "join";
	}
	
	@ResponseBody
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(@ModelAttribute("memberDTO") MemberDTO memberDTO) {
		
		int ret = memberservice.memberJoin(memberDTO);
		
		if(ret>0) {
			return "OK";
		}else {
			return "FALSE";
		}
		
	}
	
}
