<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form modelAttribute="readBookDTO" method="POST" action="" class="d-flex bg-light">
	<div class="form-border m-auto">
		<h2 class="text-center">독서록</h2>
		<form:input path="rb_bcode" type="hidden" value="${booksDTO.b_code}" />
		<label>독서일자</label>
		<form:input path="rb_date" type="date" value="${readBookDTO.rb_date}" class="form-control"></form:input>
		<label>독서시작시각</label>
		<form:input path="rb_stime" type="time" value="${readBookDTO.rb_stime}" class="form-control"></form:input>
		<label>독서시간</label>
		<form:input path="rb_rtime" type="number" class="form-control"></form:input>
		<label>점수</label>
		<form:input path="rb_star" type="number" min="1" max="5" class="form-control"></form:input>
		<label>한줄소감</label>
		<form:input path="rb_subject" type="text" class="form-control"></form:input>
		<label>긴줄소감</label>
		<form:textarea path="rb_text" type="text" class="form-control" rows="10"></form:textarea>
		<hr />
		<div class="d-flex">
			<button id="btn-enroll" class="btn btn-primary ml-auto">등록</button>
		</div>
	</div>
</form:form>