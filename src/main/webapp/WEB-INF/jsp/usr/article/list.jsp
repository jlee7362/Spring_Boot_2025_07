<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<c:set var="pageTitle" value="ARTICLE LIST"></c:set>
<%@ include file="../common/head.jspf"%>

	<h1>ARTICLE LIST</h1>

	<table border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
		<thead>
			<tr>
				<th>ID</th>
				<th>Registration Date</th>
				<th>Title</th>
				<th>Member ID</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="article" items="${articles }">
				<tr>
					<td>${article.id }</td>
					<td>${article.regDate }</td>
					<td>${article.title }</td>
					<td>${article.memberId }</td>
				</tr>

			</c:forEach>

		</tbody>
	</table>
<%@ include file="../common/foot.jspf"%>