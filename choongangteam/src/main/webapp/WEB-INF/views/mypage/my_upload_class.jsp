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

</style>

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



	<!-- 여기에 내용넣기 -->
    <div style="margin: auto; max-width: 1280px; font-family: 'Pretendard', sans-serif; min-height: 500px">

		<div class="mypage_container" >

               <div class="side_menu">
                <div class="myimg_name">
                    <img src="${path}${empty userSession.user_photo ? '/img/profile/Default.png' : '/uimg/'}${empty userSession.user_photo ? '' : userSession.user_photo}"
     alt="Profile Image"  style="border-radius: 50%; width: 56px; height: 56px;">
                    <div class="nick_email">
                        <span style="font-size: 24px;">${userSession.nickname }님</span>
                        <span style="font-size: 14px; color: #8c8c8c;">${userSession.email }</span>

                    </div>
                </div>

               <c:if test="${userSession.member_number == 1}">
    					<button class="write_lesson" onclick="location.href='classRegister'">클래스 등록</button>
			  </c:if>

                <div class="my_menu">
                    <a href="mypage" class="side_link">
                        <span>프로필</span>
                        <span class="material-symbols-outlined small-icon">chevron_right</span>
                    </a>

                    <c:if test="${userSession.member_number == 1}">
    						<a href="selllist" class="side_link">
        						<span>판매 내역</span>
        						<span class="material-symbols-outlined small-icon">chevron_right</span>
    					</a>
					</c:if>
					<c:if test="${userSession.member_number != 1}">
    						<a href="paymentcancel" class="side_link">
        						<span>결제 내역</span>
        							<span class="material-symbols-outlined small-icon">chevron_right</span>
   						 </a>
					</c:if>

                 
    <c:if test="${userSession.member_number == 1}">
        <a href="myregisteredclasses" class="side_link">
            <span>내가 등록한 클래스</span>
            <span class="material-symbols-outlined small-icon">chevron_right</span>
        </a>
    </c:if>

    <c:if test="${userSession.member_number != 1}">
        <a href="favoritelist" class="side_link">
            <span>찜</span>
            <span class="material-symbols-outlined small-icon">chevron_right</span>
        </a>

        <a href="reviews" class="side_link">
            <span>리뷰</span>
            <span class="material-symbols-outlined small-icon">chevron_right</span>
        </a>
    </c:if>


   </div>



            </div>

            <!-- 사이드 버튼 누르면 나오는 메뉴 이거는 나중에 따로 파일 만들어서 불러와야 할듯 -->
            <div class="mypage_content"   id="mypage-content">
              		<h2>내가 등록한 클래스</h2>
          
              		
              		 <div class="mylike_container">
                
                <c:forEach var="lesson" items="${myclass }" >
                <div class="mylike_class">
                    <a href="paymentdetail?lesson_number=${lesson.lesson_number}" class="class_link">
                        <div class="image-container">
                            <img src="${path }/uimg/${lesson.lesson_thumbnail }"style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
                        </div>
                        <div class="text-container" style="font-size: 14px;">
                            ${lesson.lesson_title }<br><br>

                            <div class="text-container" style="font-size: 14px; font-weight: 600;">
                                ${lesson.lesson_price }원
                            </div>
                        </div>             
                    </a>
                </div>
				</c:forEach>
 
            </div>
            
            		<c:if test="${empty myclass}">
							<p align="center" style="font-size: 20px; margin-top: 100px;">
							<span style="font-weight: 600;  color: #4C4C4C">내가 등록한 클래스가 없습니다.</span>
			
							</p>
				</c:if>
            	

            </div>

        </div>
	</div>
	

	
	
		 <!-- 이용약관 footer -->
    <jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>
	
</body>
</html>