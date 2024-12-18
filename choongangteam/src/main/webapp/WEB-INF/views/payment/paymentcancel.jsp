<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<link href="/css/header_login.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/icons.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/paymentcancel.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>결제 내역</title>
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
	
	<div class="main-content">
    <div class="payment-container">
        <!-- 구매자 결제 내역 -->
        <c:if test="${mode == 'buyer'}">
        <h1 class="page-title">${nickname}님의 구매내역</h1>

        <div class="section">
            <h2>구매 상세 정보</h2>
            <table>
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>강의명</th>
                        <th>결제금액</th>
                        <th>결제날짜</th>
                        <th>결제방법</th>
                        <th>결제상태</th>
                        <th>결제취소</th>
                    </tr>
                </thead>
                <tbody>
                	<c:choose>
                	<c:when test="${not empty buyer_paymentList}">
                    <c:forEach var="payment" items="${buyer_paymentList}">
                        <tr class="${payment.payment_state == 0 ? 'cancelled-row' : ''}">
                            <td>${payment.payment_number}</td>
                    <td><a href="paymentdetail?lesson_number=${payment.lesson_number}" style="text-decoration:none">${payment.payment_title}</a></td>
                            <td>${payment.payment_price}원</td>
                            <td><fmt:formatDate value="${payment.payment_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${payment.payment_method}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${payment.payment_state == 1}">결제완료</c:when>
                                    <c:otherwise>취소완료</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${payment.payment_state == 1}">
                                    <button class="cancelbutton" data-payment="${payment.payment_number}"
                                    data-imp_uid="${payment.payment_imp_uid}">취소</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                   </c:when>
                   <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center;">결제 내역이 없습니다.</td>
                            </tr>
                       </c:otherwise>
                   </c:choose>
                </tbody>
            </table>
        </div>
       </c:if>
       
    <!-- 판매자 내역 -->
    <c:if test="${mode == 'seller'}">
	 <h1 class="page-title">${nickname}님의 판매내역</h1>
	 	<div class="section">
            <h2>판매 상세 정보</h2>
            <table>
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>구매자</th>
                        <th>강의명</th>
                        <th>결제금액</th>
                        <th>결제날짜</th>
                        <th>판매상태</th>
                    </tr>
                </thead>
                <tbody>
                	<c:choose>
                		<c:when test="${not empty seller_paymentList}">
                    <c:forEach var="payment" items="${seller_paymentList}">
                        <tr class="${payment.payment_state == 0 ? 'cancelled-row' : ''}">
                            <td>${payment.payment_number}</td>
                            <td>${payment.payment_nickname}</td>
                            <td><a href="paymentdetail?lesson_number=${payment.lesson_number}" style="text-decoration:none">${payment.payment_title}</a></td>
                            <td>${payment.payment_price}원</td>
                            <td><fmt:formatDate value="${payment.payment_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${payment.payment_state == 1 ? "신청완료" : "신청취소"}</td>
                        </tr>
                    </c:forEach>
                    </c:when>
                    <c:otherwise>
                            <tr>
                                <td colspan="6" style="text-align: center;">판매 내역이 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
	</c:if>
 </div>
</div>
    <script>
        $(document).ready(function () {
            $(".cancelbutton").click(function () {
                var payment_number = $(this).data("payment");
                var payment_imp_uid = $(this).data("imp_uid");
				
                console.log("취소 요청 - payment_number:", payment_number);
                console.log("취소 요청 - imp_uid:", payment_imp_uid);
                
                Swal.fire({
                    title: "결제를 취소하시겠습니까?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#9832a8",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "결제취소",
                    cancelButtonText: "아니오",
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: "/save_payment/cancel",
                            contentType: "application/json",
                            data: JSON.stringify({
                                "payment_number": payment_number,
                                "payment_imp_uid": payment_imp_uid
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
<jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>
