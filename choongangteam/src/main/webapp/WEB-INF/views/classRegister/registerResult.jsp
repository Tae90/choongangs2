<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 등록 확인</title>
</head>
<body>
	<c:if test="${result==1}">
		<script>
			alert("클래스 등록에 성공했습니다");
			location.href="";
		</script>
	</c:if>
	<c:if test="${result!=1}">
		<script>
			alert("등록 실패");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>