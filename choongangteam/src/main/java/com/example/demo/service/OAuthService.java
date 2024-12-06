package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@Service
public class OAuthService {

	// 카카오 액세스 토큰 얻기
    public String getKakaoAccessToken(String code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=6f3ddfb13ef8ecdc68981d7cbb221743"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://localhost/kakaoCallback"); // TODO 인가코드 받은 redirect_uri 입력
            sb.append("&code=" + code); // 로그인하면 주는 인증코드, 토큰을 발급받을 때 사용한다.
            bw.write(sb.toString());
            bw.flush();

            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            // 요청을 통해 얻은 JSON 타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            // Jackson 라이브러리를 사용하여 JSON 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(result);

            
            // refresh_token은 유효기간이 짧은 액세스 토큰을 재발급받기위한 토큰
            access_Token = rootNode.path("access_token").asText();
            refresh_Token = rootNode.path("refresh_token").asText();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
    }
    
    // 발급받으 액세스 토큰으로 사용자 정보 조회 요청하기
    public HashMap<String, String> getUserInfo(String accessToken) {
     
        String reqURL = "https://kapi.kakao.com/v2/user/me";  // 사용자 정보 조회 API

        HashMap<String, String> userInfo = new HashMap<>();
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // GET 요청을 위한 설정
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);  // 헤더에 액세스 토큰 추가

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode: " + responseCode);

            if (responseCode == 200) {  // 성공적인 응답 처리
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line = "";
                String result = "";

                while ((line = br.readLine()) != null) {
                    result += line;
                }
                System.out.println("User Info Response: " + result);

                // JSON 응답 파싱 (닉네임, 아이디)
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode rootNode = objectMapper.readTree(result);
                String nickname = rootNode.path("properties").path("nickname").asText();
                String id = rootNode.path("id").asText();

//                userInfo = "ID: " + id + ", Nickname: " + nickname;
                
                userInfo.put("id", id);
                userInfo.put("nickname", nickname);
                
            } else {
                System.out.println("Error Response Code: " + responseCode);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return userInfo;
    }
}
    
    
    
