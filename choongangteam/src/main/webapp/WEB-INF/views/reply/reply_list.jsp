<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>

	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="./css/font.css"></script>
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
	<script src="./js/reply.js"></script>
	
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
	
	
</style>



<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 댓글 전체 컨테이너 -->
<div id="reply_listSection" class="flex flex-col gap-4">
	<div>
		<h2 class="text-lg font-semibold">수강생 리뷰</h2>
	</div>
	
	<!-- 댓글 -->
	<c:forEach var="cl" items="${clist }">
	<div class="flex flex-col gap-4 text-sm ">
		<div id="rlist" class="border border-taling-gray-200 p-4 md:px-6 rounded-lg">
		
			<div class="flex gap-3">
				<div class="shrink-0">
					<!-- 프사 넣을곳 -->
					<img src="/static/img/profile/Default.png">
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
				<div class="flex justify-end mt-4 text-xs text-gray hover:text-taling-gray-800 gap-3">
					<button>삭제</button>
				</div>
			</c:if>
		</div>
	</div>
	</c:forEach>
</div>
			
</body>
</html>