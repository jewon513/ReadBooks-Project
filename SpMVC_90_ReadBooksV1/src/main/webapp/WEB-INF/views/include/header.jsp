<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	
	$(function(){
		
		$("#member-logout").click(function(){
		
			if(confirm("로그아웃 하시겠습니까?")){
				$.ajax({
					
					url : '${rootPath}/member/logout',
					type : 'POST',
					success : function(result){
						alert("정상적으로 로그아웃 되었습니다.")
						document.location.href = '${rootPath}/'
					},
					error : function(){
						alert("서버통신 에러")
					}
					
				})
			}
			
		})
		
		
	})
	
	
</script>


<header class="jumbotron bg-dark text-light">
	<h1>
		<a href="${rootPath}/">독서록 관리</a>
	</h1>
</header>

<nav class="navbar navbar-expand-sm bg-dark text-light">
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link" href="${rootPath}/books/write">도서등록</a></li>
		<li class="nav-item"><a class="nav-link" href="${rootPath}/">도서리스트</a></li>
		<c:if test="${MEMBER == null }">
			<li class="nav-item"><a class="nav-link" href="${rootPath}/member/login">로그인</a></li>
		</c:if>
		<c:if test="${MEMBER != null}">
			<li class="nav-item"><a class="nav-link" id="member-logout">${MEMBER.m_id} 님 안녕하세요</a></li>
		</c:if>
	</ul>
	<ul class="navbar-nav ml-auto">
		<form class="form-inline" action="${rootPath}/books/search" method="get">
	    	<input class="form-control mr-sm-2" type="text" placeholder="Search" name="b_name">
 	 	</form>
	</ul>
</nav>