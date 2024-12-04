<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Racing+Sans+One&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">

    <link href="/css/icons.css" rel="stylesheet">
    <link href="/css/font.css" rel="stylesheet">
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/categorypage.css" rel="stylesheet">
    
<title>Insert title here</title>
</head>
<body>

	<!-- 헤더 부분 -->
	<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
	
	 <div style="margin: auto; max-width: 1280px;">
	 
	 	 <div class="second_cate">
	 	 
	 	 <c:forEach var="subcategory" items="${subcate}">
        <a href="category_page?Maincategory_number=${subcategory.maincategory_number}&Subcategory_number=${subcategory.subcategory_number}"
           class="${subcategory.subcategory_number == selectedSubcategory ? 'selected' : ''}">
            <span>${subcategory.subcategory_name}</span>
        </a>
    </c:forEach>
            
        </div>


        <div class="review">
            <a href="asd">추천순</a>&nbsp;
            <a href="asd">리뷰순</a>&nbsp;
            <a href="asd">최신순</a>
        </div><br>
	 	
	 </div>

</body>
</html>