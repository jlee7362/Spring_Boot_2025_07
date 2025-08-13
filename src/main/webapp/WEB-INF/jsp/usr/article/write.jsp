<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="ARTICLE WRITE"></c:set>

<%@ include file="../common/head.jspf"%>

<h1 class="justify-self-center text-3xl my-6">Article Write</h1>
<div class="flex flex-col items-start w-fit mx-auto justify-self-center">

	<form action="doWrite" method="post">
		<table class="justify-self-center border-2 shadow-md">
			
			<tr>
				<th>Title</th>
				<th>
				<input class="px-8 border-2 text-xl" type="text" name="title" required="required"/>
				</th>
			</tr>
			<tr>
				<th>Body</th>
				<th>
				<input class="px-8 border-2 text-xl" type="text" name="body" required="required"/>
				</th>
			</tr>
		</table>
		<tr>
			<input class="px-8 border-2 text-gray-900" type="submit" value="글 작성" />
		</tr>
	</form>

	<div class="flex w-full justify-end">
		<nav class="flex space-x-2">
			<button type="button"
				class="mt-4 px-4 py-2 bg-gray-100 rounded 
           hover:bg-gray-300 shadow-md
           transform transition duration-150 hover:-translate-y-0.5 hover:shadow-lg"
				onclick="history.back()">뒤로가기</button>
		</nav>
	</div>

</div>
<%@ include file="../common/foot.jspf"%>