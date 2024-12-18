<%@ page language="java" contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 아임포트 설정 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/payment.css">
    <title>결제 페이지</title>
</head>
<body>
    <div class="payment-container">
    <!-- 상단 제목 -->
    <h1 class="page-title">클래스 결제</h1>

    <!-- 클래스 정보 섹션 -->
    <div class="section class-info">
        <h2>클래스 정보</h2>
        <div class="class-thumbnail">
            <img src="${path}/uimg/${lesson.lesson_thumbnail}"><br>
        </div>
         <span class="lesson-title">&lt;${lesson.lesson_title}&gt;</span>
    </div>

    <!-- 결제 수단 섹션 -->
    <div class="section discounts">
      <div class="payment-methods">
        <h2>결제 수단</h2>
        <label><input type="radio" name="agency" value="html5_inicis" checked> 신용카드</label>
        <label><input type="radio" name="agency" value="kakaopay"> 카카오페이
        <img src="<%= request.getContextPath()%>/img/contents/kakaopay_logo.png" class="payment-logo"></label>
       </div>
    </div>

    <!-- 결제 정보 및 수강 정보 섹션 -->
    <div class="section payment-summary">
    <h2>결제 정보</h2>
    <div class="summary-row">
        <p>레슨 금액</p>
        <span>${lesson.lesson_price}원</span>
    </div>
    
    <div class="summary-row">
        <p>강의 일정</p>
        <span>${lesson.start_date}&nbsp;${lesson.start_hour}:0${lesson.start_min}~${lesson.class_hour}:0${lesson.class_min}</span>
    </div>
    <div class="summary-row people">
        <p>수강 인원</p>
        <span>총 ${lesson.lesson_apply}인</span>
    </div>
    <div class="total-row">
        <p>최종 결제금액</p>
        <span>${lesson.lesson_price}원</span>
    </div>
</div>
    
    <!-- 결제하기 버튼 -->
    <div class="pay-button-container">
        <button type="button" class="pay-button" id="paybutton">결제하기</button>
    </div>
</div>
	
	<input type="hidden" id="payment_number" value="${lesson.lesson_number}">
	<input type="hidden" id="payment_price" value="${lesson.lesson_price}">
	<input type="hidden" id="payment_title" value="${lesson.lesson_title}">
	<input type="hidden" id="member_email" value="${member.member_email}">
	<input type="hidden" id="member_nickname" value="${member.member_nickname}">

<script>
    $(document).ready(function() {
        $("#paybutton").on("click", function() {
        	var payment_number = Math.floor(Math.random() * 100000);	 	// 주문번호
            var member_email = $("#member_email").val();					// 유저이메일
            var payment_title = $("#payment_title").val();	 	 			// 레슨이름
            var payment_price = $("#payment_price").val();  				// 레슨가격
            var payment_agency = $("input[name='agency']:checked").val();	// 결제대행사

            var IMP = window.IMP;
            IMP.init('imp23067864'); // 가맹점 식별코드 입력
			
            // 결제 요청
            IMP.request_pay({
                pg: payment_agency,           				// 등록된 pg사: kg이니시스(html5_inicis), 카카오페이(kakaopay)
                pay_method: "card",         				// 결제방식: card(신용카드)
                merchant_uid: payment_number, 				// 주문번호
                name: payment_title,           				// 상품명
                amount: payment_price,           			// 금액
                buyer_name: '${member.member_nickname}',	// 이름
                buyer_email: '${member.member_email}'		// 이메일
                
            }, function (rsp) {
            	console.log("결제 응답 객체:", rsp);
            	console.log("lesson_number:", '${lesson.lesson_number}');
            	console.log("member_email:", '${member.member_email}');
            	console.log("payment_nickname:", '${member.member_nickname}');
            	
                if (rsp.success) {         	
                	console.log("rsp.success:"+ rsp.success);
                	 
                	 // 결제 정보 저장
                   	$.ajax({
                        type: "POST",
                        url: "/save_payment", // 서버의 처리 URL
                        contentType: "application/json",
                        data: JSON.stringify({
                           "payment_number": rsp.merchant_uid,				// 주문번호
                           "payment_title": payment_title,					// 상품명
                           "payment_price": rsp.paid_amount,				// 결제금액
                           "payment_method": rsp.pay_method,				// 결제방식
                           "payment_agency": rsp.pg_provider,				// 결제대행사
                           "lesson_number": '${lesson.lesson_number}', 		// 레슨넘버
                           "member_email": '${member.member_email}',		// 이메일
                           "payment_nickname": '${member.member_nickname}',	// 닉네임
                           "payment_state": rsp.status === "paid" ? 1 : 0,	// 결제상태 (1: 성공, 0: 실패)
                           "payment_imp_uid": rsp.imp_uid

                        }),                       
                        success: function(result) {
							if(result == 1){
								console.log("결제 정보 저장 성공");
								// 결제 완료 메시지 표시
		            			Swal.fire({
		                          text: "결제가 완료되었습니다.",
		                          icon: 'success',                // 아이콘 (성공)
		                          confirmButtonText: '확인',
		                          confirmButtonColor: '#9832a8',  // 버튼 색상  
		            			}).then(() => {
		            			    window.location.href = "paymentcancel"	// 추후 마이페이지 or 마이페이지 결제내역으로 변경 예정
		            			});
							}
						},
                        error: function() {
                       	 	console.log("결제 정보 저장 실패");
                    	}
                    });
                   	
                } else {
                    Swal.fire({
                        text: "결제를 실패하였습니다.",
                        icon: 'error',
                        confirmButtonText: '확인',
                        confirmButtonColor: '#9832a8'
                    });
                }
            });
        });
    });

</script>

</body>
</html>
