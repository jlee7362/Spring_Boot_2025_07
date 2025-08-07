<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>

<%@ include file="../common/head.jspf"%>

<h1>ARTICLE DETAIL</h1>
<section class="mt-8 text-xl px-4">
	<table class="mx-auto" cellpadding="5">
		<tbody>
				<tr>
					<th>ID</th>
					<td>${article.id }</td>
				</tr>
				<tr>
					<th>Registration Date</th>
					<td>${article.regDate }</td>
				</tr>
				<tr>
					<th>Title</th>
					<td>${article.title }</td>
				</tr>
				<tr>
					<th>Writer</th>
					<td>${article.extra__writer}</td>
				</tr>

		</tbody>
	</table>
	<div class="btns">
	<button type="button" onClick="history.back()">뒤로가기</button>
	<a href="modify?id=${article.id }">수정</a>
	<a href="delete?id=${article.id }">삭제</a>
	</div>
	
</section>
<%@ include file="../common/foot.jspf"%>