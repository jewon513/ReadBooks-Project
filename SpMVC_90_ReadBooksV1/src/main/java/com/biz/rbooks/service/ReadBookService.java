package com.biz.rbooks.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.ReadBookDTO;
import com.biz.rbooks.persistence.ReadBookDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReadBookService {

	@Autowired
	ReadBookDao readBookDao;
	
	public int writeReadBook(ReadBookDTO readBookDTO) {

		int	ret = readBookDao.insert(readBookDTO);
		
		return ret;
		
	}
	
	public ReadBookDTO defaultSetting(ReadBookDTO readBookDTO) {
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		
		String rb_date = sd.format(date);
		
		readBookDTO.setRb_date(rb_date);
		readBookDTO.setRb_regidate(rb_date);
		
		return readBookDTO;
	}

	public int deleteReadBook(long rb_seq) {

		int ret = readBookDao.delete(rb_seq);
		
		return ret;
	}

	public ReadBookDTO findBySeq(String rb_seq) {

		ReadBookDTO readBookDTO = readBookDao.findBySeq(rb_seq);
		
		return readBookDTO;
	}

	public int update(ReadBookDTO readBookDTO) {

		int ret = readBookDao.update(readBookDTO);
		
		return ret;
	}
	
}
