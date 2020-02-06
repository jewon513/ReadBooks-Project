package com.biz.rbooks.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.rbooks.config.NaverConfig;
import com.biz.rbooks.domain.NaverBooksVO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NaverBookSearchService {

	private final String naver_book_url = "https://openapi.naver.com/v1/search/book.json";
	
	public List<NaverBooksVO> getBooksList(String search, int currentPageNo) {

		String responseString = this.getSearchBooks(search, currentPageNo);
		
		log.debug(responseString);
		
		JsonElement jsonElement = JsonParser.parseString(responseString);
		
		
		JsonArray jItems = (JsonArray) jsonElement.getAsJsonObject().get("items");
		
		Gson gson = new Gson();
		
		TypeToken<List<NaverBooksVO>> token = new TypeToken<List<NaverBooksVO>>(){};
		
		List<NaverBooksVO> searchBookList = gson.fromJson(jItems, token.getType());
		
		searchBookList.get(0).setTotal(jsonElement.getAsJsonObject().get("total").getAsString());
		
		return searchBookList;
	}

	public String getSearchBooks(String search, int currentPageNo) {

		URL url;
		HttpURLConnection httpConnection;
		String queryText = null;
		try {
			queryText = URLEncoder.encode(search, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		queryText = this.naver_book_url + "?query=" + queryText;
		queryText += "&display=100";
		queryText += "&start=" + currentPageNo;

		try {
			url = new URL(queryText);

			httpConnection = (HttpURLConnection) url.openConnection();

			httpConnection.setRequestMethod("GET");

			httpConnection.setRequestProperty("X-Naver-Client-Id", NaverConfig.NaverClientId);
			httpConnection.setRequestProperty("X-Naver-Client-Secret", NaverConfig.NaverClientSecret);

			int responseCode = httpConnection.getResponseCode();
			
			log.debug("NaverBookSearchService responseCode : " + responseCode);
			
			if(responseCode == 200) {
				InputStreamReader is = new InputStreamReader(httpConnection.getInputStream());
				
				BufferedReader buffer = new BufferedReader(is);
				
				String responseString ="";
				String reader = new String();
				
				while (true) {
					reader = buffer.readLine();
					if(reader == null) {
						break;
					}
					responseString += reader;
				}
				buffer.close();
				
				return responseString;
				
			}
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;

	}

}
