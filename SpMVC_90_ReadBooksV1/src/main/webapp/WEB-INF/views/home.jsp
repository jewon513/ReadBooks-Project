<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My homepage</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- Jewons Css -->
<link rel="stylesheet" href="${rootPath}/css/main.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>


<script type="text/javascript">
	function validateISBN(text) {
		//ISBN-10이나 ISBN-13형식에 맞는지 검사하는 정규식 변수 regex
		var regex = /^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$/;

		if (regex.test(text)) {
			//ISBN 숫자가 아닌 것을 제거한 후 배열로 분리
			var chars = text.replace(/[^0-9X]/g, "").split("");
			//chars 에서 끝 ISBN 숫자를 제거하고 그것을 last에 대입
			var last = chars.pop();
			var sum = 0;
			var digit = 10;

			var check;

			if (chars.length == 9) {
				//ISBN-10 검증 번호(체크섬 숫자) 계산
				for (var i = 0; i < chars.length; i++) {
					sum += digit * parseInt(chars[i], 10);
					digit -= 1;
				}
				check = 11 - (sum % 11);
				if (check == 10) {
					check = "X";
				} else if (check == 11) {
					check = "0";
				}
			} else {
				//ISBN-13 검증 번호 계산
				for (var i = 0; i < chars.length; i++) {
					sum += (i % 2 * 2 + 1) * parseInt(chars[i], 10);
				}
				check = 10 - (sum % 10);
				if (check == 10) {
					check = "0";
				}
			}

			if (check == last) {
				return true;
			} else {
				return false;
			}

		} else {
			return false;
		}
	}//validateISBN 

	$(function() {
		$(".book").click(
				function() {

					var b_code = $(this).attr("data-id")

					document.location.href = "${rootPath}/read/detail?b_code="
							+ b_code;

				})

		$("#btn-enroll").click(function() {

			let b_code = $("#b_code").val()

			if (b_code == "") {
				alert("도서코드는 반드시 입력해야합니다.")
				$("#b_code").focus()
				return false;
			}

			if (!validateISBN(b_code)) {
				alert("잘못된 ISBN 코드입니다. 다시 입력해주세요")
				return false;
			}

			let b_name = $("#b_name").val()

			if (b_name == "") {
				alert("도서명은 반드시 입력해야합니다.")
				$("#b_name").focus()
				return false;
			}

			if (b_name.length > 100) {
				alert("도서명은 100자 이하로 입력해주세요")
				$("#b_name").focus()
				return false;
			}

			let b_auther = $("#b_auther").val()

			if (b_auther == "") {
				alert("저자는 반드시 입력해야합니다.")
				$("#b_auther").focus()
				return false;
			}

			if (b_auther.length > 20) {
				alert("저자는 20자 이하로 입력해주세요.")
				$("#b_auther").focus()
				return false;
			}

			let b_comp = $("#b_comp").val()

			if (b_comp.length > 20) {
				alert("출판사는 20자 이하로 입력해주세요.")
				$("#b_comp").focus()
				return false;
			}

			// 도서를 등록할때
			if ("${Controller}" == "bookwrite") {
				$.ajax({

					url : '${rootPath}/books/check',
					data : {
						b_code : b_code
					},
					metohd : 'GET',
					success : function(result) {
						if (result == "OK") {
							$("form").submit()
						} else if (result == "FALSE") {
							alert("이미 등록된 도서입니다.")
							return false;
						}
					},
					error : function() {
						alert("서버 통신 오류")
						return false;
					}

				})
			}

			// 도서정보를 수정할때
			if ("${Controller}" == "update") {
				$("form").submit()
			}

		})
	})
</script>

</head>

<body>

	<section class="container">

		<%@ include file="/WEB-INF/views/include/header.jsp"%>

		<c:if test="${Controller == 'list' || Controller == 'search'}">
			<article id="main-area">
				<table class="table table-hover">
					<thead>
						<tr class="bg-dark text-light">
							<th>도서코드</th>
							<th>도서명</th>
							<th>저자</th>
							<th>출판사</th>
							<th>출판연도</th>
							<th>가격</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${booksList == null}">
								<tr>
									<td colspan="6">검색 결과가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${booksList}" var="vo">
									<tr class="book" data-id="${vo.b_code}">
										<td>${vo.b_code}</td>
										<td>${vo.b_name}</td>
										<td>${vo.b_auther}</td>
										<td>${vo.b_comp}</td>
										<td>${vo.b_year}</td>
										<td>${vo.b_iprice}</td>
									</tr>
								</c:forEach>
							</c:otherwise>

						</c:choose>
					</tbody>
				</table>
			</article>
		</c:if>

		<c:if test="${Controller == 'bookwrite' || Controller == 'update'}">
			<article id="main-area">
				<%@ include file="/WEB-INF/views/include/bookWrite.jsp"%>
			</article>
		</c:if>

		<c:if test="${Controller == 'list' || Controller == 'search'}">
			<div class="jewon-page">
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link"
						href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.firstPageNo}&b_name=${BNAME}">처음</a></li>
					<li class="page-item"><a class="page-link"
						href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.prePageNo}&b_name=${BNAME}">이전</a></li>
					<c:forEach begin="${PAGE.startPageNo}" end="${PAGE.endPageNo}"
						var="pageNo">
						<li
							class="page-item <c:if test="${PAGE.currentPageNo == pageNo}">active</c:if>"><a
							class="page-link"
							href="${rootPath}/books/${Controller}?currentPageNo=${pageNo}&b_name=${BNAME}">${pageNo}</a></li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.nextPageNo}&b_name=${BNAME}">다음</a></li>
					<li class="page-item"><a class="page-link"
						href="${rootPath}/books/${Controller}?currentPageNo=${PAGE.finalPageNo}&b_name=${BNAME}">끝</a></li>
				</ul>
			</div>
		</c:if>

		<c:if test="${Controller == 'error'}">
			<br>
			<h3 class="text-center">${msg}</h3>
			<br>
		</c:if>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	</section>

</body>
</html>