# 독서록 프로젝트(2019-01-10)


### 주요 기능
* 도서를 등록하고 그 도서에 대해서 독서록을 작성 할 수 있음.
* 독서 일자, 독서 시작 시간, 독서 시간, 한줄평, 긴줄평, 점수 등을 입력하여 등록 할 수 있음.
* 등록된 도서를 검색 할 수 있음.
* 멀티사용자 환경은 고려하지 않았음.

### 상세 기능
* 도서와 독서록 등록시 view단에서 jquery를 사용하여 유효성 검사를 했음.
* 도서와 독서록 등록은 로그인을 해야만 가능(Interceptor 기능을 활용).
* 네이버 도서 검색 API를 이용하여 도서 등록시 간편하게 등록 할 수 있도록 함.
* pagination 구현.

### Backend
* Java 1.8
* Spring 5.1.11 버전 사용
* Oracle과 mybatis사용

### ProntEnd
* HTML, CSS, JS 사용
* JSP, jquery 사용

### 기타
* 도서 정보 등록시 정규식을 활용하여 유효성 검사 (https://m.blog.naver.com/PostView.nhn?blogId=javaking75&logNo=220083550812&proxyReferer=https%3A%2F%2Fwww.google.com%2F)
* 폰트는 아리따돋움체를 웹폰트로 사용 (https://noonnu.cc/font_page/15)

