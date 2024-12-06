<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<!-- css -->
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
	<!-- 폰트 -->
	<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@400;500;700&display=swap" rel="stylesheet">
	
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<!-- 카카오 로그인관련 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		// 카카오 sdk 초기화
	 	Kakao.init('6f3ddfb13ef8ecdc68981d7cbb221743');

	    // SDK 초기화 여부를 판단합니다.
	    console.log(Kakao.isInitialized());
	</script>
	<!-- 네이버 로그인관련 -->
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	
	
	
	
	<style>
		/* 버튼색 */
		.bg-kakao-login{
    		--tw-bg-opacity: 1;
   			background-color: rgb(254 229 0/var(--tw-bg-opacity));
		}
		.bg-naver-login{
    		--tw-bg-opacity: 1;
   			background-color: rgb(3 199 90/var(--tw-bg-opacity));
		}
		/* 폰트 */
		.basic_font{
			font-family: 'Gothic A1', sans-serif;
 			font-weight: 500;			 
		}
		/* 글자색 */
		.text-gray {
    		--tw-text-opacity: 1;
    		color: rgb(150 150 150 / var(--tw-text-opacity));
		}
	
	</style>	
	
	<script>
	function loginWithKakao() {
		// 카카오 버튼을 누를시 로그인창을 호출하는 함수
		Kakao.Auth.authorize({
		    redirectUri: 'http://localhost/kakaoCallback', // 인증 후 리디렉션할 URI, 미리 카카오에 설정해야 한다.
		    success: function (authObj) {
		        // 인증이 완료되면 실행되는 부분
// 		        alert("로그인 성공:", authObj);
		        // 인증된 토큰을 사용하여 사용자 정보 요청				        
		    },
		    fail: function (error) {
		        // 인증 실패 시 처리
// 		        alert("인증 실패:", error);
		    }
		});
	  }	
	</script>

	<title>로그인</title>

</head>

<body>

<div class="main">

	<div class="min-h-screen flex flex-1 flex-col justify-center items-center px-6 py-20 lg:px-8 max-w-7xl mx-auto w-full">
	<div class="sm:mx-auto sm:w-full sm:max-w-sm">
		<h2 class="mt-10 text-3xl font-semibold leading-snug tracking-tighter text-center text-taling-gray-800">로그인 화면<br>초본</h2>		
	</div>
	
	<div class="w-full max-w-sm mt-16 sm:mx-auto">
		<div class="flex flex-col gap-4">
       		<!-- 카카오 로그인 버튼 -->
			<div class="bg-kakao-login py-3 rounded-xl shadow-md cursor-pointer relative" tabindex="0" style="transform: none;" onclick="loginWithKakao()" >
       			<div class="flex items-center justify-center gap-2 basic_font">
       				<!-- 로고 크기 -->
       				<svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="currentColor" viewBox="0 0 550 550">
						<!-- 로고 -->
       					<path d="M255.5 48C299.345 48 339.897 56.5332 377.156 73.5996C414.415 90.666 443.871 113.873 465.522 143.22C487.174 172.566 498 204.577 498 239.252C498 273.926 487.174 305.982 465.522 335.42C443.871 364.857 414.46 388.109 377.291 405.175C340.122 422.241 299.525 430.775 255.5 430.775C241.607 430.775 227.262 429.781 212.467 427.795C148.233 472.402 114.042 494.977 109.892 495.518C107.907 496.241 106.012 496.15 104.208 495.248C103.486 494.706 102.945 493.983 102.584 493.08C102.223 492.177 102.043 491.365 102.043 490.642V489.559C103.126 482.515 111.335 453.169 126.672 401.518C91.8486 384.181 64.1974 361.2 43.7185 332.575C23.2395 303.951 13 272.843 13 239.252C13 204.577 23.8259 172.566 45.4777 143.22C67.1295 113.873 96.5849 90.666 133.844 73.5996C171.103 56.5332 211.655 48 255.5 48Z">
       					</path>
       				</svg>
				       카카오로 로그인하기
       			</div>
			</div>		       
			<div id="naverLoginBtn" class="bg-naver-login text-white py-3 rounded-xl shadow-md cursor-pointer relative">
       			<div class="flex items-center justify-center gap-2 basic_font">
       				<svg class="w-4 h-4 text-white " viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">
       					<path d="M81.5802 13H114V114H82.8272L45.4198 61.0062V114H13V13H44.1728L80.9568 65.9938L81.5802 13Z" fill="currentColor">
       					</path>
       				</svg>
				       네이버로 로그인하기
       			</div>
			</div>		       
		</div>
		<div class="relative mt-14 ">
			<div class="absolute inset-0 flex items-center" aria-hidden="true">
				<!-- 아래 이메일로 로그인과 구분되게 회색선 출력 -->
				<div class="w-full mx-2 border-t border-taling-gray-300"></div>
			</div>
			<div class="relative flex justify-center text-sm font-medium leading-6">
				<span class="px-6 bg-white text-gray basic_font">또는</span>
			</div>
		</div>	

		<div class="flex justify-center gap-8 mt-6 text-sm text-gray basic_font ">
			<div class="w-full text-center ">
				<a class="cursor-pointer" href="email_loginpage">이메일로 로그인</a>		
			</div>
		</div>
	</div>
       
       
	</div>
</div>

<!-- 네이버 로그인기능 -->

<!-- 네이버에서 자체제공하는 버튼이다 몇가지 바리에이션이 있지만 맘에 들지않아
	 안보이게 하고 커스텀 버튼으로 클릭 이벤트를 연결할 것이다. -->
<div id="naver_id_login" style="display: none;"></div>

<script type="text/javascript">
	    
	// 네이버 로그인 객체 생성							clientID				콜백uri
	var naver_id_login = new naver_id_login("MjilLtWpbUBN_5nya8ed", "http://localhost/naverCallback");
	
	var state = naver_id_login.getUniqState();
	naver_id_login.setDomain("http://localhost/naverLogin");
	naver_id_login.setState(state);
	// naver_id_login.setPopup(); // 팝업 방식 해제

	naver_id_login.init_naver_id_login();

	// 내가 만든 커스텀버튼 id= naverLoginBtn 클릭시 naver_id_login를 클릭한것 처럼 동작
	$(document).on("click", "#naverLoginBtn", function(){ 
		var naverLoginBtn = document.getElementById("naver_id_login").firstChild;
		naverLoginBtn.click();
	});
	
	</script>
</body>

</html>