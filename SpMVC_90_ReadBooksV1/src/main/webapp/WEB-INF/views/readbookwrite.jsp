<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/views/include/include-title.jsp"%>

</head>

<script type="text/javascript">

	$(function(){
		
		let checkReadWrite = function() {

			let rb_date = $("#rb_date").val()

			if (rb_date == "") {
				alert("독서일자는 반드시 입력해야합니다.")
				$("#rb_date").focus()
				return false;
			}

			let rb_subject = $("#rb_subject").val()

			if (rb_subject.length > 20) {
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

		}

		$(".write-btn").click(checkReadWrite)
		
		$("input").keypress(function(key){
			
			if(key.keyCode == 13){
				checkReadWrite
			}
			
		})
		
		
	})
	
	
</script>

<style>
.write-btn {
	margin-right: 15px;
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
		<hr>
	</div>

	<!-- ReadBoooks Write Body -->
	<div class="container">
		<form:form class="row" modelAttribute="readBookDTO">
			<form:input path="rb_bcode" type="hidden" />
			<form:input path="rb_regidate" type="hidden" />
			<div class="col-sm-4">
				<div class="form-group">
					<label>점수</label>
					<form:input path="rb_star" type="range" class="form-control-range" min="1" max="10" step="1"></form:input>
				</div>
				<div class="form-group">
					<label>독서일자</label>
					<form:input path="rb_date" type="date" class="form-control"></form:input>
				</div>
			</div>
			<div class="col-sm-8">
				<div class="form-group">
					<label>제목</label>
					<form:input path="rb_subject" class="form-control" placeholder="한줄소감"></form:input>
				</div>
				<div class="form-group">
					<label>본문</label>
					<form:textarea path="rb_text" class="form-control" placeholder="한줄소감" rows="10"></form:textarea>
				</div>
			</div>
			<hr>
			<button class="btn btn-primary btn-sm ml-auto write-btn">등록</button>
		</form:form>
	</div>
	
	<div class="bottom-margin-box">
	
	</div>	



</body>
</html>