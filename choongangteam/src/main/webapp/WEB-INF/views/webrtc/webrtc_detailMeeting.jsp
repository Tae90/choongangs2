<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>방송 상세 페이지</title>

<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/6.4.0/adapter.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.70/jquery.blockUI.min.js"></script>
<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/spin.js/2.3.2/spin.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>

<script type="text/javascript" src="../js/webrtc/janus.js"></script>
<script type="text/javascript" src="../js/webrtc/webrtc_detailMeeting.js?ver=12"></script>

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

.left-side, .broadcast-detail, .participant-section {
    /* flex: 1; */
    overflow-y: auto;
}

/* 열른쪽 스타일 (나중에 조회) */
.left-side {
    /* flex: 1 1 10%; */
    width: 15%;
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
    padding:20px;
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
    min-width: 20px;
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

/* 참가자 개인 화면 스타일 */
.participant-section {
    flex: 1;
    min-width: 300px;
    background-color: #e9ecef;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: auto auto auto;
    gap: 20px;
    transition: max-height 0.3s ease, opacity 0.3s ease;
}

.participant-view {
    background-color: #ffffff;
    border-radius: 10px;
    padding: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
}

.participant-view img {
    width: 100%;
    height: auto;
    border-radius: 10px;
}

/* 접기/펼치기 버튼 스타일 */
.participant-toggle-button {
    padding: 10px;
    min-width: 100px;
    background-color: #4b0082;
    color: #ffffff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: transform 0.3s;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.participant-toggle-button:hover {
    background-color: #6a0dad;
    transform: scale(1.1);
}

.participant-section.collapsed {
    max-height: 0;
    opacity: 0;
    padding: 0;
    overflow: hidden;
}
</style>
<script>
    function toggleParticipants() {
        const participantSection = document.querySelector('.participant-section');
        if (participantSection.classList.contains('collapsed')) {
            participantSection.classList.remove('collapsed');
            document.querySelector('.participant-toggle-button').innerHTML = '접기◀';
        } else {
            participantSection.classList.add('collapsed');
            document.querySelector('.participant-toggle-button').innerHTML = '▶펼치기';
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
                <!-- 붙여 넣기 -->
                <div class="panel-body" id="videolocal"></div>
                
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
                <button class="participant-toggle-button" onclick="toggleParticipants()">접기◀</button>
            </div>
        </div>
    </div>

    <!-- 참가자 개인 화면 -->
    <div class="participant-section">
        <div class="participant-view">
            <div class="panel-body relative" id="videoremote1"></div>
        </div>
        <div class="participant-view">
            <div class="panel-body relative" id="videoremote2"></div>
        </div>
        <div class="participant-view">
            <div class="panel-body relative" id="videoremote3"></div>
        </div>
        <div class="participant-view">
            <div class="panel-body relative" id="videoremote4"></div>
        </div>
        <div class="participant-view">
            <div class="panel-body relative" id="videoremote5"></div>
        </div>
        <div class="participant-view">
            <div class="panel-body relative" id="videoremote6"></div>
        </div>
    </div>
</body>
</html>
