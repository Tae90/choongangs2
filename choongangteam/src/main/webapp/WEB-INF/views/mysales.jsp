<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Sales</title>
    <!-- CSS 파일 불러오기 -->
    <link rel="stylesheet" type="text/css" href="/css/mystyle.css">
</head>
<body>
    <h1>판매한 클래스 목록</h1>
    <c:forEach var="item" items="${soldClasses}">
        <img src="${item.lesson_thumbnail}" alt="Thumbnail" width="100" height="100">
        <p>제목: ${item.lesson_title}</p>
        <p>판매 날짜: ${item.payment_date}</p>
        <p>구매자 닉네임: ${item.payment_nickname}</p>
        <p>구매자 이메일: ${item.buyer_email}</p>
        <button onclick="location.href='/chat?lesson=${item.payment_number}'">채팅 연결</button>
    </c:forEach>
</body>
</html>
