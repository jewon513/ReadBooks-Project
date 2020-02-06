package com.biz.rbooks.persistence;

import com.biz.rbooks.domain.ReadBookDTO;

public interface ReadBookDao {

	public int insert(ReadBookDTO readBookDTO);

	public int delete(long rb_seq);

	public ReadBookDTO findBySeq(String rb_seq);

	public int update(ReadBookDTO readBookDTO);

}
