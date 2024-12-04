<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>방송 상세 페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
<style>
/* 페이지 전체 스타일 */
body {
	font-family: 'Pretendard', sans-serif;
	font-size: .875rem;
	font-weight: 500;
	background-color: #ffffff;
	color: #333333;
	margin: 0;
	padding: 20px;
	display: flex;
	gap: 20px;
	overflow-x: hidden;
	overflow-y: auto;
	height: 100vh;
	box-sizing: border-box;
}

.left-side, .broadcast-detail, .chat-section {
	flex: 1;
	overflow-y: auto;
}

/* 열른쪽 스타일 (나중에 조회) */
.left-side {
	flex: 1 1 20%;
	min-width: 300px;
	background-color: #f1f1f1;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 방송 상세 정보 연습 스타일 */
.broadcast-container {
	display: flex;
	flex-direction: column;
	height: 100%;
	gap: 20px;
}

/* 방송 화면 스타일 */
.broadcast-detail {
	flex: 8;
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: flex 0.3s ease;
}

.broadcast-detail img {
	width: 100%;
	height: auto;
	border-radius: 10px;
}

/* 방송 정보 스타일 */
.broadcast-info {
	flex: 2;
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	flex-wrap: nowrap;
}

.broadcaster-details {
	flex: 1;
	min-width: 200px;
}

.broadcast-title h1 {
	font-size: 2em;
	color: #4b0082;
	margin-bottom: 20px;
}

.profile-banner {
	display: flex;
	align-items: center;
	flex-wrap: nowrap;
}

.profile-image {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	margin-right: 10px;
}

.broadcaster-info h2 {
	margin: 0;
}

.recoding-buttons {
	display: flex;
	gap: 10px;
	align-items: center;
	flex-shrink: 0;
}

.recoding-buttons button {
	padding: 10px;
	min-width: 100px;
	background-color: #4b0082;
	color: #ffffff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.2s;
}

.recoding-buttons button:hover {
	background-color: #6a0dad;
	transform: scale(1.05);
}

/* 채팅창 접기 버튼 스타일 */
.collapse-button {
	padding: 10px;
	background-color: #4b0082;
	color: #ffffff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.2s;
}

.collapse-button:hover {
	background-color: #6a0dad;
	transform: scale(1.05);
}

/* 채팅창 연습 스타일 */
.chat-section {
	flex: 1;
	min-width: 300px;
	background-color: #e9ecef;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	position: relative;
	transition: max-height 0.3s ease, opacity 0.3s ease;
}

/* 채팅창 허더 스타일 */
.chat-header {
	background-color: #4b0082;
	padding: 10px;
	text-align: center;
	font-size: 1.2em;
	color: #ffffff;
	border-radius: 10px 10px 0 0;
}

/* 채팅 메시지 박스 스타일 */
.chat-box {
	flex: 1;
	min-height: 300px;
	max-height: calc(100% - 120px);
	overflow-y: auto;
	background-color: #ffffff;
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 0 0 10px 10px;
	border: 1px solid #dee2e6;
}

/* 채팅 메시지 스타일 */
.chat-message {
	margin: 10px 0;
}

/* 채팅 입력 연습 스타일 */
.chat-input {
	display: flex;
	gap: 10px;
}

.chat-input input[type="text"] {
	flex: 1;
	padding: 10px;
	border: 1px solid #ced4da;
	border-radius: 5px;
}

.chat-input button {
	padding: 10px;
	min-width: 100px;
	background-color: #4b0082;
	color: #ffffff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.2s;
}

.chat-input button:hover {
	background-color: #6a0dad;
	transform: scale(1.05);
}

/* 채팅창 접히지 않은 상타 스타일 */
.chat-section.collapsed {
	max-height: 0;
	opacity: 0;
	padding: 0;
}

.chat-section.collapsed+.broadcast-detail {
	flex: 3 1 80%;
}
</style>
<script>
	function toggleChat() {
		const chatSection = document.querySelector('.chat-section');
		const broadcastDetail = document.querySelector('.broadcast-detail');
		if (chatSection.classList.contains('collapsed')) {
			chatSection.classList.remove('collapsed');
			broadcastDetail.style.flex = '3 1 60%';
			document.querySelector('.collapse-button').innerHTML = '접기◀';
		} else {
			chatSection.classList.add('collapsed');
			broadcastDetail.style.flex = '3 1 80%';
			document.querySelector('.collapse-button').innerHTML = '▶펼치기';
		}
	}
</script>
</head>
<body>
	<!-- 레프트 사이드 -->
	<div class="left-side">
		<!-- 빈 공간 -->
	</div>

	<!-- 방송 상세 정보 -->
	<div class="broadcast-container">
		<!-- 방송 화면 -->
		<div class="broadcast-detail">
			<div class="broadcast-image">
				<img src="/images/seoul_banner.jpg" alt="방송 이미지">
			</div>
		</div>

		<!-- 방송 정보 -->
		<div class="broadcast-info">
			<div class="broadcaster-details">
				<div class="broadcast-title">
					<h1>방송 제목</h1>
				</div>
				<div class="profile-banner">
					<img src="/images/profile.jpg" alt="방송중인 사람 프로필 이미지" class="profile-image">
					<div class="broadcaster-info">
						<h2>방송자 닉네임</h2>
						<p>사용자 등급: 키워드</p>
						<div class="keywords">키워드: 방송, 뉴스, 게임</div>
					</div>
				</div>
			</div>

			<!-- 녹화 및 화면공유 -->
			<div class="recoding-buttons">
				<button>녹화</button>
				<button>화면공유</button>
				<!-- 채팅창 접기 버튼 -->
				<button class="collapse-button" onclick="toggleChat()">접기◀</button>
			</div>
		</div>
	</div>

	<!-- 채팅창 연습 -->
	<div class="chat-section">
		<div class="chat-header">채팅창</div>
		<div class="chat-box">
			<div class="chat-message">사용자1: 안녕하세요!</div>
			<div class="chat-message">사용자2: 오늘 방송 기대되요!</div>
		</div>
		<div class="chat-input">
			<input type="text" placeholder="메시지를 입력하세요...">
			<button>전송</button>
		</div>
	</div>
</body>
</html>
