<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Class</title>
    <link rel="stylesheet" type="text/css" href="/css/mystyle.css">
</head>
<body>
    <h1>구매한 클래스 목록</h1>
    <c:forEach var="item" items="${purchasedClasses}">
        <img src="${item.lesson_thumbnail}" alt="Thumbnail" width="100" height="100">
        <p>제목: ${item.payment_title}</p>
        <p>구매 날짜: ${item.payment_date}</p>
        <button onclick="location.href='/chat?lesson=${item.payment_number}'">채팅 문의</button>
    </c:forEach>
</body>
</html>
