<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="MEMBER LOGIN"></c:set>

<%@ include file="../common/head.jspf"%>

<section class="justify-self-center border-2 shadow-md border-gray-700">
	<div>
		<form  class="border-gray-800"action="doLogin" method="post">
			<table>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input name="loginId" type="text" autocomplete="off" placeholder="아이디 입력"/>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input name="loginPw" type="text" autocomplete="off" placeholder="비밀번호 입력"/>
						</td>
					</tr>
					<tr>
						<td>
							<button type="submit">로그인</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<button type="button" onclick="history.back()">뒤로가기</button>

</section>



<%@ include file="../common/foot.jspf"%>