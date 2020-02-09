package com.biz.rbooks.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReadBookDTO {

	
	private long rb_seq;//	number
	
	private String rb_bcode;//	varchar2(20)
	private String rb_date;//	varchar2(10)
	private String rb_regidate;//	varchar2(10)
	private String rb_subject;//	nvarchar2(20)
	private String rb_text;//	nvarchar2(400)
	private String rb_star;//	number
	private String rb_writer;// varchar2(20)

}
