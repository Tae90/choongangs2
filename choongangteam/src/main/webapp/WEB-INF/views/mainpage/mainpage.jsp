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
    <link href="/css/header_login.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/slidshow.css" rel="stylesheet">
    <link href="/css/mainpage.css" rel="stylesheet">
    <link href="/css/mainpage_slideshow.css" rel="stylesheet">
    <script src="/js/mainpage_slideshow.js"></script>
    
    <script src="http://code.jquery.com/jquery-latest.js"></script>    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
    

</script>
   
    
<title>Insert title here</title>
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

<c:if test="${not empty message}">
   <script type="text/javascript">
       $(document).ready(function() {
           Swal.fire({
               title: "알림",
               text: "${message}",  // 전달된 메시지
               icon: 'info',
               confirmButtonText: '확인',
               confirmButtonColor: '#9832A8'
           });
       });
   </script>
</c:if>
	
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
            <a href="bestclass" class="seeall">모두보기</a>
        </div>

        <div class="flex-container">

	<c:forEach var="lesson" items="${bestclass }" begin="0" end="7">
            <div class="flex-item">
                <a href="paymentdetail?lesson_number=${lesson.lesson_number}" class="class_link"  target="_blank">
                    <div class="image-container">
                        <img src="${path }/uimg/${lesson.lesson_thumbnail }" style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
                    </div>
                    <div class="text-container" style="font-size: 14px;">
                        ${lesson.lesson_title }
                    </div>
                    <div class="text-container" style="font-size: 14px; font-weight: 600;">
                        ${lesson.lesson_price }원
                    </div>
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