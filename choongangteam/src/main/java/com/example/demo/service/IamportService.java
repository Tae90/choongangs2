package com.example.demo.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.jasper.tagplugins.jstl.core.Url;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonToken;
import com.google.gson.Gson;
import com.google.gson.JsonParser;
import com.nimbusds.jose.shaded.gson.JsonObject;

import net.minidev.json.JSONObject;

@Service
public class IamportService {
	
	private final String api_url = "https://api.iamport.kr";
	private final String imp_key = "1873380485765841";
    private final String imp_secret = "7Ggs7h9WiB1iZUJOCrIlhnR6ivPnV4y4UsYqYYZ2vHjY6fzy3Yyw8elkcT8VbO65LQ18rST015lVHVmV";
	
    public String getAccessToken() throws IOException{
    	HttpsURLConnection conn = null;
    	
		URL url = new URL("https://api.iamport.kr/users/getToken");
		conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);

		JsonObject json = new JsonObject();
		
		json.addProperty("imp_key", imp_key);
		json.addProperty("imp_secret", imp_secret);

		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream())); 
		
		bw.write(json.toString());
		bw.flush();		
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();


		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
		
  }
    public String cancelPayment(String token, String imp_uid, String reason, int amount) throws IOException{

        String responseMessage = null;

    	HttpsURLConnection conn = null;
    	
		URL url = new URL(api_url+"/payments/cancel");
		
		conn = (HttpsURLConnection) url.openConnection();
		
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Authorization", token);
        
        conn.setDoOutput(true);
    	
        JsonObject json = new JsonObject();

        json.addProperty("reason", reason);
        json.addProperty("imp_uid", imp_uid);
        json.addProperty("amount", amount);
        json.addProperty("checksum", amount);

        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

        bw.write(json.toString());
               
        bw.flush();
        bw.close();


        int responseCode = conn.getResponseCode();
        String responseCodeString = String.valueOf(responseCode);  // int 값을 String으로 변환
        
        
        return responseCodeString;	// code 200 이면 성공
	}
}