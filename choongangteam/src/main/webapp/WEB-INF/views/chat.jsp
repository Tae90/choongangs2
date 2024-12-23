<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Spring WebSocket Chat</title>
<link rel="stylesheet" href="/css/chat.css">
</head>
<body>
	<div id="chat-page">
		<!-- 전체 컨테이너 -->
		<div class="chat-container">
			<!-- 왼쪽 채팅방 목록 -->
			<div class="chat-room-list">
				<ul>
					<c:forEach var="chatRoom" items="${chatRooms}">
						<li class="chat-room" data-room-id="${chatRoom.roomId}"><img
							src="${path}${empty chatRoom.otherPhoto ? '/img/profile/Default.png' : '/uimg/'}${empty chatRoom.otherPhoto ? '' : chatRoom.otherPhoto}"
							alt="Profile">
							<div class="chat-room-info">
								<div class="chat-room-header">
									<span class="chat-room-nickname">${chatRoom.otherNickname}</span>
									<span class="chat-room-time"> <fmt:formatDate
											value="${chatRoom.lastMessageTime}" pattern="yy.MM.dd HH:mm" />
									</span>
									<c:if test="${unreadCounts[chatRoom.roomId] > 0}">
										<span class="unread-count">${unreadCounts[chatRoom.roomId]}</span>
									</c:if>
								</div>
								<span class="chat-room-last-message">${chatRoom.lastMessage}</span>
							</div>
							</li>

					</c:forEach>
				</ul>
			</div>

			<!-- 오른쪽 채팅 메시지 -->
			<div class="chat-messages">
				<c:choose>
					<c:when test="${not empty chatLogs}">
						<ul id="messageArea">
							<c:forEach var="chatLog" items="${chatLogs}">
								<c:if
									test="${chatLog.senderEmail == sessionScope.userSession.email}">
									<!-- 내 메시지 -->
									<li class="chat-message self">
										<div class="message-wrapper">
											<span class="message-sender">${chatLog.senderNickname}</span>:
											<span class="message-content">${chatLog.content}</span>
										</div>
										<div class="message-timestamp">
											<span class="timestamp-date"> <fmt:formatDate
													value="${chatLog.createdAt}" pattern="yy.MM.dd" />
											</span><br> <span class="timestamp-time"> <fmt:formatDate
													value="${chatLog.createdAt}" pattern="HH:mm" />
											</span>
										</div>
									</li>
								</c:if>
								<c:if
									test="${chatLog.senderEmail != sessionScope.userSession.email}">
									<!-- 상대 메시지 -->
									<li class="chat-message other">
										<div class="message-timestamp">
											<span class="timestamp-date"> 
												<fmt:formatDate	value="${chatLog.createdAt}" pattern="yy.MM.dd" />
											</span><br> <span class="timestamp-time"> 
												<fmt:formatDate	value="${chatLog.createdAt}" pattern="HH:mm" />
											</span>
										</div>
										<div class="message-wrapper">
											<span class="message-sender">${chatLog.senderNickname}</span>:
											<span class="message-content">${chatLog.content}</span>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</c:when>
					<c:otherwise>
						<p class="no-messages">채팅방을 선택하세요.</p>
					</c:otherwise>
				</c:choose>

				<!-- 메시지 입력 폼 -->
				<form id="messageForm">
					<input type="text" id="message" placeholder="Type a message..."
						autocomplete="off" />
					<button type="submit">Send</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 서버에서 전달된 값 (nickname, roomId) -->
	<script>
	document.querySelectorAll('.chat-room').forEach(room => {
	    room.addEventListener('click', function () {
	        const roomId = this.getAttribute('data-room-id');
	        const paymentNumber = roomId; // 여기서 roomId를 payment_number로 변환

	        if (roomId !== currentRoomId) {
	            // URL은 payment_number로 표시 후 새로고침
	            window.location.href = `/chat?payment_number=${paymentNumber}`;
	        } else {
	            // 동일 채팅방 클릭 시에도 새로고침
	            window.location.reload(); // 페이지 새로고침
	        }
	    });
	});


    </script>
	<script>
    // URL에서 roomId 추출
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get('payment_number'); // payment_number를 roomId로 설정
    const username = "${sessionScope.userSession.email}"; // 세션 값으로 username 설정

    // 디버깅용 콘솔 출력
    console.log("Extracted roomId:", roomId);
    console.log("Username:", username);
</script>

	<!-- JavaScript 라이브러리 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="/js/chat.js"></script>
</body>
</html>
