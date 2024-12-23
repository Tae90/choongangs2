<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@400;500;700&display=swap" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<script src="./js/login.js"></script>
	
	
		
	<style>
	.text-taling-gray-800 {
    	--tw-text-opacity: 1;
    	color: rgb(66 66 66 / var(--tw-text-opacity));
	}
	.purple-text{
		--tw-text-opacity: 1;
    	color: rgb(152 50 168 / var(--tw-text-opacity));
	}
	.ring-gray-300 {
    	--tw-ring-opacity: 1;
    	--tw-ring-color: rgb(209 213 219 / var(--tw-ring-opacity));
	}
	.basic_font{
			font-family: 'Gothic A1', sans-serif;
 			font-weight: 500;			 
	}
	.pink {
    	--tw-bg-opacity: 1;
    	background-color: rgb(255 16 88 / var(--tw-bg-opacity));
	}
	.find_pass{
		@apply  font-medium text-taling-gray-800 basic_font;
	}
	.find_pass:hover{
		color:#9832a8;
	}
	.purple {
    	--tw-bg-opacity: 1;
    	background-color: rgb(152 50 168 / var(--tw-bg-opacity));
	}
	</style>

	<title>이메일로 로그인</title>

</head>

<body>

<div class="main">

	<div class="min-h-screen">
		<div class="min-h-screen -mt-[2rem]">
			<div class="min-h-screen flex flex-1 flex-col justify-center px-6 py-16 lg:px-8 lg:py-32 max-w-7xl mx-auto"> 
				<div class="sm:mx-auto sm:w-full sm:max-w-sm">
					<h2 class="mt-10 text-2xl font-medium leading-9 tracking-tight text-center text-taling-gray-800 basic_font">
					이메일로 간편하게 로그인하고
					<br>
					다양한 서비스를 이용해보세요
					</h2>
				</div>
				<div class="mt-16 sm:mx-auto sm:w-full sm:max-w-sm">
					<div class="flex flex-col gap-4">
						<!-- 이메일 로그인 폼 -->
						<form id="form" name="form" onsubmit="return member_check(event)" class="space-y-6" action="email_login"  method="post">
							<div>
								<label class="block text-sm font-medium leading-6 text-taling-gray-800 basic_font">이메일 주소</label>
								<div class="mt-2">
									<input id="member_email" name="member_email" autocomplete="email" required="required" type="email" class="block basic_font w-full rounded-md border-0 py-1.5 px-1.5 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500">
								</div>
							</div>
							<div>
								<div class="flex items-center justify-between">
									<label class="block text-sm font-medium leading-6 text-taling-gray-800 basic_font">비밀번호</label>
									<div class="text-sm"><a href="/find_pass" class="find_pass">비밀번호 찾기</a></div>
								</div>
								<div class="mt-2">
									<input id="member_password" name="member_password" type="password" required="required" class="block w-full rounded-md border-0 py-1.5 px-1.5 text-taling-gray-800 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-taling-gray-800 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 focus:outline-none focus:ring-purple-500">
								</div>
								<div class="mt-2">
									<label id="msg" class="text-sm font-medium""></label>					
								</div>
							</div>
														
							
							<div>
								<!-- 로그인 정보 전송할 서브밋 버튼 -->								
								<button type="submit" class="relative w-full">
									<div class=" text-white text-center px-2 py-1.5 rounded-md drop-shadow-sm cursor-pointer purple px-4 py-2 h-10">
									로그인</div>
								</button>
							</div>																			
							<p class="mt-10 text-sm text-center text-taling-gray-800">아직 회원이 아니시라면,
							<!-- 회원가입 페이지로 넘어가는 링크 -->
							<a href="join" class="font-semibold leading-6 purple-text basic_font"> 회원가입 </a>
							해보세요</p>
						</form>
					</div>
					<div>
					</div>
				</div>
			</div>       
		</div>
	</div>
</div>
</body>

</html>