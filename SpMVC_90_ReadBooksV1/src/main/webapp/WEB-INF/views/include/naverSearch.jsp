<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<script>
	$(function() {

		$(document).on(
				"click",
				"tbody tr",
				function() {

					let tr = $(this);

					let isbn = $(this).attr("data-isbn").substr(11)
					let title = tr.find("td").eq(0).text();
					let author = tr.find("td").eq(1).text();
					let publisher = tr.find("td").eq(2).text();

					let pubdate = tr.find("td").eq(3).text().substr(0, 4) + "-"
							+ tr.find("td").eq(3).text().substr(4, 2) + "-"
							+ tr.find("td").eq(3).text().substr(6)

					let price = tr.find("td").eq(4).text();

					$("#b_code").val(isbn)
					$("#b_name").val(title)
					$("#b_auther").val(author)
					$("#b_comp").val(publisher)
					$("#b_year").val(pubdate)
					$("#b_iprice").val(price)

				})

	})
</script>

<style>
	
	tbody tr{
		cursor: pointer;
	}
	
</style>

<table class="table table-hover">
	<thead>
		<tr>
			<th>책제목</th>
			<th>저자</th>
			<th>출판사</th>
			<th>출판연도</th>
			<th>가격</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${naverSearch == null}">
				<tr>
					<td colspan="5">검색 결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${naverSearch}" var="vo">
					<tr data-isbn="${vo.isbn}" data-dismiss="modal">
						<td data-toggle="tooltip" data-placement="right"
							title="<img src='${vo.image}'/>" width="50%"><small>${vo.title}</small></td>
						<td width="20%"><small>${vo.author}</small></td>
						<td width="10%"><small>${vo.publisher}</small></td>
						<td width="10%"><small>${vo.pubdate}</small></td>
						<td width="10%"><small>${vo.price}</small></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>

