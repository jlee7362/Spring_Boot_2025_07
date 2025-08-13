<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="ARTICLE MODIFY"></c:set>

<%@ include file="../common/head.jspf"%>

<h1 class="justify-self-center text-3xl my-6">Article Modify</h1>
<div class="flex flex-col items-start w-fit mx-auto justify-self-center">
	<form action="doModify" method="post">
		<table class="justify-self-center border-2 shadow-md">
			<tr>
				<th>
					<input class="px-8 border-2 text-xl" type="hidden" name="id" value="${article.id }" />
				</th>
			</tr>
			<tr>
				<th class="px-8 border-2 text-gray-900">Registration Date</th>
				<th class="px-8 border-2 text-xl">${article.regDate }</th>
			</tr>
			<tr>
				<th class="px-8 border-2 text-gray-900">Update Date</th>
				<th class="px-8 border-2 text-xl">${article.updateDate }</th>
			</tr>
			<tr>
				<th class="px-8 border-2 text-gray-900">Title</th>
				<th>
					<input class="input input-primary input-sm" type="text" placeholder="Primary" name="title" value="${article.title }" />
				</th>
			</tr>
			<tr>
				<th class="px-8 py-5 border-2 text-gray-900">Body</th>
				<th>
					<input class="px-8 border-2 text-xl" type="text" placeholder="새 내용" name="body" value="${article.body }" />
				</th>
			</tr>
			<tr>
				<th class="px-8 border-2 text-gray-900">작성자</th>
				<th class="px-8 border-2 text-xl">${article.extra__writer }</th>
			</tr>
		</table>
			<tr>
				<input class="btn btn-soft btn-primary" type="submit" value="수정"/>
			</tr>
		</form>
		
		<div class="flex w-full justify-end">
			<nav class="flex space-x-2">
				<button type="button"
					class="mt-4 px-4 py-2 bg-gray-100 rounded 
           hover:bg-gray-300 shadow-md
           transform transition duration-150 hover:-translate-y-0.5 hover:shadow-lg"
					onclick="history.back()">뒤로가기</button>

				
				<c:if test="${article.userCanDelete}">
					<a
						class="mt-4 px-4 py-2 bg-gray-100 rounded 
           hover:bg-gray-300 shadow-md
           transform transition duration-150 hover:-translate-y-0.5 hover:shadow-lg"
						href="doDelete?id=${article.id }">삭제</a>
				</c:if>
			</nav>
		</div>
	
</div>
<%@ include file="../common/foot.jspf"%>