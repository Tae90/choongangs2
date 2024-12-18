'use strict';

var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;

document.addEventListener("DOMContentLoaded", function () {
    if (username && roomId) {
        startChat();
    } else {
        console.error("Username or Room ID is not defined.");
    }
});

function startChat() {
    var socket = new SockJS('/chat/ws');
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function () {
        onConnected();
    }, onError);
}

function onConnected() {
    stompClient.subscribe('/topic/public', onMessageReceived);

    // Send JOIN message to the server
    stompClient.send("/app/chat.addUser", {}, JSON.stringify({
        senderEmail: username,
        roomId: roomId,
        messageType: 'JOIN'
    }));

    connectingElement.classList.add('hidden');
}

function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server.';
    connectingElement.style.color = 'red';
}

function sendMessage(event) {
    var messageContent = messageInput.value.trim();

    if (messageContent && stompClient) {
        var chatMessage = {
            senderEmail: username, // 내 메시지 전송 시 내 이메일 포함
            content: messageContent,
            roomId: roomId,
            messageType: 'CHAT'
        };

        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
    event.preventDefault();
}

function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);

    console.log("Received Message Sender:", message.senderEmail);
    console.log("Current User (Session):", username);

    // 메시지 요소 생성
    var messageElement = document.createElement('li');

    // 내 메시지와 상대방 메시지 구분
	if (message.senderEmail === username) { // 내 메시지 (세션 값으로 비교)
	    messageElement.classList.add('chat-message', 'self'); // 내 메시지 (왼쪽)
	    messageElement.innerHTML = `
	        <div class="chat-message">
	            <div class="message-wrapper">
	                <span class="message-sender">${message.senderNickname}</span>:
	                <span class="message-content">${message.content}</span>
	            </div>
	            <div class="message-timestamp">
	                <span class="timestamp-date">${formatDate(new Date())}</span><br>
	                <span class="timestamp-time">${formatTime(new Date())}</span>
	            </div>
	        </div>
	    `;
	} else { // 상대방 메시지
	    messageElement.classList.add('chat-message', 'other'); // 상대방 메시지 (오른쪽)
	    messageElement.innerHTML = `
	        <div class="chat-message">
	            <div class="message-timestamp">
	                <span class="timestamp-date">${formatDate(new Date())}</span><br>
	                <span class="timestamp-time">${formatTime(new Date())}</span>
	            </div>
	            <div class="message-wrapper">
	                <span class="message-sender">${message.senderNickname}</span>:
	                <span class="message-content">${message.content}</span>
	            </div>
	        </div>
	    `;
	}


    // 채팅창에 메시지 추가
    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight; // 스크롤을 아래로 이동
}


// 날짜와 시간 포맷 함수
function formatDate(date) {
    return date.toLocaleDateString('en-GB').split('/').reverse().join('.'); // yy.MM.dd
}

function formatTime(date) {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

messageForm.addEventListener('submit', sendMessage, true);