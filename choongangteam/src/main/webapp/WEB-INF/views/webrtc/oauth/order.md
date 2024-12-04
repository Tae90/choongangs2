

naverlogin controller -> naverlogin.jsp : 로그인 버튼 생성 -> 클릭시 네이버 자체 로그인 화면으로 넘어감 

api설정에서 로그인 완료시 호출할 콜백 페이지를 입력하라고 하는데 그 부분에서 complete입력

서비스 환경 Callback URL : http://localhost/complete
연결 끊기 Callback URL : http://localhost/complete

-> complete controller : 네이버에서 로그인이 성공하면 code와 state를 넘겨주는데 그것을 받고 model에 저장

-> complete.jsp : code값과 state값을 넘겨주면 naver에서 사용자 정보를 제공받을 수 있는 액세스 토큰을 준다. 토큰을 받음

-> getUserProfile controller : token을 입력 받아서 네이버에서 정보를 가져온다. responseBody에 정보가 저장
