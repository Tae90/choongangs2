<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>

	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<!-- 	sweetalert 사용 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
	<link href="/css/reply.css" rel="stylesheet">
	
	<script src="/js/reply.js"></script>
	
	

	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>

<!-- 댓글 전체 컨테이너 -->
<div id="reply_listSection" class="container">
	<input type="hidden" name="lesson_number" value="${lesson_number }">
	<input type="hidden" name="userEmail" value="${userSession.email }">
	<div>
		<h2 style="font-size: 1.125rem; font-weight: 600;">수강생 리뷰</h2>
	</div>
	
	<!-- 댓글 -->
	<c:forEach var="cl" items="${clist }" begin="0" end="4">
		<div id="${cl.reply_number }" class="comment-item">
			<div class="comment-header">
				<div class="comment-avatar">
					<!-- 프사 넣을곳 -->
					<c:if test="${cl.member_photo == null }">
						<img src="/img/profile/Default.png" alt="Profile Image">
					</c:if>
					<c:if test="${cl.member_photo != null }">
						<img src="/uimg/${cl.member_photo}" alt="Profile Image">
					</c:if>
				</div>
				<div class="comment-body">
					<div class="comment-info">
						<div class="comment-nickname">
							<!-- 닉네임 -->
							${cl.member_nickname }
						</div>
						<div class="comment-date">
							<!-- 작성일 -->
							${cl.write_date }
						</div>
					</div>
					<div class="comment-stars">
						<!-- 별점 공간 -->
						<c:forEach var="i" begin="1" end="5">			
							<c:if test="${i <= cl.reply_score}" >
								<span class="star-on">★</span>
							</c:if> 
							<c:if test="${i > cl.reply_score}" > 
								<span class="star-off">★</span> 
							</c:if> 
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="comment-content">${cl.reply_content }</div>
			<c:if test="${cl.member_email == userSession.email }">
				<div class="delete-button">
					<button onclick="redelete(${cl.reply_number },${lesson_number })" >삭제</button>
				</div>
			</c:if>
		</div>
	</c:forEach>
	<div id="loading" class="loading-spinner" style="display: none;"></div>	
</div>

</body>
</html>