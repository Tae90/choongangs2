<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
     	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Racing+Sans+One&display=swap"
        rel="stylesheet">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/icons.css" rel="stylesheet">
<link href="/css/paymentdetail.css" rel="stylesheet">
<title>상세 페이지</title>
<script>
  $(document).ready(function() {
    // 일정 버튼 클릭 시 테두리 색상 변경
    $('#agreementSection input').on('change', function() {
      $('#agreementSection').css('border', '1px solid #9832a8');
    });

    // 하트 아이콘 클릭 시 핑크 하트로 변경
    $('#heartIcon').on('click', function() {
      $(this).attr('src', '<%= request.getContextPath() %>/uimg/heart_pink.png');
    });

  });
</script>

</head>
<body>

	<!-- 헤더 부분 -->
      <jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include> 
  
  <div class="payment-container">

    <!-- 왼쪽 섹션 -->
    <div class="payment-left-section">
      <div class="header">
        <img src="<%= request.getContextPath() %>/uimg/class.png">
      </div>
      
    </div>
    
    <!-- 오른쪽 섹션 -->
    <div class="payment-right-section">
      <div class="details">
        <h1>나만의 향수 MAKE IT!</h1>
        <div class="price-info">
        <p class="price">40,000원</p>
        </div>
        
        <div class="summary-info">
          <div class="summary-item">
            <img src="<%= request.getContextPath()%>/uimg/people.png">
            <p>모집 인원 6인</p>
          </div>
          <div class="summary-item">
            <img src="<%= request.getContextPath()%>/uimg/clock.png" alt="시간">
            <p>원데이 2시간</p>
          </div>
        </div>
        
        <!-- 강의 일정 -->
        <div class="class-info">
        	<h4>일정 선택</h4>
        </div>
        
        <!-- 일정 선택 버튼 -->
      <div class="agreement-section" id="agreementSection">
          <input type="radio" value="agree"> 2024-12-06 16:00~18:00</div>
        
        <!-- 아이콘 섹션 -->
      <div class="icon-container">
      
        <img src="<%= request.getContextPath()%>/uimg/heart.png" class="icon" id="heartIcon">
        
        <a href="asd"><img src="<%= request.getContextPath()%>/uimg/contact.png" class="icon" id="messageIcon"></a>
        <!-- 결제하기 버튼 -->
          <a href="<%= request.getContextPath()%>/paymentform?lesson_number=${lesson_number}" class="pay-button">결제하기</a>
      </div>
                   
      </div>
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
</body>
</html>