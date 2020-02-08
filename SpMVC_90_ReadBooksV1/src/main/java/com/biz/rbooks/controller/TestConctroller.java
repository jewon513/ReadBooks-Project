package com.biz.rbooks.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestConctroller {

	@RequestMapping(value = "hometest", method = RequestMethod.GET)
	public String homeTest() {
		
		
		return "readbookwrite-test";
	}

}
