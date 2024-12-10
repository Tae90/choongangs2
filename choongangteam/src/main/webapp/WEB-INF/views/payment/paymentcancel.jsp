<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
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
    <link href="" rel="stylesheet">
    <link href="/css/icons.css" rel="stylesheet">
    <link href="/css/font.css" rel="stylesheet">
    <link href="/css/header.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>결제 내역</title>
</head>
<body>
	
	<!-- 헤더 부분 -->
	<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
    
    <table align="center">
        <thead>
        	<tr><th><h1>결제 내역</h1></th></tr>
            <tr>
                <th>주문 번호</th>
                <th>닉네임</th>
                <th>상품명</th>
                <th>결제 금액</th>
                <th>결제 날짜</th>
                <th>결제 방법</th>
                <th>결제 상태</th>
                <th>취소</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="payment" items="${paymentList}">
                <tr>
                    <td>${payment.payment_number}</td>
                    <td>${payment.payment_nickname}</td>
                    <td>${payment.payment_title}</td>
                    <td>${payment.payment_price}원</td>
                    <td>${payment.payment_date}</td>
                    <td>${payment.payment_method}</td>
                    <td>
                        <c:choose>
                            <c:when test="${payment.payment_state == 1}">결제 완료</c:when>
                            <c:otherwise>결제 취소</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${payment.payment_state == 1}">
                            <button class="cancelbutton" data-payment="${payment.payment_number}">취소</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

<script>
    $(document).ready(function () {
        $(".cancelbutton").click(function () {
            var payment_number = $(this).data("payment");

            Swal.fire({
                title: "결제를 취소하시겠습니까?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#9832a8",
                cancelButtonColor: "#d33",
                confirmButtonText: "네, 취소합니다.",
                cancelButtonText: "아니오",
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: "/save_payment/cancel",
                        contentType: "application/json",
                        data: JSON.stringify({
                            payment_number: payment_number,
                        }),
                        success: function () {
                            Swal.fire("취소 완료", "결제가 취소되었습니다.", "success").then(() => {
                                location.reload();
                            });
                        },
                        error: function () {
                            Swal.fire("오류", "결제 취소에 실패했습니다.", "error");
                        },
                    });
                }
            });
        });
    });
</script>
</body>
</html>
