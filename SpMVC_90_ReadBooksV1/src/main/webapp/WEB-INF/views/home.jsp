<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/views/include/include-title.jsp"%>

</head>

<script>
	$(function() {

		$(".book").click(function() {
			var b_code = $(this).attr("data-id")
			
			document.location.href = "${rootPath}/read/detail?b_code="+ b_code;

		})
		
		$(".search-input").keypress(function(key){
			
			if(key.keyCode == 13){
				
				let keyword = $(".search-input").val()
				
				if ($.trim(keyword) == ""){
					
					return false;
					
				}
				
			}
			
		})

	})
</script>

<style>
	.book:hover{
		cursor: pointer;
		color: #1a82ae;
	}
	
</style>

<body>

	<!-- nav -->
	<%@ include file="/WEB-INF/views/include/include-nav.jsp"%>

	<!-- Main Body -->
	<div class="container">
		<p>
		<h1>도서리스트</h1>
		</p>
		<hr>
	</div>



	<div class="container">
		<c:choose>
			<c:when test="${booksList == null}">
				<h3>등록된 도서가 없습니다.</h3>
				<hr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${booksList}" var="vo">
					<div class="row align-items-center book" data-id="${vo.b_code}">
						<div class="col-12">
							<h4 class="text-reset">${vo.b_name}</h4>
						</div>
						<div class="col-12">
							<small>${vo.b_code}</small> <small>${vo.b_auther}</small> <small>${vo.b_comp}</small> <small>${vo.b_year}</small>
						</div>
					</div>
					<hr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>

	<c:if test="${booksList != null}">
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link" href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.firstPageNo}&b_name=${BNAME}">처음</a></li>
			<li class="page-item"><a class="page-link" href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.prePageNo}&b_name=${BNAME}">이전</a></li>
			<c:forEach begin="${PAGE.startPageNo}" end="${PAGE.endPageNo}" var="pageNo">
				<li class="page-item <c:if test="${PAGE.currentPageNo == pageNo}">active</c:if>"><a class="page-link" href="${rootPath}/books/${Controller}?currentPageNo=${pageNo}&b_name=${BNAME}">${pageNo}</a></li>
			</c:forEach>
			<li class="page-item"><a class="page-link" href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.nextPageNo}&b_name=${BNAME}">다음</a></li>
			<li class="page-item"><a class="page-link" href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.finalPageNo}&b_name=${BNAME}">끝</a></li>
		</ul>
	</c:if>
	
	<div class="container">
		<form class="form-inline justify-content-center" action="${rootPath}/books/search" method="get">
	    	<input class="form-control search-input" type="text" placeholder="Search" name="b_name">
 	 	</form>
	</div>
	
	<div class="bottom-margin-box">
		
	</div>

</body>
</html>