<%@ page language="java" contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
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
            <img src="img/flower.jpeg" alt="클래스 썸네일">
            <p>나만의 디퓨저 만들기 <br> <h4>&lt;감정오일 디퓨저와 꽃 디퓨저&gt;</h4></p>
        </div>
    </div>

    <!-- 결제 수단 섹션 -->
    <div class="section discounts">
      <div class="payment-methods">
        <h2>결제 수단</h2>
        <label><input type="radio" name="payment" value="카드" checked> 카드/간편결제</label>
        <label><input type="radio" name="payment" value="카카오페이"> 카카오페이
        <img src="img/kakaopay_logo.png" alt="카카오페이 로고" class="payment-logo"></label>
       </div>
    </div>

    <!-- 결제 정보 및 수강 정보 섹션 -->
    <div class="section payment-summary">
    <h2>결제 정보</h2>
    <div class="summary-row">
        <p>레슨 금액</p>
        <span>10,000원</span>
    </div>
    <div class="summary-row">
        <p>강의 일정</p>
        <span>2024-12-03 16:00~18:00</span>
    </div>
    <div class="summary-row people">
        <p>수강 인원</p>
        <span>3명</span>
    </div>
    <div class="total-row">
        <p>최종 결제금액</p>
        <span>10,000원</span>
    </div>
</div>
    
    <!-- 결제하기 버튼 -->
    <div class="pay-button-container">
        <button type="button" class="pay-button" id="ordbutton">결제하기</button>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#ordbutton").on("click", function() {
        	var payment_number = $("#payment_number").val(); 	 		// 주문번호
            var member_email = $("#member_email").val();				// 유저이메일
            var payment_title = $("#payment_title").val();	 	 		// 레슨이름
            var state = $("#state").val();   				 	 		// 결제상태 : 결제 완료(0), 결제 취소(1)
            var agency = $("#agency").val();					 		// 결제대행사
            var price = parseInt($("#price").val().replace(/,/g, ""));  // 레슨가격
            var payment_nickname = $("#payment_nickname").val(); 		// 유저닉네임

            var IMP = window.IMP;
            IMP.init('imp23067864'); // 가맹점 식별코드 입력
			
            // 결제 요청
            IMP.request_pay({
                pg: agency,           				// 등록된 pg사: kg이니시스(html5_inicis), 카카오페이(kakaopay)
                pay_method: "card",         		// 결제방식: card(신용카드)
                merchant_uid: payment_number, 		// 주문번호
                name: payment_title,           		// 상품명
                amount: price,           			// 금액
                buyer_name: payment_nickname,     	// 주문자 닉네임(이름)
                buyer_email: member_email			// 주문자 이메일
                
            }, function (rsp) {
                if (rsp.success) {         	
                	 // 결제 완료 메시지 표시
           			Swal.fire({
                         text: "결제가 완료되었습니다.",
                         icon: 'success',                // 아이콘 (성공)
                         confirmButtonText: '확인',
                         confirmButtonColor: '#9832a8',  // 버튼 색상  
           			}).then(() => {
           			    window.location.href = "orderdone?merchant_uid=" + rsp.merchant_uid;
           			});
                   	                	
                    // 결제 정보 저장 (서버에 결제 정보 전달)
                    $.ajax({
                        type: "post",
                        url: "save_payment", // 서버의 처리 URL
                        contentType: "application/json",
                        data: JSON.stringify({
                           payment_number: rsp.merchant_uid,
                           payment_title: payment_title,
                           payment_price: rsp.paid_amount,
                           payment_method: rsp.pay_method,
                           payment_agency: agency,
                           payment_state: 0,	// 결제 완료 상태
                           payment_nickname: rsp.buyer_name,
                           member_email: rsp.buyer_email
                        }),
                        success: function(response) {
                            console.log("결제 정보 저장 성공");
                        },
                        error: function(error) {
                       	 	console.log("결제 정보 저장 실패", error);
                    	}
                    });
                } else {
                    Swal.fire({
                        text: "결제를 실패하였습니다.",
                        icon: 'error',
                        confirmButtonText: '확인',
                        confirmButtonColor: '#9832a8',
                    });
                }
            });
        });
    });
</script>

</body>
</html>
