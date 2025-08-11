<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="ARTICLE LIST"></c:set>

	<%@ include file="../common/head.jspf" %>
	
	<h1 class="justify-self-center text-3xl my-6">Article List</h1>
	<div>
		<table class="justify-self-center border-2 shadow-md rounded-t-3xl ">
			<tr>
				<th class="px-8 py-5 border-2 border-gray-700">ID</th>
				<th class="px-8 py-5 border-2 border-gray-700">Registration Date</th>
				<th class="px-8 py-5 border-2 border-gray-700">Title</th>
				<th class="px-8 py-5 border-2 border-gray-700">작성자</th>
			</tr>
			<c:forEach var="article" items="${articles }">
				<tr>
					<th class="p-10 border-2 border-gray-700 text-xl">${article.id }</th>
					<th class="p-10 border-2 border-gray-700 text-xl">${article.regDate }</th>
					<th class="p-10 hover:underline border-2 border-gray-700 text-xl"><a href="../article/detail?id=${article.id }">${article.title }</a></th>
					<th class="p-10 border-2 border-gray-700 text-xl">${article.extra__writer }</th>
				</tr>

			</c:forEach>
		</table>
	</div>
	<%@ include file="../common/foot.jspf" %>