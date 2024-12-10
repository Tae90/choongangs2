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
    <div style="margin: auto; max-width: 1280px; font-family: 'Pretendard', sans-serif;">

		<div class="mypage_container" style="height: 960px;">

            <div class="side_menu">
                <div class="myimg_name">
                    <img src="${path}/img/profile/${userSession.user_photo}" style="border-radius: 50%; width: 56px; height: 56px;">
                    <div class="nick_email">
                        <span>${userSession.nickname }</span>
                        <span style="font-size: 14px; color: #8c8c8c;">${userSession.email }</span>

                    </div>
                </div>

                <!--  <button class="write_lesson" onclick="location.href='asd'">클래스 등록</button> -->

                <div class="my_menu">
                    <a href="mypage" class="side_link">
                        <span>프로필</span>
                        <span class="material-symbols-outlined small-icon">chevron_right</span>
                    </a>

                    <a href="payment" class="side_link"  >
                        <span>결제 내역</span>
                        <span class="material-symbols-outlined small-icon">chevron_right</span>
                    </a>

                    <a href="favoritelist" class="side_link"  >
                        <span>찜</span>
                        <span class="material-symbols-outlined small-icon">chevron_right</span>
                    </a>

                    <a href="reviews" class="side_link" >
                        <span>리뷰</span>
                        <span class="material-symbols-outlined small-icon">chevron_right</span>
                    </a>
                </div>

            </div>

            <!-- 사이드 버튼 누르면 나오는 메뉴 이거는 나중에 따로 파일 만들어서 불러와야 할듯 -->
            <div class="mypage_content"   id="mypage-content">
                <h2>내 프로필</h2>

                <div class="my_profile">
                    <span>닉네임(별명)</span>
                    <span id="nickname">
                        <span id="current-nickname">${userSession.nickname }</span>
                        <form id="edit-nickname-form"  action="nickname_update"  method="post"  style="display: none;">
                            <input type="text" class="new-nickname" id="member-nickname" name="member_nickname" maxlength="12" value="${userSession.nickname }"><br><br>
                            <button type="submit">저장</button>
                            <button type="button" id="cancel-edit">취소</button>
                        </form>
                        <button class="nickname_edit" id="edit-nickname-btn">
                            <span class="material-symbols-outlined"
                                style="font-size: 18px; color: #8c8c8c;">edit_square</span>
                        </button>
                    </span>

                    <span></span>
                </div>

                <script>

                document.addEventListener('DOMContentLoaded', function () {
                    const editBtn = document.getElementById('edit-nickname-btn');
                    const nicknameSpan = document.getElementById('current-nickname');
                    const editForm = document.getElementById('edit-nickname-form');
                    const newNicknameInput = document.getElementById('member-nickname');
                    const cancelBtn = document.getElementById('cancel-edit');

                    editBtn.addEventListener('click', function () {
                        nicknameSpan.style.display = 'none';
                        editBtn.style.display = 'none';
                        editForm.style.display = 'inline';
                        newNicknameInput.focus();
                    });

                    cancelBtn.addEventListener('click', function () {
                        nicknameSpan.style.display = 'inline';
                        editBtn.style.display = 'inline';
                        editForm.style.display = 'none';
                        newNicknameInput.value = nicknameSpan.textContent;
                    });

                    editForm.addEventListener('submit', function (e) {
                        // 폼 제출은 그대로 진행되도록 e.preventDefault()를 제거했습니다.
                        // 백엔드에서 처리 후 페이지가 새로고침되거나 리다이렉트될 것입니다.
                    });
                });

                </script>

               <div class="my_profile">
                    <span>프로필 이미지</span>
                     <form action="profileimg_update"  method="post">
                    <span style="position: relative;">
                   
                        <div class="profile_img">
                            <img id="currentProfileImg"  name="member_photo"  src="https://cdn.pixabay.com/photo/2021/07/02/04/48/user-6380868_1280.png"
                                style="border-radius: 50%; width: 56px; height: 56px;">
                        </div>
                        <input type="file" id="imageUpload" accept="image/*" style="display: none;"
                            onchange="loadFile(this)">
                        <button type="button" class="profileimg_edit" onclick="document.getElementById('imageUpload').click();">
                            <span class="material-symbols-outlined" style="font-size: 18px; color: white; display: flex;
            justify-content: center; align-items: center;">photo_camera</span>
                        </button>
                        
                    </span>
                    
                        <div id="imageActionButtons" style="display: none; margin-top: 10px;">
                            <button type="submit" onclick="saveImage()">저장</button>
                            <button onclick="cancelImage()">취소</button>
                        </div>
                       </form>
                       <span>
                    </span>
                </div>
                
                
                <script>
                    let originalImageSrc = '';

                    function loadFile(input) {
                        let file = input.files[0];

                        if (file) {
                            let reader = new FileReader();
                            reader.onload = function (e) {
                                let newImage = document.getElementById('currentProfileImg');
                                originalImageSrc = newImage.src;  // 원래 이미지 저장
                                newImage.src = e.target.result;
                                document.getElementById('imageActionButtons').style.display = 'block';
                            }
                            reader.readAsDataURL(file);
                        }
                    }

                    function saveImage() {
                   
                        document.getElementById('imageActionButtons').style.display = 'none';
                    }

                    function cancelImage() {
                        let currentImage = document.getElementById('currentProfileImg');
                        currentImage.src = originalImageSrc;  // 원래 이미지로 복원
                        document.getElementById('imageActionButtons').style.display = 'none';
                    }
                </script>

                <div class="my_profile">
                    <span>이메일(로그인 ID)</span>
                    <span>${userSession.email }</span>
                    <span></span>
                </div>




                <div class="my_profile" style="float: right; font-size: 12px; padding-right: 20px;">
                    <a href="logout1" class="logout">로그아웃</a>&nbsp;&nbsp;
                    <a href="asd" class="logout">회원탈퇴</a>
                </div>

            </div>

        </div>
	</div>
	

	
	
		 <!-- 이용약관 footer -->
    <jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>
	
</body>
</html>