package com.example.demo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class IamportService {
	
	private final String api_url = "https://api.iamport.kr";
	private final String imp_key = "1873380485765841";
    private final String imp_secret = "7Ggs7h9WiB1iZUJOCrIlhnR6ivPnV4y4UsYqYYZ2vHjY6fzy3Yyw8elkcT8VbO65LQ18rST015lVHVmV";
	
    private String getAccessToken() {
    	RestTemplate restTemplate = new RestTemplate();
    	// 아임포트 액세스 토큰 발급 API URL
    	String url = api_url + "/users/getToken";
    
    // 액세스 토큰 요청 데이터 (imp_key와 imp_secret 전달)
    Map<String, String> request = new HashMap<>();
    request.put("imp_key", imp_key);		// 아임포트 REST API 키
    request.put("imp_secret", imp_secret);	// 아임포트 REST API 시크릿
    
    // HTTP 요청 헤더 설정 (Content-Type: application/json)
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    
    // 요청 데이터를 JSON 형식으로 변환
    ObjectMapper objectMapper = new ObjectMapper();
    String jsonRequest;
    try {
    	jsonRequest = objectMapper.writeValueAsString(request);
    	System.out.println("결제 취소 요청 데이터 (JSON): " + jsonRequest);
    }catch(JsonProcessingException e){
    	throw new RuntimeException("직렬화 오류:" + e.getMessage());
    }
    
    // HTTP 요청 생성
    HttpEntity<String> entity = new HttpEntity<>(jsonRequest, headers);
    
    // 디버깅
    System.out.println("Access Token 요청 URL: " + url);
    System.out.println("Access Token 요청 데이터: " + request);
    
    // POST 요청을 보내고 응답을 받음
    ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
    
    // 응답 확인
    System.out.println("Access Token 응답 데이터: " + response.getBody());
    
    // 응답 데이터에서 액세스 토큰 추출
    Map<String, Object> responseBody = (Map<String, Object>) response.getBody().get("response");
    
    if (responseBody == null) {
        throw new RuntimeException("액세스 토큰 발급 실패: " + response.getBody());
    }
    
    return (String) responseBody.get("access_token"); 

  }
    public boolean cancelPayment(String imp_uid, String reason, int amount) {
		RestTemplate restTemplate = new RestTemplate();
		// 아임포트 결제 취소 API URL
		String url = api_url + "/payments/cancel";
    	
		// 액세스 토큰 발급
		String accessToken = getAccessToken();
		
		// 결제 취소 요청 데이터
        Map<String, Object> request = new HashMap<>();
        request.put("imp_uid", imp_uid);    // 아임포트 결제 고유 번호
        request.put("reason", reason);      // 결제 취소 사유
        request.put("amount", amount);      // 취소 금액
        
        // HTTP 요청 헤더 설정 (Content-Type: application/json + Bearer Token)
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(accessToken);
                
        // HTTP 요청 생성 (헤더 + 바디)
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(request, headers);
        
        // 디버깅: 요청 데이터와 URL 출력
        System.out.println("결제 취소 요청 URL: " + url);
        System.out.println("결제 취소 요청 데이터: " + request);
        
        // POST 요청으로 결제 취소 API 호출
        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
        
        // 응답 확인
        System.out.println("결제 취소 응답 데이터: " + response.getBody());
    	
        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        return responseBody.get("code").equals(0);	// code가 0이면 성공
	}
}
