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
	<script src="./js/login.js"></script>
	
	
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
		.purple {
    	--tw-bg-opacity: 1;
    	background-color: rgb(152 50 168 / var(--tw-bg-opacity));
		}
	
	</style>	
	
	<title>비밀번호 찾기</title>

</head>

<body>

<div class="main">
	
	<div class="min-h-screen">
		<div class="min-h-screen -mt-[2rem]">
			<div class="min-h-screen flex flex-1 flex-col justify-center px-6 py-16 lg:px-8 lg:py-32 max-w-7xl mx-auto">
				<div class="sm:mx-auto sm:w-full sm:max-w-sm">
					<h2 class="mt-10 text-2xl font-medium leading-9 tracking-tight text-center text-taling-gray-800">입력하신 이메일로<br>비밀번호를 전송하였습니다.</h2>
				</div>
			
				<div class="m-16 sm:mx-auto sm:w-full sm:max-w-sm">
					<a href="mainpage">
						<button type="submit" class="relative w-full">
							<div class=" text-white text-center px-2 py-1.5 rounded-md drop-shadow-sm cursor-pointer purple px-4 py-2 h-10">
								확인
							</div>
						</button>
					</a>
				</div>
			</div>
			
				
		</div>	
	</div>
	
</div>

</body>

</html>