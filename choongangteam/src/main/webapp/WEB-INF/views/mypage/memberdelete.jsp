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
    <div style="margin: auto; max-width: 1280px; font-family: 'Pretendard', sans-serif;">

		<div class="mypage_container" >

            <div class="side_menu">
                <div class="myimg_name">
                    <img src="${path}${empty userSession.user_photo ? '/img/profile/Default.png' : '/uimg/'}${empty userSession.user_photo ? '' : userSession.user_photo}"
     alt="Profile Image"  style="border-radius: 50%; width: 56px; height: 56px;">
                    <div class="nick_email">
                        <span>${userSession.nickname }</span>
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
    						<a href="paymentcancel" class="side_link">
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
              		<h2>회원 탈퇴하기</h2>

           			<div class="warning">
                		<p>※회원 탈퇴시 유의사항※</p>
                		<p style="font-size: 14px;">지금 탈퇴하시면 수강 예정이거나 현재 수강 중인 수업을 더 이상 이용하실 수 없게 돼요!</p>
                		<p style="font-size: 14px;">탈퇴 후에는 작성하신 리뷰를 수정 혹은 삭제하실 수 없어요. 탈퇴 신청 전에 꼭 확인해 주세요!</p>
          			</div>


           			<form method="post" action="delete_member_ok">
           			<div class="delete_me">
                		<div class="delete_text">
                    		<span style="font-weight: 600;">이메일(로그인 ID)</span>
                    		<span>${userSession.email }</span>
                    		<span></span>
                		</div>

                		<div class="delete_text">
                    		<span style="font-weight: 600;">비밀번호</span>
                    		<input type="password" class="delete_passwd" name="member_password">
               			 </div>

                		<div style="display: flex; flex-direction: column; gap: 20px; align-items: center; justify-content: center; margin: auto;">
                    		<span style="display: flex; align-items: center; justify-content: center; font-size: 14px;"><input type="checkbox">상기의 회원 탈퇴 유의사항을 확인하였으며, 탈퇴 신청에 동의합니다.</span>
                    		<div><button class="delete_ok" type="submit">탈퇴 신청하기</button></div>
               			</div>


           		</div>
        		</form>

            </div>

        </div>
	</div>
	
<script>
    document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.querySelector('.delete_passwd');
    const checkbox = document.querySelector('input[type="checkbox"]');
    const submitButton = document.querySelector('.delete_ok');

    // 초기 버튼 비활성화
    submitButton.disabled = true;
    submitButton.style.opacity = '0.5';
    submitButton.style.cursor = 'not-allowed';

    // 입력값 변경 감지
    function checkFormValidity() {
        if (passwordInput.value.trim() !== '' && checkbox.checked) {
            submitButton.disabled = false;
            submitButton.style.opacity = '1';
            submitButton.style.cursor = 'pointer';
        } else {
            submitButton.disabled = true;
            submitButton.style.opacity = '0.5';
            submitButton.style.cursor = 'not-allowed';
        }
    }

    // 이벤트 리스너 등록
    passwordInput.addEventListener('input', checkFormValidity);
    checkbox.addEventListener('change', checkFormValidity);
});

</script>
	
	
		 <!-- 이용약관 footer -->
    <jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>
	
</body>
</html>