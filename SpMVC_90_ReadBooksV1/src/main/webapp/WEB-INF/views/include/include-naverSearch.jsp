<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<script>
	$(function() {

		$(document).on("click",".booklist",function() {

					let isbn = $(this).attr("data-isbn").substr(11)
					let title = $(this).attr("data-title")
					let author = $(this).attr("data-author")
					let publisher = $(this).attr("data-publisher")

					let temp = $(this).attr("data-pubdate")
					
					let pubdate = temp.substr(0, 4) + "-"
					+ temp.substr(4, 2) + "-"
					+ temp.substr(6)

					let price = $(this).attr("data-price")

					$("#b_code").val(isbn)
					$("#b_name").val(title)
					$("#b_auther").val(author)
					$("#b_comp").val(publisher)
					$("#b_year").val(pubdate)
					$("#b_iprice").val(price)

				})

	})
</script>

<c:choose>
	<c:when test="${naverSearch == null}">
		<h3>검색 결과가 없습니다.</h3>
	</c:when>
	<c:otherwise>
		<c:forEach items="${naverSearch}" var="vo">
			<div class="row">
				<div class="col-3 justify-content-center">
					<img class="rounded mx-auto d-block" src='${vo.image}'/>
				</div>
				<div class="col-9 booklist"  data-dismiss="modal" data-isbn="${vo.isbn}" data-title="${vo.title}" data-author="${vo.author}" data-publisher="${vo.publisher}" data-price="${vo.price}" data-pubdate="${vo.pubdate}">
					<p>${vo.title}</p>
					<small>${vo.author} / ${vo.publisher} / ${vo.pubdate} / ${vo.price} </small>
				</div>
			</div>
			<hr>
		</c:forEach>
	</c:otherwise>
</c:choose>


