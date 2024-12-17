<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>

	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<!-- 	sweetalert 사용 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
	<script src="/js/reply.js"></script>
	
	
<style >

	.purple {
    	--tw-bg-opacity: 1;
    	background-color: rgb(152 50 168 / var(--tw-bg-opacity));
	}
	.text-gray {
    		--tw-text-opacity: 1;
    		color: rgb(150 150 150 / var(--tw-text-opacity));
	}


	#form fieldset{
    	display: inline-block;
    	direction: rtl;
    	border:0;
	}
	#form fieldset legend{
    	text-align: right;
	}
	#form input[type=radio]{
    	display: none;
	}
	#form label{
     	font-size: 1.5em; 
    	color: transparent;
    	text-shadow: 0 0 0 #f0f0f0;
	}
	#form label:hover{
    	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#form label:hover ~ label{
    	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#form input[type=radio]:checked ~ label{
    	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}


	
	
	/* 별 on off */
	.star_off {
		font-size: 1.5em; 
    	color: transparent;
    	text-shadow: 0 0 0 #f0f0f0;
	}
	.star_on {
		font-size: 1.5em; 
    	color: transparent;
		text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	
	/* 	로딩표시 */
	.loading-spinner {
     	position: absolute;
    	bottom: -50px;
    	left: 50%;
    	transform: translateX(-50%);
    	display: none;
	    border: 4px solid rgba(0, 0, 0, 0.1);
    	border-radius: 50%;
    	border-top-color: #9832a8;
    	width: 40px;
    	height: 40px;
    	animation: spin 1s ease-in-out infinite;
	}

	@keyframes spin {
    	to { transform: translateX(-50%) rotate(360deg); }
	}
	
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 댓글 전체 컨테이너 -->
<div id="reply_listSection" class="flex flex-col gap-4" style="position: relative;">
	<input type="hidden" name="lesson_number" value="${lesson_number }">
	<input type="hidden" name="userEmail" value="${userSession.email }">
	<div>
		<h2 class="text-lg font-semibold">수강생 리뷰</h2>
	</div>
	
	<!-- 댓글 -->
	<c:forEach var="cl" items="${clist }" begin="0" end="4">
	<div id="${cl.reply_number }" class="flex flex-col gap-4 text-sm ">
		<div id="rlist" class="border border-taling-gray-200 p-4 md:px-6 rounded-lg">
		
			<div class="flex gap-3">
				<div class="shrink-0">
					<!-- 프사 넣을곳 -->
					<c:if test="${cl.member_photo == null }">
						<img src="/img/profile/Default.png"						
     						alt="Profile Image"  style="border-radius: 50%; width: 56px; height: 56px;">					
					
					</c:if>
					<c:if test="${cl.member_photo != null }">
						<img src="/uimg/${cl.member_photo}"
     						alt="Profile Image"  style="border-radius: 50%; width: 56px; height: 56px;">
     				</c:if>					
				</div>
				<div class="w-full">
					<div>
						<div class="flex justify-between">
							<div class="flex space-x-1 gap-1 ml-1.5">
								<!-- 닉네임 -->
								${cl.member_nickname }
							</div>
							<div class="flex items-center gap-2">
								<!-- 작성일 -->
								${cl.write_date }
							</div>
						</div>
						<div class="flex items-center mt-1">
							<!-- 별점 공간 -->
							<c:forEach var="i" begin="1" end="5">			
  								<c:if test="${i <= cl.reply_score}" >
 									<span class="star_on">★</span>
 								</c:if> 
 								<c:if test="${i > cl.reply_score}" > 
 									<span class="star_off">★</span> 
 								</c:if> 
 							</c:forEach>
						</div>
					</div>				
				</div>			
			</div>
			<div class="flex">
				<div class="mt-4 leading-relaxed whitespace-pre-wrap break-all text-sm sm:text-base">${cl.reply_content }</div>			
			</div>
			<c:if test="${cl.member_email == userSession.email }">
				<div onclick="redelete(${cl.reply_number },${lesson_number })" class="flex justify-end mt-4 text-xs text-gray hover:text-taling-gray-800 gap-3">
					<button >삭제</button>
				</div>
			</c:if>
		</div>
	</div>
	</c:forEach>
		<div id="loading" class="loading-spinner" style="display: none;"></div>	
</div>
			
</body>
</html>