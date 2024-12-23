<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Racing+Sans+One&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap"
	rel="stylesheet">

<link href="/css/icons.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/header_login.css" rel="stylesheet">
<link href="/css/header_login.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/mainpage.css" rel="stylesheet">

<title>내 집 안의 작은 공방, 메킷</title>
</head>
<body>

	<!-- 헤더 부분 -->
	<!-- 세션값이 있으면 header_login 없으면 header를 불러온다. -->
	<c:choose>
		<c:when test="${not empty sessionScope.userSession}">
			<jsp:include page="${path}/WEB-INF/views/header_login.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>


	<!-- 여기에 내용넣기 -->
	<div
		style="margin: auto; max-width: 1280px; font-family: 'Pretendard', sans-serif;">


		<div
			style="display: flex; align-items: center; justify-content: space-between; margin-top: 50px;">
			<h2>베스트 클래스 TOP20</h2>
		</div>



		<div class="flex-container">

			<c:forEach var="lesson" items="${bestclass }" begin="0" end="19">
				<div class="flex-item">
					<a href="paymentdetail?lesson_number=${lesson.lesson_number}" class="class_link"  target="_blank">
						<div class="image-container">
							<img src="${path }/uimg/${lesson.lesson_thumbnail }"
								style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
						</div>
						<div class="text-container" style="font-size: 14px;">
							${lesson.lesson_title }</div>
						<div class="text-container"
							style="font-size: 14px; font-weight: 600;">
							${lesson.lesson_price }원</div>
						<div class="text-container" style="font-size: 12px;">
							<span style="color: gold; font-size: 16px; text-align: center;">★</span>&nbsp;${lesson.avg_reply_score }&nbsp;(${lesson.reply_count })
						</div>
					</a>
				</div>
			</c:forEach>




		</div>

	</div>

	<!-- 이용약관 footer -->
	<jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>

</body>
</html>