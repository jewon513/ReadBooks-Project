package com.biz.rbooks.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.MemberDTO;
import com.biz.rbooks.persistence.MemberDao;

@Service
public class MemberService {
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	public int memberJoin(MemberDTO memberDTO) {

		String pw = memberDTO.getM_password();
		
		memberDTO.setM_password(passwordEncoder.encode(pw));
		
		int ret = memberDao.insert(memberDTO);
		
		return ret;
	}

	public MemberDTO loginCheck(String user_id, String user_pw) {

		MemberDTO memberDTO = memberDao.findById(user_id);
		
		if(memberDTO == null) {
			return null;
		}
		
		String dbPassword = memberDTO.getM_password();
		
		if(passwordEncoder.matches(user_pw, dbPassword)) {
			
			Date date = new Date();
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String m_login_date = sd.format(date);
			
			memberDTO.setM_login_date(m_login_date);
			
			int ret = memberDao.update(memberDTO);
			
			return memberDTO;
		}
	
		return null;
	}
	
}
