<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>

	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
	<link href="/css/reply.css" rel="stylesheet">
	
	<script src="/js/reply.js"></script>
	

	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<c:if test="${!empty userSession && userSession.member_number != 1 }">
<div id="reply_insertSection" class="container"> 
	<div style="margin-top: 16px;">
		<div style="width: 100%;">
		
		<form method="post" action="/reply_insert" id="form" name="form" onsubmit="replychk(event)">
			<input type="hidden" name="member_email" value="${userSession.email }">
			<!-- 게시판 번호도 히든으로 추가해야함 -->
			<input type="hidden" name="lesson_number" value="${lesson_number}">		
			
			<fieldset style="display: inline-block; direction: rtl; border: 0; padding: 0; margin: 0; width: 100%; text-align: left;">
				<span style="color: rgb(150, 150, 150);">별점을 선택해주세요</span>
				<input type="radio" name="reply_score" value="5" id="rate1"><label for="rate1">★</label>
				<input type="radio" name="reply_score" value="4" id="rate2"><label for="rate2">★</label>
				<input type="radio" name="reply_score" value="3" id="rate3"><label for="rate3">★</label>
				<input type="radio" name="reply_score" value="2" id="rate4"><label for="rate4">★</label>
				<input type="radio" name="reply_score" value="1" id="rate5"><label for="rate5">★</label>
			</fieldset>			

			<div style="margin-top: 8px; display: flex; align-items: center; gap: 8px;">
				<textarea name="reply_content" style="resize: none; height: 5rem; padding: 0.375rem; width: 100%; font-size: 0.875rem; line-height: 1.25rem; border: 1px solid #e5e7eb; border-radius: 0.375rem; color: #1f2937; box-sizing: border-box; box-shadow: inset 0 0 0 1px rgba(209, 213, 219, 0.5);"></textarea>
				<button type="submit" style="background-color: rgb(152, 50, 168); color: white; border-radius: 5px; display: flex; justify-content: center; align-items: center; width: 100px; height: 5rem; cursor: pointer; text-align: center; border: none; ">
					<span>등록</span>
				</button>
			</div>
		</form>		
		
		</div>
	</div>
</div>
</c:if>

</body>
</html>