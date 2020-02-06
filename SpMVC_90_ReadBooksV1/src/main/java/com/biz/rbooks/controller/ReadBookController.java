package com.biz.rbooks.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.rbooks.domain.BooksDTO;
import com.biz.rbooks.domain.MemberDTO;
import com.biz.rbooks.domain.ReadBookDTO;
import com.biz.rbooks.service.BooksService;
import com.biz.rbooks.service.ReadBookService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "read")
@Controller
public class ReadBookController {
	
	@Autowired
	BooksService booksService;
	
	@Autowired
	ReadBookService readBookService;
	
	@ModelAttribute("readBookDTO")
	public ReadBookDTO getReadBooksDTO() {
		return new ReadBookDTO();
	}

	/*
	 *	메인에서 도서 목록을 클릭했을때 호출되는 Controller
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String booksDetail(
			@RequestParam("b_code") String b_code,
			@ModelAttribute("readBookDTO") ReadBookDTO readBookDTO,
			Model model) {
		
		// 기본적으로 독서일자와 독서 시간을 현재 시간으로 setting 해줌
		readBookDTO = readBookService.defaultSetting(readBookDTO);
		
		// 받은 b_code로 도서목록을 불러옴
		// 도서목록 DTO 안에는 독서록목록이 담겨있음
		BooksDTO booksDTO = booksService.detailView(b_code);
		
		// jsp를 돌려쓰기 위해서 조건을 체크하고자 Controller라는 Attribute를 값을 컨트롤마다 값을 달리하여 보냄
		model.addAttribute("Controller", "datail");
		model.addAttribute("booksDTO", booksDTO);
		
		return "detail";
	}
	
	
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public String booksDetailWrite(@ModelAttribute("readBookDTO") ReadBookDTO readBookDTO, HttpSession httpSession, Model model) {
		
		log.debug("작성하려고 한 readBookDTO :" + readBookDTO.toString());
		
		MemberDTO loginMember = (MemberDTO) httpSession.getAttribute("MEMBER");
		readBookDTO.setRb_writer(loginMember.getM_id());
		
		
		// INSERT를 수행하는데 exception이 발생할 경우 에러 페이지로 에러 메세지와 함께 이동하도록 함
		try {
			int ret = readBookService.writeReadBook(readBookDTO);
			String b_code = readBookDTO.getRb_bcode();
			return "redirect:/read/detail?b_code="+b_code;
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("Controller","error");
			model.addAttribute("msg", "등록하는 과정에서 서버에서 오류가 발생했습니다.");
			return "home";
			// TODO: handle exception
		}
		

	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String booksDetailUpdate(@ModelAttribute("readBookDTO") ReadBookDTO readBookDTO, @RequestParam("rb_seq") String rb_seq ,Model model) {
		
		readBookDTO = readBookService.findBySeq(rb_seq);
		
		log.debug("RB_SEQ로 찾은 READBOOKDTO (UPDATE.GET) : " + readBookDTO.toString());
		
		model.addAttribute("Controller", "update");
		model.addAttribute("readBookDTO", readBookDTO);
		
		return "detail";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String booksDetailUpdate(@ModelAttribute("readBookDTO") ReadBookDTO readBookDTO, Model model) {
		
		log.debug("FORM에서 받은 READBOOKDTO (UPDATE.POST) : " + readBookDTO.toString());
		
		try {
			int ret = readBookService.update(readBookDTO);
			String b_code = readBookDTO.getRb_bcode();
			model.addAttribute("Controller", "detail");
			return "redirect:/read/detail?b_code="+ b_code;
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("Controller","error");
			model.addAttribute("msg", "등록하는 과정에서 서버에서 오류가 발생했습니다.");
			return "home";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String booksDetailDelete(@RequestParam("rb_seq") long rb_seq) {
	
		int ret = readBookService.deleteReadBook(rb_seq);
		
		if(ret > 0) {
			return "DELETE OK";
		}else {
			return "DELETE FALSE";
		}
	}
	
}
