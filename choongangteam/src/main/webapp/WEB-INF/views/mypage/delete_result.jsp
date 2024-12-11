<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 결과</title>
</head>
<body>
<c:if test="${result == 1}">
    <script>
        alert("탈퇴 성공");
        location.href="loginpage";
    </script>
</c:if>
<c:if test="${result == 0}">
    <script>
        alert("비밀번호가 일치하지 않습니다.");
        history.go(-1);
    </script>
</c:if>
<c:if test="${result == -1}">
    <script>
        alert("회원 탈퇴 중 오류가 발생했습니다.");
        history.go(-1);
    </script>
</c:if>
</body>
</html>
