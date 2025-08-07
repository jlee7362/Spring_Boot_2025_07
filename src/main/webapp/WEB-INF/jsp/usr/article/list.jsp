<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article List</title>
</head>
<body>

	<h1>Article LIST</h1>

	<c:forEach var="article" items="${articles }">
		<div>${article.id }</div>
		<div>${article.title }</div>
		<div>${article.body }</div>
	</c:forEach>

	<div>123</div>


</body>
</html>