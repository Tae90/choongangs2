'use strict';

var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');
var chatRooms = document.querySelectorAll('.chat-room'); // 채팅방 목록 요소 선택

var stompClient = null;
var currentRoomId = null;

document.addEventListener("DOMContentLoaded", function () {
    if (username && roomId) {
        currentRoomId = roomId; // 초기 roomId 설정
        startChat();
    } else {
        console.error("Username or Room ID is not defined.");
    }

    // 각 채팅방 클릭 이벤트 리스너 등록
    chatRooms.forEach(room => {
        room.addEventListener('click', function () {
            const newRoomId = this.getAttribute('data-room-id');

            if (newRoomId !== currentRoomId) {
                window.location.href = `/chat?payment_number=${newRoomId}`; // URL 변경
            }
        });
    });
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
            senderEmail: username,
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

    var messageElement = document.createElement('li');

    if (message.senderEmail === username) {
        messageElement.classList.add('chat-message', 'self');
        messageElement.innerHTML = `
            <div class="message-wrapper">
                <span class="message-sender">${message.senderNickname}</span>:
                <span class="message-content">${message.content}</span>
            </div>
            <div class="message-timestamp">
                <span class="timestamp-date">${formatDate(new Date(message.createdAt))}</span><br>
                <span class="timestamp-time">${formatTime(new Date(message.createdAt))}</span>
            </div>
        `;
    } else {
        messageElement.classList.add('chat-message', 'other');
        messageElement.innerHTML = `
            <div class="message-timestamp">
                <span class="timestamp-date">${formatDate(new Date(message.createdAt))}</span><br>
                <span class="timestamp-time">${formatTime(new Date(message.createdAt))}</span>
            </div>
            <div class="message-wrapper">
                <span class="message-sender">${message.senderNickname}</span>:
                <span class="message-content">${message.content}</span>
            </div>
        `;
    }

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
}

function formatDate(date) {
    return date.toLocaleDateString('en-GB').split('/').reverse().join('.');
}

function formatTime(date) {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

messageForm.addEventListener('submit', sendMessage, true);
