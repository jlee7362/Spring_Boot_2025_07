<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>

<script>
	function callAjax() {

		let form = document.form1;
		let action = form.action;
		let num1 = form.num1.value;
		let num2 = form.num2.value;

		$.get(action, {
			num1 : num1,
			num2 : num2

		}, function(data) {
			$('.rs').text(data);
		}, 'html');
	}
	function callAjax1() {

		let form = document.form1;
		let action = form.action;
		let num1 = form.num1.value;
		let num2 = form.num2.value;

		$.get(action, {
			num1 : num1,
			num2 : num2

		}, function(data) {
			data = data.split('/');
			let rs = data[0];
			let msg = data[1];
			let code = data[2];

			$('.rs1').text(rs);
			$('.rs-msg1').text(msg);
			$('.rs-code1').text(code);
		}, 'html');
	}
	function callAjax2() { // json

		let form = document.form1;
		let action = form.action;
		let num1 = form.num1.value;
		let num2 = form.num2.value;

		$.get("/usr/home/doPlusJson", {
			num1 : num1,
			num2 : num2

		}, function(data) {
			console.log(data);
			$('.rs2').text(data.rs);
			$('.rs-msg2').text(data.msg);
			$('.rs-code2').text(data.code);
		}, 'json');
	}
	function callAjax3() {

		let form = document.form1;
		let action = form.action;
		let num1 = form.num1.value;
		let num2 = form.num2.value;

		$.get({
			url : action,
			data : {
				num1 : num1,
				num2 : num2
			},
			success : function(data) {
				$('.rs3').text(data);
			},
			error : function(xhr, status, error) {
				alert('ajax 실패');
			}
		})
	}
</script>



<div>AJAX TEST</div>

<form action="/usr/home/doPlusJson" name="form1">
	<div>
		<input type="text" name="num1" placeholder="정수1 입력" />
		<input type="text" name="num2" placeholder="정수2 입력" />
	</div>
	<div>
		<input class="btn btn-outline btn-sm" value="더하기 실행" onclick="callAjax()" />
	</div>
	<div>
		<input class="btn btn-outline btn-sm" value="더하기 실행1" onclick="callAjax1()" />
	</div>
	<div>
		<input class="btn btn-outline btn-sm" value="더하기 실행2" onclick="callAjax2()" />
	</div>
	<div>
		<input class="btn btn-outline btn-sm" value="더하기 실행3" onclick="callAjax3()" />
	</div>
	<br />
	<br />
	<div>
		<span>더하기 결과 : </span>
		<span class="rs"></span>
	</div>
	<div>
		<span>더하기 결과1 : </span>
		<span class="rs1"></span>
		<span class="rs-msg1"></span>
		<span class="rs-code1"></span>
	</div>
	<div>
		<span>더하기 결과2 : </span>
		<span class="rs2"></span>
		<span class="rs-msg2"></span>
		<span class="rs-code2"></span>
	</div>
	<div>
		<span>더하기 결과3 : </span>
		<span class="rs3"></span>
		<span class="rs-msg3"></span>
		<span class="rs-code3"></span>
	</div>
</form>


<%@ include file="../common/foot.jspf"%>