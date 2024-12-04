<%@ page contentType="text/html; charset=UTF-8" %>

<%
  String codeV =(String) request.getAttribute("code");
  String stateV =(String) request.getAttribute("state");
%>

<%= codeV %>
<%= stateV %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>

   codeV = "<%= codeV %>";
   stateV = "<%= stateV %>";

   $(document).ready(function() {
      
      let token;
      $.get("https://nid.naver.com/oauth2.0/token", { grant_type: "authorization_code", client_id: "R3AfPrSvub6W6dRheDta" ,client_secret:"TPUOkQtLx2",code:codeV, state:stateV}, function(response) {
         token = response.access_token;
         console.log(token);

         $("#result").text("Response access_token: " + response.access_token);

         location.href = "http://localhost/oauth/getUserProfile?token="+encodeURIComponent(token);
      });

   });

   //프론트에서 사용자 정보를 가져올 수 있지만 컨트롤러에서 사용자 정보를 가져오도록 처리
   async function getUserProfile(accessToken) {
         alert(accessToken)
         const url = "https://openapi.naver.com/v1/nid/me";

         try {
            const response = await fetch(url, {
                  method: "GET",
                  headers: {
                     "Authorization": `Bearer ${accessToken}`, // Access Token 추가
                  },
            });

            if (!response.ok) {
                  throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            console.log(data); // 회원 프로필 정보 출력
         } catch (error) {
            console.error("Error fetching profile:", error);
         }
   }
</script>

<div id="result"></div>