<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="/css/icons.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/header_login.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/mypage.css" rel="stylesheet">

<style>
.new-nickname {
	width: 100%;
	max-width: 200px;
	height: 20px;
}

.new-nickname {
	border-radius: 4px;
	border: 1px solid rgb(229, 231, 235);
	background-color: #F6F6F6;
}

.new-nickname:focus-within {
	border-color: #9832a8;
	border-style: solid;
	border-width: 2px;
}

.new-nickname:focus {
	outline: none;
}
/* 텍스트 스타일 */
.text-container .title {
	font-size: 16px; /* 제목 크기 */
	font-weight: bold;
	margin-bottom: 6px;
	color: #333;
	line-height: 1.4;
}

.text-container .time {
	font-size: 14px; /* 보라색 강조 글씨 크기 */
	font-weight: bold;
	color: #9832a8;
	transition: color 0.3s ease;
}

/* 채팅 버튼 */
.btn-chat {
	padding: 4px 8px; /* 버튼 크기 */
	background-color: transparent;
	border: none;
	font-size: 13px; /* 버튼 글씨 크기 */
	font-weight: bold;
	color: #555;
	cursor: pointer;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.btn-chat:hover {
	background-color: #f1f1f1;
	color: #333;
}

/* 전체 폰트 조화 */
body {
	font-size: 14px; /* 기본 글씨 크기 */
	font-family: 'Pretendard', sans-serif;
}
</style>

<title>My Class</title>
</head>
<body>

	<!-- 헤더 부분 -->
	<c:choose>
		<c:when test="${not empty sessionScope.userSession}">
			<jsp:include page="${path}/WEB-INF/views/header_login.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>

	<div style="margin: auto; max-width: 1280px;">
		<div class="mypage_container">
			<div class="side_menu">
				<div class="myimg_name">
					<img
						src="${path}${empty userSession.user_photo ? '/img/profile/Default.png' : '/uimg/'}${empty userSession.user_photo ? '' : userSession.user_photo}"
						alt="Profile Image"
						style="border-radius: 50%; width: 56px; height: 56px;">
					<div class="nick_email">
						<span style="font-size: 24px;">${sessionScope.userSession.nickname}님</span>
						<span style="font-size: 14px; color: #8c8c8c;">${userSession.email }</span>

					</div>
				</div>
			</div>
			<div class="mypage_content" id="mypage-content">
				<h2 style="font-size: 20px; font-weight: bold;">마이 클래스</h2>
				<div class="mylike_container">
					<c:forEach var="item" items="${purchasedClasses}">
						<div class="mylike_class">
							<!-- 썸네일에 링크 추가 -->
							<a href="paymentdetail?lesson_number=${item.lesson_number}"
								class="class_link"
								style="display: inline-block; width: 25%; float: left;">
								<div class="image-container">
									<img src="${path}/uimg/${item.lesson_thumbnail}"
										alt="Class Thumbnail" style="width: 100%; height: auto;">
								</div>
							</a>
							<!-- 텍스트 -->
							<div class="text-container"
								style="float: left; width: 65%; padding-left: 10px;">
								<div class="title">${item.payment_title}</div>
								<div class="time">클래스일정: ${item.start_time}</div>
							</div>
							<!-- 채팅 버튼 -->
							<div style="float: right; width: 10%; text-align: right;">
								<!-- 채팅 버튼 -->
								<button class="btn-chat"
									onclick="location.href='/chat?payment_number=${item.payment_number}'">채팅문의</button>
								<!-- 간격 추가 -->
								<div style="margin-top: 10px;"></div>
								<!-- 클래스 이동 버튼 -->
								<button class="btn-chat"
									onclick="location.href='https://webrtcpj.o-r.kr/webrtc/main.html?mode=0'">클래스룸
								</button>
							</div>

							<div style="clear: both;"></div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>
