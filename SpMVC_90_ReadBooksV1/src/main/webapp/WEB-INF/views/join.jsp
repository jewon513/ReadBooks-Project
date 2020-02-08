<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/include-title.jsp"%>
<head>
<meta charset="UTF-8">
<title>My homepage</title>

<style type="text/css">

.login-container {
	margin-top: 5%;
	margin-bottom: 5%;
}

.login-form-1 {
	padding: 5%;
	box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0
		rgba(0, 0, 0, 0.19);
	margin: 0 auto;
}

.login-form-1 h3 {
	text-align: center;
	color: #333;
	font-weight: bold;
}

.login-container form{
    padding: 10%;
}
.btnSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    border: none;
    cursor: pointer;
    outline: none;
}
.login-form-1 .btnSubmit{
    font-weight: 600;
    color: #fff;
    background-color: #0062cc;
}

.login-form-1 .ForgetPwd{
    color: #0062cc;
    font-weight: 600;
    text-decoration: none;
}

button:focus {
	outline: none;
}

</style>

<script type="text/javascript">

	$(function(){
		$("#join").click(function(){
			
			var getCheck= RegExp(/^[a-zA-Z0-9]{4,19}$/);
			var checkPW = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/

			var id = $("#m_id").val()
			var pw = $("#m_password").val()
			var re_pw = $("#re_password").val()
			
			if(!getCheck.test(id)){
				alert("아이디는 영문과 숫자로만 4자리 이상 19자리 이하로 입력해주세요.")
				$("#m_id").focus()
				return false
			}
			
			if(pw == ""){
				alert("비밀번호는 반드시 입력해야합니다.")
				$("#m_password").focus()
				return false
			}
			
			if(!checkPW.test(pw)){
				alert("비밀번호는 숫자, 영문자, 특수문자 조합으로 8자리 이상 사용해야 합니다.")
				return false
			}
			
			if(re_pw == ""){
				alert("한번 더 입력해주세요")
				$("#re_password").focus()
				return false
			}
			
			if(pw != re_pw){
				alert("비밀번호를 다시 입력해주세요.")
				$("#re_password").focus()
				return false
			}
			
			let data = $("#join-form").serialize()
			
			$.ajax({
				
				url : '${rootPath}/member/join',
				data : data,
				method : 'POST',
				success : function(result){
					if(result == "OK"){
						alert("회원가입 성공")
						document.location.href = "${rootPath}/"
					}else{
						alert("회원가입 실패")
						document.location.href = "${rootPath}/"
					}
				},
				error : function(){
					alert("중복된 아이디가 있거나 서버 통신 오류입니다.")
				}
				
			})
			
		})
	})	

</script>

</head>

<body>

	<!-- nav -->
	<%@ include file="/WEB-INF/views/include/include-nav.jsp"%>

	<div class="container login-container">
		<div class="row">
			<div class="col-md-6 login-form-1">
				<h3><a href="${rootPath}/">회원가입</a></h3>
				<form:form id="join-form" modelAttribute="memberDTO">
					<div class="form-group">
						<form:input path="m_id" type="text" class="form-control" placeholder="사용할 ID를 입력하세요"></form:input>
					</div>
					<div class="form-group">
						<form:input path="m_password" type="password" class="form-control" placeholder="비밀번호를 입력하세요"></form:input>
					</div>
					<div class="form-group">
						<input id="re_password" type="password" class="form-control" placeholder="한번 더 입력하세요.">
					</div>
					<div class="form-group d-flex">
						<button type="button" class="btnSubmit m-auto" id="join">회원가입</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>


</body>
</html>



