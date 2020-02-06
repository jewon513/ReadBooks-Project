<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<script>

	$(function(){
		
		$("#bookSearch").keydown(function(key){
		
			let search = $("#bookSearch").val()
			
			if(key.keyCode == 13){
				$.ajax({
			
					url : "${rootPath}/books/naverSearch",
					data : {search : search},
					type : "POST",
					success : function(result){
						$(".modal-body").html(result)
						
						$('[data-toggle="tooltip"]').tooltip({
								
							animated: 'fade',
							placement: 'bottom',
							html: true
								
						});
						
					},
					error : function(){
						alert("서버 통신 오류")
					}
				})
			}
			
		})
		
		
	})

</script>

<form:form modelAttribute="booksDTO" method="POST" action=""
	class="d-flex bg-light">
	<div class="form-border m-auto">
		<h2 class="text-center">도서 등록</h2>
		<c:choose>
			<c:when test="${Controller == 'update'}">
				<label>도서코드</label>
				<form:input path="b_code" type="text" class="form-control"
					readonly="true"></form:input>
			</c:when>
			<c:otherwise>
				<label>도서코드</label>
				<form:input path="b_code" type="text" class="form-control"></form:input>
			</c:otherwise>
		</c:choose>
		<label>도서명</label>
		<form:input path="b_name" type="text" class="form-control"></form:input>
		<label>저자</label>
		<form:input path="b_auther" type="text" class="form-control"></form:input>
		<label>출판사</label>
		<form:input path="b_comp" type="text" class="form-control"></form:input>
		<label>출판연도</label>
		<form:input path="b_year" type="date" class="form-control"></form:input>
		<label>가격</label>
		<form:input path="b_iprice" type="number" class="form-control"></form:input>
		<hr />
		<div class="d-flex">
			<c:if test="${Controller != 'update'}">
				<button type="button" class="btn btn-dark ml-auto" data-toggle="modal" data-target="#myModal">책 검색</button>
			</c:if>
			<button id="btn-enroll" type="button" class="btn btn-primary">등록</button>
		</div>
	</div>
</form:form>

<!-- The Modal -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<input id="bookSearch" class="form-control" placeholder="책 제목을 입력하세요.">
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>

