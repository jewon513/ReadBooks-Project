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
@NoArgsConstructor
@Builder
@AllArgsConstructor

public class NaverBooksVO {

	private String total;
	private String title;
	private String link;
	private String image;
	private String author;
	private String price;
	private String publisher;
	private String isbn;
	private String pubdate;
	
}
