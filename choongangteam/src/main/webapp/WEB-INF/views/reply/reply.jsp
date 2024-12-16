<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>

	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
	
	
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
	
	
	
	
</style>



<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:if test="${userSession.email != null}">
<div id="reply_insertSection">
	<div class="mt-4">
		<div class="sm:mx-auto sm:w-full">
		
		
<!-- 		<form method="post" action="/reply_insert" id="form" name="form" onsubmit="replychk(event)" class=" sm:mx-auto sm:w-full"> -->
		<form method="post" action="/reply_insert" id="form" name="form" class=" sm:mx-auto sm:w-full">
			<input type="hidden" name="member_email" value="${userSession.email }">
			<!-- 게시판 번호도 히든으로 추가해야함 -->
			<input type="hidden" name="lesson_number" value="${lesson_number}">		
			
			<fieldset class="block text-left text-sm font-medium leading-6 w-full">
				<span class=" text-gray ">별점을 선택해주세요</span>
				<input type="radio" name="reply_score" value="5" id="rate1"><label for="rate1">★</label>
				<input type="radio" name="reply_score" value="4" id="rate2"><label for="rate2">★</label>
				<input type="radio" name="reply_score" value="3" id="rate3"><label for="rate3">★</label>
				<input type="radio" name="reply_score" value="2" id="rate4"><label for="rate4">★</label>
				<input type="radio" name="reply_score" value="1" id="rate5"><label for="rate5">★</label>
			</fieldset>			

			<div class="mt-2 flex items-center gap-2">
				<textarea name="reply_content" class="resize-none h-20 py-1.5 px-1.5 block basic_font rounded-md border-0 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500" style="flex-grow: 1;"></textarea>
				<button type="submit"  class="purple text-white h-20 rounded-md flex items-center justify-center" style="width: 100px;">
					<span class="inline-block text-center">등록</span>
				</button>
			</div>
		</form>		
		
		</div>
	</div>
</div>
</c:if>
		




</body>
</html>