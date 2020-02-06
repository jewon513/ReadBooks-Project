package com.biz.rbooks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.BooksDTO;
import com.biz.rbooks.domain.ReadBookDTO;
import com.biz.rbooks.persistence.BooksDao;

@Service
public class BooksService {

	private final BooksDao booksDao;
	
	@Autowired
	public BooksService(BooksDao booksDao) {
		super();
		this.booksDao = booksDao;
	}

	public List<BooksDTO> selectAll() {
		// TODO Auto-generated method stub
		
		List<BooksDTO> booksList = booksDao.selectAll();
		
		return booksList;
	}

	
	// 독서록을 view에서 보여줄때 줄바꿈을 보여주기 위해서 사용하는 method
	public BooksDTO detailView(String b_code) {

		BooksDTO booksDTO = booksDao.findByBCode(b_code);
		
		if(booksDTO.getReadBookList() != null && booksDTO.getReadBookList().size()>0) {
			List<ReadBookDTO> readbookList = booksDTO.getReadBookList();
			
			for (ReadBookDTO vo : readbookList) {
			
				if(vo.getRb_text() != null && vo.getRb_text().contains("\n")) {
					vo.setRb_text(vo.getRb_text().replace("\n", "<br>"));	
				}
				
			}
		}
		
		return booksDTO;
	}

	public int booksWrite(BooksDTO booksDTO) {

		int ret = booksDao.insert(booksDTO);
		
		return ret;
	}
	

	public int booksDelete(String b_code) {

		int ret = booksDao.delete(b_code);
		
		return ret;
	}

	public BooksDTO findByBCode(String b_code) {

		BooksDTO booksDTO = booksDao.findByBCode(b_code);
		
		return booksDTO;
	}

	public int booksUpdate(BooksDTO booksDTO) {

		int ret = booksDao.update(booksDTO);
		
		return ret;
	}

	public boolean checkDuplicate(String b_code) {

		BooksDTO booksDTO = booksDao.findByBCode(b_code);
		
		if(booksDTO == null) {
			return true;
		}
		
		return false;
	}

	public List<BooksDTO> findByBName(String b_name) {

		List<BooksDTO> booksList = booksDao.findByBName(b_name);
		
		return booksList;
	}

	public int getBooksCount() {
		return booksDao.countBooks();
	}
	
	public List<BooksDTO> selectPagination(int offset, int limit){
		
		return booksDao.selectPagination(offset, limit);
		
	}
	
	public int getsearchBookCount(String search){
		return booksDao.countSearchBooks(search);
	}
	
	public List<BooksDTO> searchPagination(int offset, int limit, String search){
		
		return booksDao.findByBNamePagination(offset, limit, search);
		
	}
	
}
