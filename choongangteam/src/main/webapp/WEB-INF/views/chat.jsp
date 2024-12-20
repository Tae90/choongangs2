<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <div class="chat-container">
            <div class="chat-header">
                
            </div>
            <div class="connecting">Connecting...</div>
            <!-- 채팅 메시지 출력 -->
            <ul id="messageArea">
                <c:forEach var="chatLog" items="${chatLogs}">
                    <c:if test="${chatLog.senderEmail == sessionScope.userSession.email}">
                        <!-- 내 메시지 (왼쪽) -->
                        <li class="chat-message self">
                            <div class="message-wrapper">
                                <span class="message-sender">${chatLog.senderNickname}</span>:
                                <span class="message-content">${chatLog.content}</span>
                            </div>
                            <div class="message-timestamp">
                                <span class="timestamp-date">
                                    <fmt:formatDate value="${chatLog.createdAt}" pattern="yy.MM.dd" />
                                </span><br>
                                <span class="timestamp-time">
                                    <fmt:formatDate value="${chatLog.createdAt}" pattern="HH:mm" />
                                </span>
                            </div>
                        </li>
                    </c:if>
                    <c:if test="${chatLog.senderEmail != sessionScope.userSession.email}">
                        <!-- 상대방 메시지 (오른쪽) -->
                        <li class="chat-message other">
                            <div class="message-timestamp">
                                <span class="timestamp-date">
                                    <fmt:formatDate value="${chatLog.createdAt}" pattern="yy.MM.dd" />
                                </span><br>
                                <span class="timestamp-time">
                                    <fmt:formatDate value="${chatLog.createdAt}" pattern="HH:mm" />
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

            <!-- 메시지 입력 폼 -->
            <form id="messageForm">
                <input type="text" id="message" placeholder="Type a message..." autocomplete="off" />
                <button type="submit">Send</button>
            </form>
        </div>
    </div>

    <!-- 서버에서 전달된 값 (nickname, roomId) -->
<script>
    const username = "${sessionScope.userSession.email}"; // 세션 값으로 username 설정
    const roomId = "${roomId}"; // roomId 유지
</script>
    <!-- JavaScript 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="/js/chat.js"></script>
</body>
</html>