<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My homepage</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- Jewons Css -->
<link rel="stylesheet" href="${rootPath}/css/main.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>


<script type="text/javascript">
	$(function() {

		$(".close").click(
				function() {
					let rb_seq = $(this).attr("data-rbseq")
					let rb_bcode = $(this).attr("data-rbbcode")

					if (confirm("삭제하시겠습니까?")) {
						$.ajax({
							url : '${rootPath}/read/delete',
							data : {rb_seq : rb_seq},
							method : 'POST',
							success : function(result) {
								if (result == 'DELETE OK') {
									alert("삭제 성공")
									document.location.href = '${rootPath}/read/detail?b_code='+ rb_bcode
								} else if (result == 'DELETE FALSE') {
									alert("삭제 실패")
								}
							},
							error : function() {
								alert("서버 통신 에러")
							}
						})
					}
				})

		$(".read-update").click(function() {

			let rb_seq = $(this).attr("data-rbseq")

			document.location.href = '${rootPath}/read/update?rb_seq=' + rb_seq

		})

		$("#books-update")
				.click(
						function() {

							let b_code = $(this).attr("data-bcode")

							document.location.href = '${rootPath}/books/update?books_code='
									+ b_code

						})

		$("#books-delete").click(function() {

			let b_code = $(this).attr("data-bcode")

			if(confirm("삭제하시겠습니까?")){
				$.ajax({

					url : '${rootPath}/books/delete',
					data : {
						b_code : b_code
					},
					method : 'POST',
					success : function(result) {
						if (result == "OK") {
							alert("삭제 성공")
							document.location.href = "${rootPath}/"
						} else if (result == "FALSE") {
							alert("삭제 실패")
						}
					},
					error : function() {
						alert("서버통신 오류")
					}

				})
			}

		})

		$("#btn-enroll").click(function() {

			let rb_date = $("#rb_date").val()

			if (rb_date == "") {
				alert("독서일자는 반드시 입력해야합니다.")
				$("#rb_date").focus()
				return false;
			}
			
			let rb_subject = $("#rb_subject").val()
			
			if (rb_subject.length > 20){
				alert("한줄소감은 20자 이하로 작성해주세요")
				$("#rb_subject").focus()
				return false;
				
			}

			let rb_text = $("#rb_text").val()

			if (rb_text.length > 1000) {
				alert("1000자 이하로 작성해주세요")
				$("#rb_text").focus()
				return false;
			}
			

		})

	})
</script>

</head>

<body>

	<section class="container">

		<%@ include file="/WEB-INF/views/include/header.jsp"%>

		<c:if test="${Controller == 'datail'}">
			<article id="main-area">
				<table class="table">
					<tr>
						<th class="bg-dark text-light" width="10%">도서코드</th>
						<td width="40%">${booksDTO.b_code}</td>
						<th class="bg-dark text-light" width="10%">도서명</th>
						<td width="40%">${booksDTO.b_name}</td>
					</tr>
					<tr>
						<th class="bg-dark text-light">저자</th>
						<td>${booksDTO.b_auther}</td>
						<th class="bg-dark text-light">출판사</th>
						<td>${booksDTO.b_comp}</td>
					</tr>
					<tr>
						<th class="bg-dark text-light">출판년도</th>
						<td>${booksDTO.b_year}</td>
						<th class="bg-dark text-light">가격</th>
						<td>${booksDTO.b_iprice}</td>
					</tr>
				</table>
				<div class="d-flex justify-content-end">
					<button id="books-update" class="btn btn-primary" data-bcode="${booksDTO.b_code}">수정</button>
					<button id="books-delete" class="btn btn-danger" data-bcode="${booksDTO.b_code}">삭제</button>
				</div>
				<hr />

				<c:choose>
					<c:when test="${fn:length(booksDTO.readBookList) <1}">
						<p class="text-center">아직 작성된 독서록이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<table class="table table-hover">
							<thead>
								<tr class="bg-dark text-light">
									<th width="15%">독서 일자</th>
									<th width="75%">한줄 소감</th>
									<th width="10%">점수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${booksDTO.readBookList}" var="vo">
									<tr class="book" data-toggle="modal" data-target="#a${vo.rb_seq}">
										<td>${vo.rb_date}</td>
										<td>${vo.rb_subject}</td>
										<td>${vo.rb_star}</td>
									</tr>
									<div class="modal fade" id="a${vo.rb_seq}">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">

												<!-- Modal Header -->
												<div class="modal-header">
													<h4 class="modal-title">${vo.rb_subject}</h4>
													<button type="button" class="close" data-rbseq="${vo.rb_seq}" data-rbbcode="${vo.rb_bcode}">&times;</button>
												</div>

												<!-- Modal body -->
												<div class="modal-body">
													<span class="text-primary">독서일자 :</span> ${vo.rb_date}<br> 
													<span class="text-primary">독서시작시각 :</span> ${vo.rb_stime}<br> 
													<span class="text-primary">독서시간 :</span> ${vo.rb_rtime}<br>
													<p>${vo.rb_text}</p>
												</div>
												<!-- Modal footer -->
												<div class="modal-footer">
													<button type="button" class="btn btn-primary read-update" data-rbseq="${vo.rb_seq}">수정</button>
													<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>

			</article>

			<%@ include file="/WEB-INF/views/include/readWrite.jsp"%>

		</c:if>

		<c:if test="${Controller == 'update'}">
			<article id="main-area">
				<%@ include file="/WEB-INF/views/include/readWrite.jsp"%>
			</article>
		</c:if>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
		
	</section>

</body>
</html>