<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>방송 리스트 페이지</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
/* 기본 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #ffffff; /* 발람 배경색 */
    color: #333333; /* 어두운 글자 색 */
    margin: 0;
    padding: 20px;
}

/* 방송 방 만들기 세션 스타일 */
.create-broadcast-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f1f3f5;
    padding: 40px;
    margin-bottom: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 600px;
    margin: 0 auto 30px auto;
}

.create-broadcast-title {
    font-size: 1.8em;
    color: #6a0dad;
    margin-bottom: 20px;
}

.create-broadcast-description {
    font-size: 1em;
    color: #6c757d;
    margin-bottom: 30px;
    text-align: center;
}

.create-broadcast-button {
    background-color: #6a0dad;
    color: #ffffff;
    padding: 15px 30px;
    font-size: 1.2em;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.create-broadcast-button:hover {
    background-color: #4b0082;
}

/* 전체방송 타이틀 스타일 */
.page-title {
    text-align: center;
    font-size: 2em;
    margin-bottom: 20px;
    color: #333333; /* 어두운 글자 색 */
}

/* 구분선 스타일 */
.divider {
    width: 90%;
    height: 3px;
    background-color: #6a0dad; /* 파란색 구분선 */
    margin: 10px auto 20px auto; /* 위아래 여배 조정 */
}

/* 탭 스타일 */
.tabs {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-bottom: 20px;
}

.tab {
    background-color: #e9ecef; /* 발람 회색 */
    color: #6a0dad; /* 파란색 글자 */
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s;
}

.tab:hover {
    background-color: #ced4da; /* 약간 더 어두운 회색 */
}

.tab.active {
    background-color: #6a0dad; /* 파란색 */
    color: #ffffff; /* 힌색 글자 */
}

/* 방송 카드 콘텐츠어 */
.container {
    display: none;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

.container.active {
    display: flex;
}

/* 방송 카드 스타일 */
.broadcast-card {
    background-color: #ffffff; /* 힌색 카드 배경 */
    border: 1px solid #dee2e6; /* 약간의 회색 테두리 */
    border-radius: 10px;
    overflow: hidden;
    width: 300px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s;
    cursor: pointer;
}

/* 방송 카드 호보 시 애니메이션 */
.broadcast-card:hover {
    transform: translateY(-10px);
}

/* 방송 이미지 스타일 */
.broadcast-card img {
    width: 100%;
    height: auto;
}

/* 방송 정보 스타일 */
.broadcast-info {
    padding: 15px;
}

/* 방송 제목 스타일 */
.broadcast-info h3 {
    margin: 0;
    font-size: 1.2em;
    color: #6a0dad; /* 파란색 제목 */
}

/* 방송 설명 스타일 */
.broadcast-info p {
    margin-top: 10px;
    font-size: 0.9em;
    color: #6c757d; /* 회색 설명 */
}

/* 스트리머 프로필 스타일 */
.streamer-profile {
    display: flex;
    align-items: center;
    margin-top: 15px;
}

.streamer-profile img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

.streamer-info {
    display: flex;
    flex-direction: column;
}

.streamer-info .nickname {
    font-size: 1em;
    font-weight: bold;
    color: #333333; /* 어두운 글자 색 */
}

.streamer-info .keywords {
    font-size: 0.8em;
    color: #6c757d; /* 회색 키워드 */
}
</style>

<script>
        function showTab(tabIndex) {
            const containers = document.querySelectorAll('.container');
            const tabs = document.querySelectorAll('.tab');

            // 모든 탭과 콘텐츠어의 혼성 상태를 초기화
            containers.forEach(container => container.classList.remove('active'));
            tabs.forEach(tab => tab.classList.remove('active'));

            // 선택된 탭과 콘텐츠어 혼성화
            containers[tabIndex].classList.add('active');
            tabs[tabIndex].classList.add('active');
        }

        document.addEventListener('DOMContentLoaded', () => {
            // 첫 번째 탭을 기본적으로 표시
            showTab(0);

            // 방송 카드를 클릭하면 webrtc_detail 페이지로 이동
            const broadcastCards = document.querySelectorAll('.broadcast-card');
            broadcastCards.forEach(card => {
                card.addEventListener('click', () => {
                    location.href = '/user/webrtc_detail';
                });
            });
        });
    </script>
</head>
<body>
   <!-- 레프트 사이드바 -->
    <div class="left-sidebar" style="width: 20%; float: left; padding: 20px; box-sizing: border-box; background-color: #f8f9fa; height: 100vh;">
        <h4>추천 방송</h4>
        <div class="channel-item" style="display: flex; align-items: center; margin-bottom: 15px;">
            <img src="https://via.placeholder.com/50" alt="프로필 사진" style="border-radius: 50%; margin-right: 10px;">
            <div>
                <div style="font-weight: bold; color: #ffffff;">스피드소닉</div>
                <div style="font-size: 0.9em; color: #b0b3b8;">바람의나라</div>
                <div style="color: #ff5555; font-weight: bold;">• 326</div>
            </div>
        </div>
        <div class="channel-item" style="display: flex; align-items: center; margin-bottom: 15px;">
            <img src="https://via.placeholder.com/50" alt="프로필 사진" style="border-radius: 50%; margin-right: 10px;">
            <div>
                <div style="font-weight: bold; color: #ffffff;">유히히</div>
                <div style="font-size: 0.9em; color: #b0b3b8;">메이플스토리</div>
                <div style="color: #ff5555; font-weight: bold;">• 165</div>
            </div>
        </div>
        <div class="channel-item" style="display: flex; align-items: center; margin-bottom: 15px;">
            <img src="https://via.placeholder.com/50" alt="프로필 사진" style="border-radius: 50%; margin-right: 10px;">
            <div>
                <div style="font-weight: bold; color: #ffffff;">두기잉</div>
                <div style="font-size: 0.9em; color: #b0b3b8;">마비노기</div>
                <div style="color: #ff5555; font-weight: bold;">• 89</div>
            </div>
        </div>
        <div class="channel-item" style="display: flex; align-items: center; margin-bottom: 15px;">
            <img src="https://via.placeholder.com/50" alt="프로필 사진" style="border-radius: 50%; margin-right: 10px;">
            <div>
                <div style="font-weight: bold; color: #ffffff;">미시코</div>
                <div style="font-size: 0.9em; color: #b0b3b8;">그림/아트</div>
                <div style="color: #ff5555; font-weight: bold;">• 81</div>
            </div>
        </div>
        <div class="channel-item" style="display: flex; align-items: center; margin-bottom: 15px;">
            <img src="https://via.placeholder.com/50" alt="프로필 사진" style="border-radius: 50%; margin-right: 10px;">
            <div>
                <div style="font-weight: bold; color: #ffffff;">미호밍</div>
                <div style="font-size: 0.9em; color: #b0b3b8;">로스트아크</div>
                <div style="color: #ff5555; font-weight: bold;">• 74</div>
            </div>
        </div>
        <button class="btn btn-secondary" style="width: 100%;">더보기 ▾</button>
    </div>
    <div class="main-content" style="width: 80%; float: left; padding: 20px; box-sizing: border-box;">


    <!-- 방송 방 만들기 세션 -->
    <div class="create-broadcast-section">
        <div class="create-broadcast-title">새로운 방송을 만들어보세요!</div>
        <div class="create-broadcast-description">시청자들과 소통하고 장소가수장사을 시작하세요. 다양한 콘텐츠로 나만의 방송을 만들 수 있습니다.</div>
        <button class="create-broadcast-button" data-toggle="modal" data-target="#broadcastModal">방송 만들기</button>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="broadcastModal" tabindex="-1" role="dialog" aria-labelledby="broadcastModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="broadcastModalLabel">방송 모드 선택</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label for="broadcastModeSelect">방송 모드를 선택해주세요</label>
                <select class="form-control" id="broadcastModeSelect">
                  <option>회의 모드</option>
                  <option>개인방송 모드</option>
                </select>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" onclick="startBroadcast()">방송 시작</button>
          </div>
        </div>
      </div>
    </div>

    <script>
        function startBroadcast() {
            const mode = document.getElementById('broadcastModeSelect').value;
            alert(`${mode}로 방송을 시작합니다.`);
            // 추가적인 로직을 여기에 작성 (예: 방송 생성 요청 보내기)
            $('#broadcastModal').modal('hide');
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- 전체방송 타이틀 추가 -->
	<div class="page-title">전체 방송 리스트</div>
	<!-- 구분선 추가 -->
	<div class="divider"></div>

	<!-- 탭 영역 -->
	<div class="tabs">
		<div class="tab" onclick="showTab(0)">인기</div>
		<div class="tab" onclick="showTab(1)">최신</div>
		<div class="tab" onclick="showTab(2)">추천</div>
	</div>

	<!-- 방송 카드 콘텐츠어들 -->
	<div class="container">
	<div class="broadcast-card">
			<img src="/static/images/seoul_banner.jpg" alt="방송 이미지">
			<div class="broadcast-info">
				<h3>방송 제목 1</h3>
				<p>방송 설명 및 키워드</p>
			</div>
			<div class="streamer-profile">
				<img src="https://via.placeholder.com/40" alt="스트리머 프로필">
				<div class="streamer-info">
					<div class="nickname">스트리머 닉네임</div>
					<div class="keywords">전략적 팀 전투, 아케인의 세계로</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="broadcast-card">
			<img src="/static/images/seoul_banner.jpg" alt="방송 이미지">
			<div class="broadcast-info">
				<h3>방송 제목 2</h3>
				<p>방송 설명 및 키워드</p>
			</div>
			<div class="streamer-profile">
				<img src="https://via.placeholder.com/40" alt="스트리머 프로필">
				<div class="streamer-info">
					<div class="nickname">스트리머 닉네임</div>
					<div class="keywords">종합 게임, 예능</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="broadcast-card">

			<img src="/static/images/seoul_banner.jpg" alt="방송 이미지">
			<div class="broadcast-info">
				<h3>방송 제목 3</h3>
				<p>방송 설명 및 키워드</p>
			</div>
			<div class="streamer-profile">
				<img src="https://via.placeholder.com/40" alt="스트리머 프로필">
				<div class="streamer-info">
					<div class="nickname">스트리머 닉네임</div>
					<div class="keywords">모험 게임, 해적 이야기</div>
				</div>
			</div>
		</div>
	</div>

    </div>
</body>
</html>
