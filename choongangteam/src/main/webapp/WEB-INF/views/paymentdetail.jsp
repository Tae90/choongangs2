<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/paymentdetail.css">
<title>상세 페이지</title>
</head>
<body>
  <div class="container">
    <!-- 왼쪽 섹션 -->
    <div class="left-section">
      <div class="header">
        <img src="<%= request.getContextPath() %>/img/class1.png" alt="클래스 이미지">
      </div>
      <div class="review-section">
        <h2>베스트 리뷰</h2>
        <div class="review">
          <p>모두가 너무 좋아하는 체험이었습니다. 다음에 또 가고 싶습니다.</p>
        </div>
      </div>
    </div>
    
    <!-- 오른쪽 섹션 -->
    <div class="right-section">
      <div class="details">
        <h1>나만의 향수 MAKE IT!</h1>
        <div class="price-info">
        <p class="price">40,000원</p>
        </div>
        
        <div class="summary-info">
          <div class="summary-item">
            <img src="<%= request.getContextPath()%>/img/people.png">
            <p>모집 인원 2-5인</p>
          </div>
          <div class="summary-item">
            <img src="<%= request.getContextPath()%>/img/clock.png" alt="시간">
            <p>원데이 2시간</p>
          </div>
        </div>
        
        <!-- 강의 일정 -->
        <div class="class-info">
        	<h4>일정 선택</h4>
        </div>
        
        <!-- 협의 가능 버튼 -->
      <div class="agreement-section" id="agreementSection">
          <input type="radio" name="agreement" id="agreementRadio" value="yes"> 협의가능</div>
        
        <!-- 아이콘 섹션 -->
      <div class="icon-container">
        <img src="<%= request.getContextPath()%>/img/heart.png" class="icon" id="heartIcon">
        <img src="<%= request.getContextPath()%>/img/contact.png" class="icon" id="messageIcon">
        <!-- 결제하기 버튼 -->
          <button type="submit" class="pay-button">결제하기</button>
      </div>
                   
      </div>
    </div>
  </div>
</body>
</html>