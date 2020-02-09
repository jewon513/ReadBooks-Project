<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/views/include/include-title.jsp"%>


<script type="text/javascript">
	$(function() {

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
		
		
		// 책 검색 AJAX 부분
		$("#bookSearch").keydown(function(key){
		
			let search = $("#bookSearch").val()
			
			if(key.keyCode == 13){
				$.ajax({
			
					url : "${rootPath}/books/naverSearch",
					data : {search : search},
					type : "POST",
					success : function(result){
						$(".modal-body").html(result)
						
					},
					error : function(){
						alert("서버 통신 오류")
					}
				})
			}
			
		})

	})
</script>
<body>

	<!-- nav -->
	<%@ include file="/WEB-INF/views/include/include-nav.jsp"%>

	<div class="container">
		<p>
		<h1>도서등록</h1>
		</p>
		<hr>
	</div>

	<!-- input body -->
	<div class="container">
		<form:form modelAttribute="booksDTO" method="POST">
			<c:choose>
				<c:when test="${Controller == 'update'}">
					<label>도서코드</label>
					<form:input path="b_code" type="text" class="form-control" readonly="true"></form:input>
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
			<div class="d-flex justify-content-end">
				<c:if test="${Controller != 'update'}">
					<button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">책 검색</button>
				</c:if>
				<button id="btn-enroll" type="button" class="btn btn-primary">등록</button>
			</div>
		</form:form>
	</div>

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

	<div class="bottom-margin-box">
	
	</div>


</body>
</html>