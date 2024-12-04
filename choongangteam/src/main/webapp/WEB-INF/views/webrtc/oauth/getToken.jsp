<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
   <script>
      async function getUserProfile(accessToken) {
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

   // 사용 예시: 액세스 토큰 입력 후 호출
   const accessToken = "your_access_token_here";
   getUserProfile(accessToken);
  
   </script>
</body>
</html>