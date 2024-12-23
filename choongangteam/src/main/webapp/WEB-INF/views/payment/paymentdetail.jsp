<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/paymentdetail.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>상세 페이지</title>
<script>
	//controller에서 가져온 값들 적용
	var content = '${lesson.lesson_content}';
	var title = "${lesson.lesson_title}";
	var date ="${lesson.start_date}";
	var start_hour ="${lesson.start_hour}";
	var start_min ="${lesson.start_min}";
	var class_hour ="${lesson.class_hour}";
	var class_min ="${lesson.class_min}";
	var price = ${lesson.lesson_price};
	var apply = ${lesson.lesson_apply};
	var applyCount = ${applyCount};
	var thumbnail ="${lesson.lesson_thumbnail}";
	var lesson_number="${lesson_number}";
	
	if(start_min==='0') start_min='00';
	if(class_min==='0') class_min='00';
	
	$(document).ready(function(){
		$('#price').html("<p>"+price+'원'+"</p>");
		if(applyCount) {
			$('#apply').append('<p>모집 인원 마감</p>');
		}else{
			$('#apply').append('<p>클래스 '+apply+'인</p>');
		}
		$('#content').html(content);
		$('#thumbnail').prop('src', '/uimg/'+thumbnail);
		$("#class_title").html("<h2>"+title+"</h2>");
		$("#payment_title").prepend("<h2>"+title+"</h2>");
		$('#agreementSection').append(date+" "+start_hour+":"+start_min+"~"+class_hour+":"+class_min)
		if(Number(start_min) === Number(class_min)){
			$('#classTime').append('원데이 '+(Number(class_hour)-Number(start_hour))+"시간");
		}else{
			if(Number(start_min)===30) $('#classTime').append('원데이 '+(Number(class_hour)-Number(start_hour)-1)+"시간 30분");
			else $('#classTime').append('원데이 '+(Number(class_hour)-Number(start_hour))+"시간 30분");
		}
				
	});
	
	function confirmDelete() {
        const result = window.confirm("정말로 삭제를 진행하시겠습니다?");
        
        if (result) {
        	$.ajax({
                url: '/deleteClass', // 서버의 URL
                type: 'post', // DELETE 요청
                data: {
                    lesson_number: lesson_number // 삭제할 클래스의 ID 예시 (동적으로 설정 가능)
					},
                success: function(response) {
                    if (response==1) {
                        alert("삭제가 완료되었습니다.");
                        location.href = '/mainpage'; // 리다이렉트
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert("서버와의 통신에 실패했습니다.");
                }
            });
        } 
    }
	
	$(function() {
		var lesson_number="${lesson.lesson_number}";

		$('#reply_insertSection').load('/reply?lesson_number='+lesson_number);  			
		$('#reply_listSection').load('/reply_list?lesson_number='+lesson_number);
	});
	
	

</script>
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
    			<c:if test="${not empty sessionScope.userSession}">
				<c:if test="${userSession.email == lesson.member_email}">
				<div class="modifyAndDelete_768">
					<a href="<%= request.getContextPath()%>/classModify?lesson_number=${lesson.lesson_number}" class="ModifyDelete">수정하기</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" class="ModifyDelete" onclick="confirmDelete()">삭제하기</a>
				</div>
				</c:if>
				</c:if>  
      			<div class="header">
        			<img class="img" id="thumbnail" src="">
      			</div>
      			<div class="class_title" id ="class_title">
      			</div>
      			<div class="content" id="content">
      			</div>
      			<div class="review-section">
    				<div id="reply_insertSection"></div>
      				<div id="reply_listSection"></div>
				</div> 
    		</div>
    		<!-- 오른쪽 섹션 -->
    		<div class="payment-right-section">
      			<div class="details" id ="payment_title">
        			<!-- 찜 및 리뷰 카운트 -->
        			<div class="favorite-count">
        				<img src="<%= request.getContextPath() %>/img/contents/heart_pink.png" class="icon-small">
        				<span id="favoriteCount_${lesson.lesson_number}">${lesson.favorite_count}</span>
        				<img src="<%= request.getContextPath() %>/img/contents/star.png" class="icon-small">
        				<span>(${avgReplyScore})${lesson.reply_count}</span>
        			</div>
        			
        			<!-- 가격 및 모집 상태 -->
        			<div class="price-info" id="price">
        			</div>
        			<div class="summary-info">
         				<div class="summary-item" id="apply">
            				<img src="<%= request.getContextPath()%>/img/contents/people.png">
          				</div>
          				<div class="summary-item" id="classTime">
            				<img src="<%= request.getContextPath()%>/img/contents/clock.png">
          				</div>
        			</div>
        			<!-- 강의 일정 -->
        			<div class="class-info">
        				<h4>일정 선택</h4>
        			</div>
        
        			<!-- 일정 선택 버튼 -->
      				<div class="agreement-section" id="agreementSection">
          				<input type="radio" value="agree" id="scheduleButton"> 
      				</div>
        			<!-- 아이콘 섹션 -->
      				<div class="icon-container">
      					<div class="icons">
        					<img src="<%= request.getContextPath()%>/img/contents/heart.png" class="icon heart_icon"
        						data-favorite="false" data-lesson_number="${lesson.lesson_number}">
        				</div>
        				<!-- 결제하기 버튼 -->
        				<c:choose>
        					<c:when test="${applyCount}">
        						<!-- 모집 인원이 마감된 경우 -->
        						 <button type="button" class="pay-button" disabled>결제하기</button>
        					</c:when>
        					<c:when test="${classCheck}">
        						<!-- 본인이 등록한 클래스인 경우 -->
        		 				<button type="button" class="pay-button" data-message="본인이 등록한 클래스는 결제 불가합니다.">결제하기</button>
        					</c:when>
        					<c:when test="${paidCheck}">
        						<!-- 중복 결제인 경우 -->
        						<button type="button" class="pay-button" data-message="중복 결제 불가합니다.">결제하기</button>
        					</c:when>
        					<c:otherwise>
        						<a href="<%= request.getContextPath()%>/paymentform?lesson_number=${lesson.lesson_number}" class="pay-button">결제하기</a>
        					</c:otherwise>
        				</c:choose>  
      				</div>
      				<c:if test="${not empty sessionScope.userSession}">
					<c:if test="${userSession.email == lesson.member_email}">
					<div class="modifyAndDelete">
						<a href="<%= request.getContextPath()%>/classModify?lesson_number=${lesson.lesson_number}" class="ModifyDelete">수정하기</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="ModifyDelete" onclick="confirmDelete()">삭제하기</a>
					</div>
					</c:if>
					</c:if>   
    			</div>
    		</div>
		</div>
	</div>
	<div class="payment_bottom">
		<!-- 아이콘 섹션 -->
      	<div class="icon-container">
       		<img src="<%= request.getContextPath()%>/img/contents/heart.png" class="icon heart_icon"
       			data-favorite="false" data-lesson_number="${lesson.lesson_number}">
        	
        	<!-- 결제하기 버튼 -->
        	<c:choose>
        	<c:when test="${applyCount}">
        		<!-- 모집 인원이 마감된 경우 -->
        		<button type="button" class="pay-button" disabled>결제하기</button>
        	</c:when>
        	<c:when test="${classCheck}">
        		<!-- 본인이 등록한 클래스인 경우 -->
        		 <button type="button" class="pay-button" data-message="본인이 등록한 클래스는 결제 불가합니다.">결제하기</button>
        	</c:when>
        	<c:when test="${paidCheck}">
        		<!-- 중복 결제인 경우 -->
        		 <button type="button" class="pay-button" data-message="중복 결제 불가합니다.">결제하기</button>
        	</c:when>
        	 <c:otherwise>
        	<a href="<%= request.getContextPath()%>/paymentform?lesson_number=${lesson.lesson_number}" class="pay-button">결제하기</a>
        		</c:otherwise>
        	</c:choose>
      	</div>  
	</div>	

<script>
  $(document).ready(function() {
	 
	// 일정 버튼 체크 초기화
	 $('#scheduleButton').prop('checked', false);
	 $('#agreementSection').css('border', '');
	  
    // 일정 버튼 클릭 시 테두리 색상 변경
    $('#agreementSection input').on('change', function() {
      $('#agreementSection').css('border', '1px solid #9832a8');
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
            	? '<%= request.getContextPath() %>/img/contents/heart_pink.png'
                : '<%= request.getContextPath() %>/img/contents/heart.png');
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
                     ? '<%= request.getContextPath() %>/img/contents/heart_pink.png'
                   	 : '<%= request.getContextPath() %>/img/contents/heart.png');
                
                // 찜 횟수 갱신
                $.ajax({
                    url: '/favorite/count',
                    method: 'POST',
                    data: {lesson_number: lesson_number},
                    success: function(count) {
                        $('#favoriteCount_' + lesson_number).text(count);
                    },
                });
                
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
 	// 결제하기 버튼 클릭 이벤트
    $('.pay-button').on('click',function(e){
    	e.preventDefault();
       const $this = $(this);
       const message = $this.data('message');
    	
    	// 일정 선택 여부 확인
       if(!$('#scheduleButton').is(':checked')) {
           alert("일정을 선택해주세요.");
          return;
       }
      
       if(message){
    	   alert(message);
    	   return;
       }
       
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
	
	// 창 크기 변경 시 하트 아이콘 상태 갱신
 	$(window).on('resize',function(){
 		updateHeartIcon();
	});
	
  });
</script>
<jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>