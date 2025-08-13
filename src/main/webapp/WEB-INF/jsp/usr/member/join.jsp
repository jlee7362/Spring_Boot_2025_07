<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>

<%@ include file="../common/head.jspf"%>

<section class="justify-self-center border-2 shadow-md border-gray-700">
	<div>
		<form action="doJoin" method="post">
			<table class="table">
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
						<th>이름</th>
						<td>
							<input name="name" type="text" autocomplete="off" placeholder="이름 입력"/>
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input name="nickname" type="text" autocomplete="off" placeholder="닉네임 입력"/>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input name="cellphoneNum" type="text" autocomplete="on" placeholder="전화번호 입력"/>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input name="email" type="text" autocomplete="on" placeholder="이메일 입력"/>
						</td>
					</tr>
					<tr>
						<td>
							<button class="btn btn-neutral btn-outline" type="submit">회원가입</button>
							<button class="btn btn-neutral">Neutral</button>
<button class="btn btn-primary">Primary</button>
<button class="btn btn-secondary">Secondary</button>
<button class="btn btn-accent">Accent</button>
<button class="btn btn-info">Info</button>
<button class="btn btn-success">Success</button>
<button class="btn btn-warning">Warning</button>
<button class="btn btn-error">Error</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<button type="button" onclick="history.back()">뒤로가기</button>

</section>



<%@ include file="../common/foot.jspf"%>