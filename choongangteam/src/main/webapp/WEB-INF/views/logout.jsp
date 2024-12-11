<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout Page</title>
</head>
<body>
    <c:if test="${result == 1}">
        <script>
           
            location.href="mainpage";
        </script>
    </c:if>
    <c:if test="${result != 1}">
        <script>
            alert("로그아웃 실패");
            history.go(-1); // 로그아웃 실패 시 이전 페이지로 이동
        </script>
    </c:if>
</body>
</html>
