package com.biz.rbooks.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.rbooks.domain.BooksDTO;
import com.biz.rbooks.domain.NaverBooksVO;
import com.biz.rbooks.domain.PageDTO;
import com.biz.rbooks.domain.ReadBookDTO;
import com.biz.rbooks.service.BooksService;
import com.biz.rbooks.service.NaverBookSearchService;
import com.biz.rbooks.service.PageService;
import com.biz.rbooks.service.ReadBookService;
import com.google.gson.JsonArray;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "/books")
@Controller
public class BooksController {

	@Autowired
	BooksService booksService;
	
	@Autowired
	ReadBookService readBookService;
	
	@Autowired
	PageService pageService;
	
	@Autowired
	NaverBookSearchService naverBook;
	
	@ModelAttribute("readBookDTO")
	public ReadBookDTO getReadBooksDTO() {
		return new ReadBookDTO();
	}
	
	@ModelAttribute("booksDTO")
	public BooksDTO getBooksDTO() {
		return new BooksDTO();
	}
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String booksList(Model model, @RequestParam(value = "currentPageNo", required = false, defaultValue = "1")int currentPageNo) {
		
		PageDTO pageDTO = pageService.getPagination(booksService.getBooksCount(), currentPageNo);
		
		if(pageDTO==null) {
			return "home";
		}
		
		List<BooksDTO> booksList = booksService.selectPagination(pageDTO.getOffset(), pageDTO.getLimit());
		
		log.debug("북 리스트 : " + booksList.toString());
		
		model.addAttribute("booksList", booksList);
		model.addAttribute("Controller", "list");
		model.addAttribute("PAGE", pageDTO);
		
		return "home";
	}
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String booksearch(@RequestParam(value ="b_name", required = false, defaultValue = "" )String b_name, Model model, @RequestParam(value = "currentPageNo", required = false, defaultValue = "1")int currentPageNo) {
		
		PageDTO pageDTO = pageService.getPagination(booksService.getsearchBookCount(b_name), currentPageNo);
		
		if(pageDTO == null) {
			model.addAttribute("booksList", null);
			model.addAttribute("Controller", "search");
			model.addAttribute("BNAME",b_name);
			model.addAttribute("PAGE", pageDTO);
			
			return "home";
		}
		
		
		
		List<BooksDTO> booksList = booksService.searchPagination(pageDTO.getOffset(), pageDTO.getLimit(), b_name);
		
		model.addAttribute("booksList", booksList);
		model.addAttribute("Controller", "search");
		model.addAttribute("BNAME",b_name);
		model.addAttribute("PAGE", pageDTO);
		
		return "home";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String booksWrite(@ModelAttribute("booksDTO")BooksDTO booksDTO, Model model) {
		
		// 초기 출판연도 오늘날짜로 초기화
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		
		booksDTO.setB_year(sd.format(date));
		
		model.addAttribute("Controller", "bookwrite");
		
		return "bookwrite";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String booksWrite(@ModelAttribute("booksDTO") BooksDTO booksDTO) {
		
		int ret = booksService.booksWrite(booksDTO);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String booksDelete(@RequestParam("b_code") String b_code) {
		
		int ret = booksService.booksDelete(b_code);
		
		if(ret>0) {
			return "OK";
		}else {
			return "FALSE";
		}
	}
	
	// b_code를 booksDTO의 b_code와 같은 변수 이름으로 받을 경우 중복해서 code가 들어가기 때문에 update가 안됨
	// 따라서 POST로 날리기전 GET page를 로드할때 @requestParam을 이용해서 b_code와는 다른 이름으로 변수를 받아서 사용한다.
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String booksUpdate(@ModelAttribute("booksDTO") BooksDTO booksDTO, Model model,
							@RequestParam("books_code")String b_code) {
		
		booksDTO = booksService.findByBCode(b_code);
		
		model.addAttribute("Controller","update");
		model.addAttribute("booksDTO", booksDTO);
		
		return "bookwrite";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String booksUpdate(@ModelAttribute("booksDTO") BooksDTO booksDTO, Model model) {
	
		log.debug("업데이트 컨트롤러");
		log.debug("업데이트(POST)로 날라온 booksDTO" + booksDTO.toString());
		
		int ret = booksService.booksUpdate(booksDTO);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public String checkDuplicate(String b_code) {
		
		boolean check = booksService.checkDuplicate(b_code);
		
		if(check) {
			return "OK";
		}else {
			return "FALSE";
		}
		
	}
	
	@RequestMapping(value = "naverSearch", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String bookSearchNaver(@RequestParam(value = "search", required = false, defaultValue = "") String search, 
			@RequestParam(value = "currentPageNo", required = false, defaultValue = "1")int currentPageNo,
			Model model) {
			
			
		try {
			List<NaverBooksVO> list = naverBook.getBooksList(search, currentPageNo);
			model.addAttribute("naverSearch",list);
		} catch (Exception e) {
			// TODO: 데이터 값이 없거나 파싱하는 부분에서 exception 발생
			model.addAttribute("naverSearch",null);
			e.printStackTrace();
		}
		return "include/include-naverSearch";
		
	}
	

	
}
