<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <title>Spring Boot WebSocket Chat Application</title>
    <link rel="stylesheet" href="/css/chat.css">
</head>
<body>
<noscript>
    <h2>Sorry! Your browser doesn't support Javascript</h2>
</noscript>

<!-- 채팅 페이지 -->
<div id="chat-page">
    <div class="chat-container">
        <div class="chat-header">
            <h2>Spring WebSocket Chat Demo</h2>
        </div>
        <div class="connecting">
            Connecting...
        </div>
        <ul id="messageArea">
            <!-- 메시지 리스트: 아래 JavaScript에서 동적으로 추가 -->
        </ul>
        <form id="messageForm" name="messageForm">
            <div class="form-group">
                <div class="input-group clearfix">
                    <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                    <button type="submit" class="primary">Send</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 서버에서 전달된 nickname을 JavaScript로 넘김 -->
<script>
    const username = "${nickname}"; // UserSession의 nickname 값 전달
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/js/chat.js"></script>
</body>
</html>
