<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/views/include/include-title.jsp"%>

</head>

<script type="text/javascript">
	$(function(){
		
		$("#books-update").click(
				
			function() {
				
				let b_code = $(this).attr("data-bcode")

				document.location.href = '${rootPath}/books/update?books_code='	+ b_code

		})
		
		
		// 책 지우기
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
		
		// 독서록 쓰기
		$(".read-write").click(function(){
			
			let b_code = "${booksDTO.b_code}"
			
			document.location.href = "${rootPath}/read/write?b_code=" + b_code
			
		})
		
		// 독서록 지우기
		$(".close").click(function() {
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
		
				
		// 독서록 수정하기
		$(".read-update").click(function() {

			let rb_seq = $(this).attr("data-rbseq")

			document.location.href = '${rootPath}/read/update?rb_seq=' + rb_seq

		})
		
	})
</script>

<style>
	
	.read-list{
		margin: 10px 0;
	}

	.read-list:hover{
		cursor: pointer;
		color: #d23430;
		background-color: #ddd;
	}
	
	.div-subject{
		margin:5px 0;
		font-weight: bold;
	}
</style>

<body>

	<!-- nav -->
	<%@ include file="/WEB-INF/views/include/include-nav.jsp"%>

	<!-- Books Info Body -->
	<div class="container">
		<p>
		<h1>${booksDTO.b_name}</h1>
		</p>
		<div>
			<small>ISBN: ${booksDTO.b_code} / 저자: ${booksDTO.b_auther}</small>
		</div>
		<div>
			<small>출판사: ${booksDTO.b_comp}</small>
		</div>
		<div>
			<small>출판연도: ${booksDTO.b_year} / 정가: ${booksDTO.b_iprice}</small>
		</div>
		<div class="d-flex justify-content-end">
			<button class="btn btn-primary btn-sm" id="books-update" data-bcode="${booksDTO.b_code}">수정</button>&nbsp;
			<button class="btn btn-danger btn-sm" id="books-delete" data-bcode="${booksDTO.b_code}">삭제</button>
		</div>
		<hr>
	</div>

	<!-- ReadBooks Body -->
	<div class="container">
		<c:choose>
			<c:when test="${fn:length(booksDTO.readBookList) <1}">
				<p class="text-center">아직 작성된 독서록이 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach items="${booksDTO.readBookList}" var="vo">
					<div class="row align-items-center read-list" data-toggle="modal" data-target="#a${vo.rb_seq}">
						<div class="col-md-3">${vo.rb_regidate}</div>
						<div class="col-md-8 div-subject">${vo.rb_subject}</div>
						<div class="col-md-1">${vo.rb_star}점</div>
					</div>
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
									<span class="text-info">작성일자 :</span> ${vo.rb_regidate}<br>
									<span class="text-info">독서일자 :</span> ${vo.rb_date}<br>
									<span class="text-info">독서점수 :</span> ${vo.rb_star}<br>
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
			</c:otherwise>
		</c:choose>
		
		<hr>
		
		<div class="d-flex justify-content-end">
			<button class="btn btn-primary btn-sm read-write">독서록 작성</button>
		</div>
	</div>
	
	<div class="bottom-margin-box">
	
	</div>
	
	
</body>
</html>