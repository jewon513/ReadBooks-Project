package com.biz.rbooks.domain;

import java.util.List;

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

public class BooksDTO {

	private String b_code;//	varchar2(20)
	private String b_name;//	nvarchar2(125)
	private String b_auther;//	nvarchar2(125)
	private String b_comp;//	nvarchar2(125)
	private String b_year;//	varchar2(10)
	private int b_iprice;//	number
	
	private List<ReadBookDTO> readBookList;

}
