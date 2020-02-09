<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
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
		
		function checklogin(){
			
			$(".prohibition-box").css("display","block");
			let loginData = $("#login-form").serialize()
			
			
			$.ajax({
				
				url : '${rootPath}/member/login',
				method : 'POST',
				data : loginData,
				success : function(result){
					if(result == "OK"){
						alert("로그인 성공")
						document.location.href = '${rootPath}/'
					}else if(result == "FALSE"){
						alert("로그인 실패")
						$(".prohibition-box").css("display","none");
					}
				},
				error : function(){
					alert("서버통신 오류")
					$(".prohibition-box").css("display","none");
				}
				
			})
			
		}
		
		$("#login").click(checklogin)
		
		$("input").keypress(function(key){
			
			if(key.keyCode == 13){
				checklogin()
			}
			
		})
		
		$("#join").click(function(){
			
			document.location.href = "${rootPath}/member/join"
			
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
				<h3><a href="${rootPath}/">로그인</a></h3>
				<form id="login-form">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Your ID" name="m_id"/>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="Your Password" name="m_password" />
					</div>
					<div class="form-group d-flex">
						<button type="button" class="btnSubmit m-auto" id="login">로그인</button>
					</div>
					<div class="form-group d-flex">
						<button type="button" class="btnSubmit m-auto" id="join">회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>


</body>

<style>
	.prohibition-box{
		display:none;
		position:fixed;
		top:0px;
		left:0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.3);
	}

</style>

<div class="prohibition-box">
	
</div>

</html>



