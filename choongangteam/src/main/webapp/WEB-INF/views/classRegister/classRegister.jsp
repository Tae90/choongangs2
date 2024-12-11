<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>클래스 등록</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Racing+Sans+One&display=swap"rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap" rel="stylesheet">
<link href="/css/write.css" rel="stylesheet">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/icons.css" rel="stylesheet">
<script src="/js/write.js"></script>
<body>
	<div class="container">
		<!-- 탑 메뉴 -->
		<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
		<form  id="Form" action="writing" method="post" enctype="multipart/form-data" onsubmit="return check()">
		
		<!-- 제출 버튼 -->
		<div class="submitButtonDiv">
			<input type="submit" class="SummitButton" value="제출하기">
		</div>
		<!-- 수평선 -->
		<hr class="classHr">
		<!-- 수평선 아래 전체 div -->
		<div class="inputClass">
			<!-- 입력값 객체들을 담는 div -->
			<div class="inputContent">
				<!-- 입력값 객체 div -->
				<div class="contentSction">
					<!-- label div -->
					<div class="nameSection">
						<label class="classLabel" for="category">카테고리</label>
					</div>
					<!-- input div -->
					<div class="writeSection">
						<select id="maincategory_number" name="maincategory_number">
							<option value="" selected>카테고리를 선택해주세요</option>
							<option value="1">공예</option>
							<option value="2">라이프스타일</option>
							<option value="3">미술</option>
							<option value="4">홈데코</option>
						</select> <select id="subcategory_number" name="subcategory_number">
							<!-- 기본 옵션, 첫 번째 select의 값을 선택할 때마다 변경됩니다. -->
							<!-- 맨 처음에는 카테고리를 선택해주세요만 보이게 구현 -->
							<option value="">1차 카테고리를 선택해주세요</option>
						</select>
					</div>
				</div>
				<!-- 입력값 객체 div -->
				<div class="contentSction">
					<!-- label div -->
					<div class="nameSection">
						<label class="classLabel" for="classKeyword">클래스 키워드</label>
					</div>
					<!-- input div -->
					<div class="writeSection">
						<!-- 클래스 사이에 ,표를 넣어서 구분할 수 있도록 구현 -->
						<input type="text" id="lesson_keyword_insert" name="lesson_keyword_insert" placeholder="클래스 키워드를 입력하세요">
						<br>
						<p class="alertP">키워드를 추가할 시에 ','를 넣어서 구분해 주세요.최대 5개 입력 가능합니다.</p>
						<div id="classKeywordError" class="classKeywordError"><br></div>
					</div>
				</div>
				<!-- 입력값 객체 div -->
				<div class="contentSction">
					<!-- label div -->
					<div class="nameSection">
						<label class="classLabel" for="subject">제목</label>
					</div>
					<!-- input div -->
					<div class="writeSection">
						<input type="text" maxlength="30" id="subject" name="lesson_title" placeholder="제목을 입력하세요">
						<span id="charCount" class="char-count">0/30</span>
					</div>
				</div>
				
				<!-- 클래스 날짜 설정 -->
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="classDate">클래스 날짜</label>
					</div>
					<div class="writeSection">
						<input style="width: auto" type="date" id="start_date" name="start_date">
					</div>
				</div>
				<!-- 클래스 시간 설정 -->
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="classTime">클래스 시작시간</label>
					</div>
					<div class="writeSection">
						<select id="time1" name="start_hour">
							<option value="">시간을 선택해주세요</option>
							<c:forEach var="i" begin="0" end="23">
								<option value="${i}">${i}</option>
							</c:forEach>
						</select> 
						<select id="time2" name="start_min">
							<option value="">시간을 선택해주세요</option>
							<option value="0">0</option>
							<option value="30">30</option>
						</select>
					</div>
				</div>
				<!-- 클래스 수업시간 설정 -->
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="classTime">클래스 수업시간</label>
					</div>
					<div class="writeSection">
						<select id="time3" name="class_hour">
							<option value="">시간을 선택해주세요</option>
							<c:forEach var="i" begin="0" end="23">
								<option value="${i}">${i}</option>
							</c:forEach>
						</select> 
						<select id="time4" name="class_min">
							<option value="">시간을 선택해주세요</option>
							<option value="0">0</option>
							<option value="30">30</option>
						</select>
					</div>
				</div>
				
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="thumnail">섬네일 이미지</label>
					</div>
					<div class="writeSection">
						<input type="file" name="thumnail" id="thumnail" accept="image/*" />
						<br>
						<div id="errorMessage" class="error-message"></div>
						<br> 
						<img id="previewImage" class="previewImage" style="display: none;" alt="이미지 미리보기" />
					</div>
				</div>
			
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="thumnail">클래스 설정</label>
					</div>
					<div class="writeSection" id="mulimage">
						<button type="button" class="mulImgButton" onclick="addImageInput()">이미지 추가</button>
						<div class="image-input-container"> 
							<input type="file" style=" width: calc(100% - 100px);float: left;border: none;" name="classImg" id="classImg0" accept="image/*" multiple onchange="previewImages(event,this)"> 
							<button type="button" style=" aspect-ratio: 1; height: 100%; float: right;" onclick="removeImageInput(this)">취소</button>				
    					</div>
    					<!-- contenteditable을 설정하므로서 내부에 요소들을 사용자의 의도대로 변경이 가능 -->
    					<div id="editableDiv" class="editable-container"  contenteditable="true"></div>
    					<input type="hidden" name="lesson_content" id="lesson_content">
					</div>
				</div>
				
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="price">금액</label>
					</div>
					<div class="writeSection">
						<!-- 금액 길이가 길 필요가 없어서width: auto로 줌  -->
						<input type="text" style="width: auto" id="price" name="lesson_price" placeholder="금액을 입력하세요">
						<div id="priceError" class="priceError"></div>
					</div>
				</div>
				<div class="contentSction">
					<div class="nameSection">
						<label class="classLabel" for="applyNum">인원수</label>
					</div>
					<div class="writeSection">
						<!-- 인원수 길이가 길 필요가 없어서width: auto로 줌  -->
						<input type="text" style="width: auto" id="applyNum" name="lesson_apply" placeholder="인원수를 입력하세요">
						<br>
						<p class="alertP">모집 인원수는 최대 6명으로 제한됩니다.</p>
						<div id="applyNumError" class="applyNumError"><br></div>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>
</body>
</html>