package com.biz.rbooks.persistence;

import com.biz.rbooks.domain.MemberDTO;

public interface MemberDao {

	public int insert(MemberDTO memberDTO);

	public MemberDTO findById(String user_id);

	public int update(MemberDTO memberDTO);

}
