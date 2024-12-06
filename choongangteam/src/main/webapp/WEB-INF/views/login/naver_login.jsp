<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<script src="http://code.jquery.com/jquery-latest.js"></script>	
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>

<body>

<script>

//.gitignore 해야된다..

var naver_id_login = new naver_id_login("MjilLtWpbUBN_5nya8ed", "http://localhost/naverCallback");
//   alert(naver_id_login.oauthParams.access_token);
naver_id_login.get_naver_userprofile("naverSignInCallback()");
//   alert('콜백실행');

// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
function naverSignInCallback() {
    id = naver_id_login.getProfileData('id');
    nickname = naver_id_login.getProfileData('nickname'); 

    $.ajax({
       type: 'POST',
       url: '/naverLogin_result',
       data : {'member_email': id, 'member_nickname': nickname},
       success: function(result){
           console.log("네이버 로그인 성공");
           // 연동기록 없는 네이버 로그인 경우
           
       },
        error: function(result){
           alert("네이버 로그인이 실패하였습니다.");                
        }
    });    
}
</script>
</body>

</html>