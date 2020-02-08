<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<script>
	$(function() {

		$("#member-logout").click(function() {

			if (confirm("로그아웃 하시겠습니까?")) {
				$.ajax({

					url : '${rootPath}/member/logout',
					type : 'POST',
					success : function(result) {
						alert("정상적으로 로그아웃 되었습니다.")
						document.location.href = '${rootPath}/'
					},
					error : function() {
						alert("서버통신 에러")
					}

				})
			}

		})

	})
</script>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-up">
	<div class="container">
		<a class="navbar-brand" href="${rootPath}/">ReadBook Project</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="${rootPath}/">도서리스트</a></li>
				<li class="nav-item"><a class="nav-link" href="${rootPath}/books/write">도서등록</a></li>
				<c:if test="${MEMBER == null }">
					<li class="nav-item"><a class="nav-link" href="${rootPath}/member/login">로그인</a></li>
				</c:if>
				<c:if test="${MEMBER != null}">
					<li class="nav-item"><a class="nav-link" id="member-logout" href="#">${MEMBER.m_id} 님 안녕하세요</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>