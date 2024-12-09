<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<!-- css -->
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
	<!-- 폰트 -->
	<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@400;500;700&display=swap" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="./js/join.js"></script>
	
	
	
		
	
	<style>
		/* 폰트 */
		.basic_font{
			font-family: 'Gothic A1', sans-serif;
 			font-weight: 500;			 
		}
		/* 글자색 */
		.text-gray {
    		--tw-text-opacity: 1;
    		color: rgb(150 150 150 / var(--tw-text-opacity));
		}
	.text-taling-gray-800 {
    	--tw-text-opacity: 1;
    	color: rgb(66 66 66 / var(--tw-text-opacity));
	}
	.pink-text{
		--tw-text-opacity: 1;
    	color: rgb(255 16 88 / var(--tw-text-opacity));
	}
	.ring-gray-300 {
    	--tw-ring-opacity: 1;
    	--tw-ring-color: rgb(209 213 219 / var(--tw-ring-opacity));
	}
	.basic_font{
			font-family: 'Gothic A1', sans-serif;
 			font-weight: 500;			 
	}
	.purple {
    	--tw-bg-opacity: 1;
    	background-color: rgb(152 50 168 / var(--tw-bg-opacity));
	}
	
	
	</style>	
	
	<title>회원가입</title>
	
</head>

<body>

<div class="main">

	<div class="min-h-screen">
	<div class="min-h-screen -mt-[2rem]">
		<div class="sm:mx-auto sm:w-full sm:max-w-sm">
			<h2 class="mt-10 text-2xl font-medium leading-9 tracking-tight text-center text-taling-gray-800">
				회원가입하고 <br>
				다양한 서비스를 이용하세요
			</h2>
		</div>
		<form method="post" action="/member_join" id="form" onsubmit="return chk(event)" class="mt-16 sm:mx-auto sm:w-full sm:max-w-sm">
			<div class="flex flex-col gap-4">
				<div>
					<div class="flex items-baseline">
						<label class="block text-sm font-medium leading-6 text-taling-gray-800">닉네임</label>
					</div>
					<div class="mt-2">
						<input id="member_nickname" name="member_nickname" type="text" minlength="4" maxlength="12" required="required" class="block basic_font w-full rounded-md border-0 py-1.5 px-1.5 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500">
					</div>				
				</div>
				<div>
					<div class="flex items-baseline">
						<label class="block text-sm font-medium leading-6 text-taling-gray-800">이메일</label>
					</div>
					<div class="mt-2">
						<input id="member_email" name="member_email" type="email" minlength="1" maxlength="30" required="required" class="block basic_font w-full rounded-md border-0 py-1.5 px-1.5 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500">
					</div>
				</div>
				<div>
					<div class="flex items-baseline">
						<label class="block text-sm font-medium leading-6 text-taling-gray-800">비밀번호</label>											
					</div>
					<div class="mt-2">
						<input id="member_password" name="member_password" type="password" minlength="4" maxlength="16" required="required" class="block basic_font w-full rounded-md border-0 py-1.5 px-1.5 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500">											
					</div>
				</div>
				<div>
					<div class="flex items-baseline">
						<label class="block text-sm font-medium leading-6 text-taling-gray-800">비밀번호 확인</label>																	
					</div>
					<div class="mt-2">
						<input id="passwordConfirm" name="passowrdConfirm" type="password" minlength="4" maxlength="16" required="required" class="block basic_font w-full rounded-md border-0 py-1.5 px-1.5 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500">
					</div>
					<div>
						<label id="msg" class="text-sm font-medium" style="position: absolute;"></label>					
					</div>
				</div>
			</div>
			
			<div class="w-full relative mt-8">
				<button type="submit" id="submit_btn" disabled="disabled" class="relative w-full">
					<div id="submit_color" class=" text-white text-center px-2 py-1.5 rounded-md drop-shadow-sm cursor-pointer  px-4 py-2 h-10 bg-gray-300">
						다음
					</div>
				</button>
			</div>
		</form>



	</div>
	</div>
	
</div>




</body>

</html>