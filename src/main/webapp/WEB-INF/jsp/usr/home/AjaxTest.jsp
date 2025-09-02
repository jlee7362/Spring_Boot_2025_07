<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>

<script>
function callAjax(){
	
	let form = document.form1;
	let action = form.action;
	let num1 = form.num1.value;
	let num2 = form.num2.value;
	
	$.get(action,{
		num1 : num1,
		num2 : num2
	},function(data){
		$('.rs').text(data);
	},'html');
}
</script>


<div>AJAX TEST</div>

<form action="/usr/home/doPlus" name="form1">
<div>
	<input type="text" name="num1" placeholder="정수1 입력"/>
	<input type="text" name="num2" placeholder="정수2 입력"/>
</div>

<div>
	<input class="btn btn-outline" value="더하기 실행" onclick='callAjax()'/>
</div>

	<h2>더하기 결과 : </h2>

<span class="rs"></span>

</form>


<%@ include file="../common/foot.jspf"%>