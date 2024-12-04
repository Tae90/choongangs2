<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    <link href="/css/slidshow.css" rel="stylesheet">
    <link href="/css/mainpage.css" rel="stylesheet">
    <link href="/css/mainpage_slideshow.css" rel="stylesheet">
    <script src="/js/mainpage_slideshow.js"></script>
<title>Insert title here</title>
</head>
<body>

	<!-- 헤더 부분 -->
	<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
	
	
	 <!-- 여기에 내용넣기 -->
    <div style="margin: auto; max-width: 1280px; font-family: 'Pretendard', sans-serif;">

        <!-- Slideshow container -->
        <div class="slideshow-container">

            <!-- Full-width images with number and caption text -->
            <div class="mySlides fade" style="display: block;">
                <div class="numbertext">1 / 3</div>

                <a href="asd">
                    <img src="/img/contents/Default.png" style="width:100%; height: 400px;">
                </a>

            </div>

            <div class="mySlides fade">
                <div class="numbertext">2 / 3</div>
                <img src="/img/contents/Default.png" style="width:100%;  height: 400px;">

            </div>

            <div class="mySlides fade">
                <div class="numbertext">3 / 3</div>
                <img src="/img/contents/Default.png" style="width:100%;  height: 400px;">

            </div>

            <!-- Next and previous buttons -->
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
        <br>

        <!-- The dots/circles -->
        <div style="text-align:center">
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(3)"></span>
        </div>


        <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 100px;">
            <h2>베스트 클래스 TOP20</h2>
            <a href="asd" class="seeall">모두보기</a>
        </div>

        <div class="flex-container">


            <div class="flex-item">
                <a href="asd" class="class_link">
                    <div class="image-container">
                        <img src="art.jpg" style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
                    </div>
                    <div class="text-container" style="font-size: 14px;">
                        [아트테라피] 색과 만다라의 콜라보
                    </div>
                    <div class="text-container" style="font-size: 14px; font-weight: 600;">
                        25000원
                    </div>
                    <div class="text-container" style="font-size: 12px;">
                        <span style="color: gold; font-size: 16px; text-align: center;">★</span>&nbsp;5&nbsp;(24)
                    </div>
                </a>
            </div>

            <div class="flex-item">
                <a href="asd" class="class_link">
                    <div class="image-container">
                        <img src="art.jpg" style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
                    </div>
                    <div class="text-container" style="font-size: 14px;">
                        [아트테라피] 색과 만다라의 콜라보
                    </div>
                    <div class="text-container" style="font-size: 14px; font-weight: 600;">
                        25000원
                    </div>
                    <div class="text-container" style="font-size: 12px;">
                        <span style="color: gold; font-size: 16px; text-align: center;">★</span>&nbsp;5&nbsp;(24)
                    </div>
                </a>
            </div>

            <div class="flex-item">
                <a href="asd" class="class_link">
                    <div class="image-container">
                        <img src="art.jpg" style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
                    </div>
                    <div class="text-container" style="font-size: 14px;">
                        [아트테라피] 색과 만다라의 콜라보
                    </div>
                    <div class="text-container" style="font-size: 14px; font-weight: 600;">
                        25000원
                    </div>
                    <div class="text-container" style="font-size: 12px;">
                        <span style="color: gold; font-size: 16px; text-align: center;">★</span>&nbsp;5&nbsp;(24)
                    </div>
                </a>
            </div>


        </div>

    </div>
	
</body>
</html>