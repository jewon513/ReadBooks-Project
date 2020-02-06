package com.biz.rbooks.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.biz.rbooks.domain.BooksDTO;

public interface BooksDao {

	public List<BooksDTO> selectAll();
	
	public List<BooksDTO> selectPagination(@Param("offset") int offset, @Param("limit") int limit);
	
	public int countBooks();

	public BooksDTO findByBCode(String b_code);

	public int insert(BooksDTO booksDTO);

	public int delete(String b_code);

	public int update(BooksDTO booksDTO);

	public List<BooksDTO> findByBName(String b_name);

	public List<BooksDTO> findByBNamePagination(@Param("offset") int offset, @Param("limit") int limit, @Param("b_name") String search);
	
	public int countSearchBooks(String b_name);
}
