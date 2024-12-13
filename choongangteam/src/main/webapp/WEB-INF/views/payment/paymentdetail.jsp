<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Racing+Sans+One&display=swap"rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="/css/header.css" rel="stylesheet">
<link href="/css/header_login.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/icons.css" rel="stylesheet">
<link href="/css/paymentdetail.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>상세 페이지</title>
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
  
  	<div class="payment-container">
  		<div class="payment-content">
    		<!-- 왼쪽 섹션 -->
    		<div class="payment-left-section">
      			<div class="header">
        			<img class="img" src="<%= request.getContextPath() %>/uimg/class.png">
      			</div>
      			<div class="content">
      			</div>
      			<div class="review-section">
    				<h2>베스트 리뷰</h2>
    				<div class="review">
        				<img src="<%= request.getContextPath()%>/uimg/flower.jpeg">
        				<div class="review-name">파크종찬</div>
        				<div class="star-score">★★★★★</div>
        				<div class="review-text">모두가 너무 좋아하는 체험이었습니다. <br>다음에 또 가고 싶습니다.</div>
    				</div>
				</div>
    		</div>
    		<!-- 오른쪽 섹션 -->
    		<div class="payment-right-section">
      			<div class="details">
        			<h1>${lesson.lesson_title}</h1>
        		
        			<!-- 찜 및 리뷰 카운트 -->
        			<div class="favorite-count">
        				<img src="<%= request.getContextPath() %>/uimg/heart_pink.png" class="icon-small">
        				<span>${lesson.favorite_count}</span>
        				<img src="<%= request.getContextPath() %>/uimg/star.png" class="icon-small">
        				<span>${lesson.reply_count}</span>
        			</div>
        			<div class="price-info">
        				<span class="price">${lesson.lesson_price}원</span>
        			</div>
        			<div class="summary-info">
         				<div class="summary-item">
            				<img src="<%= request.getContextPath()%>/uimg/people.png">
            				<span>모집인원 ${lesson.lesson_apply}인</span>
          				</div>
          				<div class="summary-item">
            				<img src="<%= request.getContextPath()%>/uimg/clock.png" alt="시간">
            				<span>소요시간 ${lesson.class_hour}시간</span>
          				</div>
        			</div>
        			<!-- 강의 일정 -->
        			<div class="class-info">
        				<h4>일정 선택</h4>
        			</div>
        			<!-- 일정 선택 버튼 -->
      				<div class="agreement-section" id="agreementSection">
          				<input type="radio" value="agree"> ${lesson.start_date} ${lesson.start_hour}:${lesson.start_min}
      				</div>
        			<!-- 아이콘 섹션 -->
      				<div class="icon-container">
      					<div class="icons">
        					<img src="<%= request.getContextPath()%>/uimg/heart.png" class="icon heart_icon"
        						data-favorite="false" data-lesson_number="${lesson.lesson_number}">
        					<a href="asd"><img src="<%= request.getContextPath()%>/uimg/contact.png" class="icon" id="messageIcon"></a>
        				</div>
        				<!-- 결제하기 버튼 -->
          				<a href="<%= request.getContextPath()%>/paymentform?lesson_number=${lesson.lesson_number}"
          				class="pay-button">결제하기</a>
      				</div>   
    			</div>
    		</div>
		</div>
	</div>
	<div class="payment_bottom">
		<!-- 아이콘 섹션 -->
      	<div class="icon-container">
       		<img src="<%= request.getContextPath()%>/uimg/heart.png" class="icon heart_icon"
       			data-favorite="false" data-lesson_number="${lesson.lesson_number}">
       		<a href="asd"><img src="<%= request.getContextPath()%>/uimg/contact.png" class="icon" id="messageIcon"></a>
        	
        	<!-- 결제하기 버튼 -->
        	<a href="<%= request.getContextPath()%>/paymentform?lesson_number=${lesson.lesson_number}"
        		class="pay-button">결제하기</a>
      	</div>  
	</div>

<script>
  $(document).ready(function() {
	
    // 일정 버튼 클릭 시 테두리 색상 변경
    $('#agreementSection input').on('change', function() {
      $('#agreementSection').css('border', '1px solid #9832a8');
    });
    
    // 결제하기 버튼 클릭 이벤트
    $('.pay-button').on('click',function(){
    	const $this = $(this);
    
   		$.ajax({
   			url : '/check-login',
   			method : 'POST',
   			success : function(Login){
   				if(Login){
   					location.href = $this.attr('href');
   				}else{
   					alert("회원가입 및 로그인 후 이용 가능합니다.");
   					location.href = "/loginpage";
   				}
   			},
   			error: function(){
   				alert("로그인 상태 확인 중 오류 발생");
   			}
   		});
    
  });
    
    const updateHeartIcon = function(){
    $('.heart_icon').each(function(){
    	const $this = $(this);
    	const lesson_number = $this.data('lesson_number');
    	
    // 페이지 로드 시 찜 상태 확인
    $.ajax({
        url: '/favorite/check',
        method: 'POST',
        data: {lesson_number: lesson_number},
        success: function (isFavorite) {
            $this
             .attr('data-favorite', isFavorite)
             .attr('src', isFavorite
            	? '<%= request.getContextPath() %>/uimg/heart_pink.png'
                : '<%= request.getContextPath() %>/uimg/heart.png');
        },
        error: function () {
            console.error('찜 상태 확인 중 오류 발생');
        }
    });
   });
 };
 
 	// 초기 하트 상태 업데이트
  	updateHeartIcon();
    
	//찜 버튼 클릭 이벤트
    $(document).on('click', '.heart_icon', function() {
    	console.log('찜 버튼 클릭됨');
    	const $this = $(this);
    	const favorite = $this.attr('data-favorite') === "true";
    	const lesson_number = $this.data('lesson_number');
    	console.log('lesson_number:', lesson_number);
    	
    	$.ajax({
    		url : favorite ? '/favorite/remove' : '/favorite/add',
    		method : 'POST',
    		data : {lesson_number: lesson_number},
    		contentType: 'application/x-www-form-urlencoded',
    		success : function(response){
    			if(response) {
    				const newFavorite = !favorite;
    				$this
    				 .attr('data-favorite', newFavorite)
    		         .attr('src', newFavorite
    		        	? '<%= request.getContextPath() %>/uimg/heart_pink.png'
    					: '<%= request.getContextPath() %>/uimg/heart.png');
    			} else{
    				alert("회원가입 및 로그인 후 이용 가능합니다.");
    				location.href="/loginpage";
    			}						
    		},
    		error: function(){
    			alert("찜 처리 중 오류 발생");
    		}
    	});
    });
	
	// 창 크기 변경 시 하트 아이콘 상태 갱신
 	$(window).on('resize',function(){
 		updateHeartIcon();
	});
	
 });
	
</script>

</body>
</html>