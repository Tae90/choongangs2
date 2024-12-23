/**
 * 
 */

let resizeTimeout;
$(document).ready(function() {

	//오늘 날짜 구하기
	const today = new Date();
	const year = today.getFullYear();
	const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다
	const day = String(today.getDate()).padStart(2, '0'); // 2자리로 맞추기

	const formattedDate = year + '-' + month + '-' + day; // YYYY-MM-DD 형식으로 만듬

	//오늘 이후 날짜만 설정할 수 있오도록 구현
	$('#start_date').attr('min', formattedDate);

	// 첫 번째 select의 값이 변경될 때마다 실행
	$('#maincategory_number').change(function() {
		$('#subcategory_number').empty();
		selectCategory($(this).val());
	});

	//썸네일 이미지 비율 유효성 검사 
	document.getElementById('thumnail').addEventListener('change', function(event) {
		const imageFile = event.target.files[0];
		if (!imageFile) {
			return;
		}

		// 이미지 로드 후 비율 계산
		const img = new Image();
		img.onload = function() {
			const width = img.width;
			const height = img.height;

			// 16:9 비율을 계산 (가로 / 세로)
			const aspectRatio = width / height;
			const targetAspectRatio = 16 / 9;

			// 비율이 16:9보다 작은지 확인
			if (aspectRatio < targetAspectRatio) {
				// 16:9 비율보다 작을 때 업로드 거부
				document.getElementById('errorMessage').textContent = '이미지의 비율은 16:9 이상이어야 합니다. 다른 이미지를 선택해주세요.';
				document.getElementById('errorMessage').style.color = '#FF0000'; /* 여기서 색상을 빨간색으로 변경 */
				document.getElementById('errorMessage').style.fontSize = '18px'; // 글자 크기 18px
				document.getElementById('previewImage').style.display = 'none'; // 이미지 미리보기 숨김
				// 파일 입력 초기화 (파일 선택을 초기화하여 다시 선택할 수 있도록)
				document.getElementById('imageInput').value = '';
			} else {
				// 16:9 비율 이상일 때 오류 메시지 제거
				document.getElementById('errorMessage').textContent = '';
				document.getElementById('previewImage').style.display = 'block'; // 이미지 미리보기 표시
				document.getElementById('previewImage').src = img.src; // 미리보기 이미지 설정
			}
		};

		// 이미지 파일을 읽어 img 태그로 설정
		img.src = URL.createObjectURL(imageFile);

	});

	const inputField = document.getElementById('subject');
	const charCount = document.getElementById('charCount');

	// 실시간으로 글자 수를 표시하는 함수
	inputField.addEventListener('input', function() {
		const currentLength = inputField.value.length;
		charCount.textContent = currentLength + '/30'; // 현재 글자 수 / 최대 글자 수 표시
	});

	//실시간으로 모집인원에 숫자 이외의 값이 들어왔는지 체크하는 함수
	$('#applyNum').on('input', function() {
		var pattern = new RegExp(/^[0-9]+$/);
		if (!pattern.test($(this).val())) {
			//아무것도 안썻을때는 오류문자 안뜨게 설정
			if ($(this).val() === '') $('#applyNumError').hide();
			else {
				$('#applyNumError').html('<p style="color: red; font-weight: 400;font-size:15px;font-style: normal;">숫자만 입력해주세요</p>');
				$('#applyNumError').show();
			}
		} else if ($(this).val() > 6) { //최대 가용 인원을 6으로 가정하고 6을 넘긴 숫자는 6으로 나타나게 만듬
			$('#applyNumError').hide();
			$(this).val(6);
		} else {
			$('#applyNumError').hide();
		}
	});

	//실시간으로 가격에 숫자 이외의 값이 들어왔는지 체크하는 함수
	$('#price').on('input', function() {
		var pattern = new RegExp(/^[0-9]+$/);
		if (!pattern.test($(this).val())) {
			//아무것도 안썻을때는 오류문자 안뜨게 설정
			if ($(this).val() === '') $('#priceError').hide();
			else {
				$('#priceError').html('<p style="color: red; font-weight: 400;font-size:15px;font-style: normal;">숫자만 입력해주세요</p>');
				$('#priceError').show();
			}
		} else {
			$('#priceError').hide();
		}
	});

	//실시간으로 키워드값 체크하는 함수
	$('#lesson_keyword_insert').on('input', function() {
		let tempt = $.trim($(this).val());
		if (!(tempt == "")) {
			let cwa = tempt.split(",");
			if (cwa.length > 5) {
				$('#classKeywordError').html('<p style="color: red; font-weight: 400;font-size:15px;font-style: normal;">키워드가 5개 초과입니다.</p>');
				$('#classKeywordError').show();
			} else {
				$('#classKeywordError').hide();
				for (let i = 0; i < cwa.length; i++) {
					cwa[i] = $.trim(cwa[i]);
					cwa[i] = cwa[i].replace(" ", "_");
					if (cwa[i] == "") {
						$('#classKeywordError').html('<p style="color: red; font-weight: 400;font-size:15px;font-style: normal;">비어있는 키워드가 있습니다.</p>');
						$('#classKeywordError').show();
					}
				}
			}
		} else {
			$('#classKeywordError').hide();
		}
	});
});
/**첫 카테고리를 선택하여 하위 카테고리를 생성하는 함수 */
function selectCategory(value) {
	var selectedValue = value; // 첫 번째 select에서 선택된 
	// 첫 번째 select의 값에 따라서 두 번째 select의 옵션을 동적으로 추가
	if (selectedValue === '') {
		// 두 번째 select의 기존 옵션을 지움
		$('#subcategory_number').empty();
		$('#subcategory_number').append('<option value="">1차 카테고리를 선택해주세요</option>');
	} else if (selectedValue === '1') { //공예 카테고리 하위 목록
		$('#subcategory_number').append('<option value="">카테고리를 선택해주세요</option>');
		$('#subcategory_number').append('<option value="101">뜨개질</option>');
		$('#subcategory_number').append('<option value="102">레진아트</option>');
		$('#subcategory_number').append('<option value="103">비즈공예</option>');
		$('#subcategory_number').append('<option value="104">나무 공예</option>');
		$('#subcategory_number').append('<option value="105">종이 공예</option>');
	} else if (selectedValue === '3') { //미술 카테고리 하위 목록
		$('#subcategory_number').append('<option value="">카테고리를 선택해주세요</option>');
		$('#subcategory_number').append('<option value="301">디지털아트</option>');
		$('#subcategory_number').append('<option value="302">만다라아트</option>');
		$('#subcategory_number').append('<option value="303">수재화</option>');
		$('#subcategory_number').append('<option value="304">캘리그라피</option>');
		$('#subcategory_number').append('<option value="305">판화</option>');
	} else if (selectedValue === '4') { //홈데코 카테고리 하위 목록
		$('#subcategory_number').append('<option value="">카테고리를 선택해주세요</option>');
		$('#subcategory_number').append('<option value="401">업사이클링</option>');
		$('#subcategory_number').append('<option value="402">DIY가구</option>');
		$('#subcategory_number').append('<option value="403">DIY홈데코</option>');
	} else if (selectedValue === '2') {//라이브스타일 카테고리 하위 목록
		$('#subcategory_number').append('<option value="">카테고리를 선택해주세요</option>');
		$('#subcategory_number').append('<option value="201">디퓨저</option>');
		$('#subcategory_number').append('<option value="202">아로마테라피</option>');
		$('#subcategory_number').append('<option value="203">입욕제/비누</option>');
		$('#subcategory_number').append('<option value="204">캔들</option>');
	}
}

//이미지 input태그의 id값구별을 위한 변수
var cnt = 1;
//이미지 추가 input+취소버튼 추가하는 함수
function addImageInput() {
	//cnt로 id값을 구분함 
	var input = '<div class="image-input-container"> <input type="file" style="width: calc(100% - 100px);float: left;border: none;" name="classImg" id="classImg' + cnt + '" accept="image/*" multiple onchange="previewImages(event,this)"> <button type="button" style="aspect-ratio: 1; height: 100%;float: right;" onclick="removeImageInput(this)">취소</button></div>';


	// div[class="image-input-container"]가 하나라도 있으면 마지막 div 다음에 추가
	if ($('#mulimage div[class="image-input-container"]').length > 0) {
		$('#mulimage div[class="image-input-container"]:last').after(input);
	} else {
		// 없다면 버튼 아래에 추가
		$('#mulimage button:last').after(input);
	}

	cnt++;
}



/** 이미지 미리보기 함수*/
function previewImages(event, inputElement) {
	var files = event.target.files;// 선택된 파일들
	var previewContainer = $('#editableDiv');
	var selection = window.getSelection();  // 현재 선택 영역 (커서 위치)
	var inputId = $(inputElement).attr('id');  // 현재 input의 id를 가져옴

	// 해당 input에 맞는 이미지만 지우기 (input의 id와 일치하는 이미지만 삭제)
	previewContainer.find('img[data-input-id="' + inputId + '"]').remove(); // data-input-id로 해당 input의 이미지만 제거

	// #editableDiv가 포커스 상태가 아니면 포커스 설정
	if (document.activeElement !== previewContainer[0]) {
		previewContainer.focus();  // #editableDiv에 포커스를 준다.
	}

	// selection 객체가 null이거나 유효하지 않은 경우 처리
	if (!selection || !selection.rangeCount) {
		// 커서가 없거나 selection이 null인 경우
		previewContainer.focus();  // #editableDiv에 포커스를 준다.

		var range = document.createRange();  // 새로운 range 객체 생성
		range.selectNodeContents(previewContainer[0]);  // div 전체를 선택 영역으로 설정
		range.collapse(false);  // 커서를 맨 끝으로 설정
		selection = window.getSelection();  // selection 객체 업데이트
		selection.removeAllRanges();
		selection.addRange(range);  // 새로운 range 추가
	} else {
		var range = selection.getRangeAt(0);  // 현재 선택된 텍스트 범위
	}

	// 모든 파일에 대해 반복하며 미리보기 이미지 생성
	$.each(files, function(index, file) {
		var reader = new FileReader();  // FileReader 객체 생성
		reader.onload = function(e) {
			var img = $('<img>')
				.attr('src', e.target.result)
				.attr('data-input-id', inputId)  // 각 이미지에 해당 input의 id를 data-input-id로 추가
				.css({
					'object-fit': 'cover',
					'width': '90%',
					'height': 'auto'
				});

			// 현재 커서 위치에 이미지 삽입
			range.deleteContents();  // 선택된 텍스트가 있으면 삭제
			range.insertNode(img[0]);  // 커서 위치에 이미지 삽입

			// 삽입 후 커서 위치를 이미지 뒤로 이동
			range.setStartAfter(img[0]);
			range.setEndAfter(img[0]);

			// 변경된 범위를 다시 선택
			selection.removeAllRanges();
			selection.addRange(range);
		};

		// 이미지 파일 읽기
		reader.readAsDataURL(file);  // 파일을 Data URL로 읽음
	});
}

// 이미지 input 취소 함수
function removeImageInput(button) {
	// 버튼이 속한 부모 div인 .image-input-container를 찾음
	var inputContainer = $(button).closest('.image-input-container');

	// 해당 input 태그의 id를 가져옴
	var inputId = inputContainer.find('input').attr('id');  // 부모 div 안의 input의 id 가져오기

	// #editableDiv 안에서 해당 inputId와 관련된 이미지를 찾고 삭제
	$('#editableDiv').find('img[data-input-id="' + inputId + '"]').remove();

	// 부모 div인 .image-input-container를 DOM에서 제거
	inputContainer.remove();
}

/**summit 유효성검사함수*/
function check() {

	if ($.trim($("#maincategory_number").val()) == "") {
		alert("카테고리를 선택해 주세요!");
		$("#maincategory_number").focus();
		return false;
	}

	if ($.trim($("#subcategory_number").val()) == "") {
		alert("카테고리를 선택해 주세요!");
		$("#category2").focus();
		return false;
	}

	if ($.trim($("#lesson_keyword_insert").val()) == "") {
		alert("키워드를 입력해 주세요!");
		$("#lesson_keyword_insert").val("").focus();
		return false;
	}

	/*키워드 입력값 유효성 검사*/
	let tempt = $.trim($('#lesson_keyword_insert').val());

	let RealCK = tempt.split(",");
	if (RealCK.length > 5) {
		alert("키워드가 5개 초과입니다!");
		$("#lesson_keyword_insert").focus();
		return false;
	} else {
		for (let i = 0; i < RealCK.length; i++) {
			RealCK[i] = $.trim(RealCK[i]);
			RealCK[i] = RealCK[i].replace(" ", "_");
			if (RealCK[i] == "") {
				alert("비여있는 키워드가 있습니다!");
				$("#lesson_keyword_insert").focus();
				return false;
			}
		}

		$("#lesson_keyword_insert").val(RealCK);
	}

	if ($.trim($("#subject").val()) == "") {
		alert("제목을 입력해주세요!");
		$("#subject").val("").focus();
		return false;
	}

	if ($.trim($("#start_date").val()) == "") {
		alert("날짜를 선택해 주세요!");
		$("#start_date").focus();
		return false;
	}

	if ($.trim($("#time1").val()) == "") {
		alert("시간을 선택해 주세요!");
		$("#time1").focus();
		return false;
	}

	if ($.trim($("#time2").val()) == "") {
		alert("시간을 선택해 주세요!");
		$("#time2").focus();
		return false;
	}

	if ($.trim($("#time3").val()) == "") {
		alert("시간을 선택해 주세요!");
		$("#time3").focus();
		return false;
	}

	if ($.trim($("#time4").val()) == "") {
		alert("시간을 선택해 주세요!");
		$("#time4").focus();
		return false;
	}

	if ($.trim($("#thumnail").val()) == "") {
		alert("섬네일을 선택해 주세요!");
		$("#thumnail").focus();
		return false;
	}

	var content = $('#editableDiv').html().trim();  // div 내부의 HTML을 가져오고 공백 제거

	// HTML이 비어있거나 <br> 태그만 있는 경우를 확인
	if (content === "" || content === "<br>" || content === "<div><br></div>") {
		alert("클래스 상세 내용을 입력해주세요.");
		$('#editableDiv').focus();
		return false;
	}

	$('#lesson_content').val(content);


	/*숫자만 입력받기위한 정규표현식*/
	var pattern = new RegExp(/^[0-9]+$/);
	let p = $.trim($("#price").val());

	if (p == "") {
		alert("가격을 입력 주세요!");
		$("#price").val("").focus();
		return false;
	}

	if (!pattern.test(p)) {
		alert("가격에 숫자만 입력해주세요!");
		$("#price").val("").focus();
		return false;
	}

	let a = $.trim($("#applyNum").val());

	if (a == "") {
		alert("인원수를 선택해 주세요!");
		$("#applyNum").val("").focus();
		return false;
	}

	if (!pattern.test(a)) {
		alert("모집인원수에 숫자만 입력해주세요!");
		$("#applyNum").val("").focus();
		return false;
	}
}
function checkViewportWidth() {
	var viewportWidth = document.documentElement.clientWidth; // 뷰포트의 너비
	if (viewportWidth <= 1280) {
		function adjustSelectWidth(selectElement) {
			var maxLength = 0;

			// 각 option의 텍스트 길이를 비교하여 가장 긴 텍스트의 길이를 구함
			$(selectElement).find('option').each(function() {
				var optionLength = $(this).text().length;
				if (optionLength > maxLength) {
					maxLength = optionLength;
				}
			});

			// select 박스의 너비를 가장 긴 텍스트 길이에 맞게 설정
			$(selectElement).css('width', (maxLength + 1) + 'ch'); // ch 단위는 문자의 너비 기준
		}

		// 모든 select 요소에 대해 크기 조정
		$('select').each(function() {
			adjustSelectWidth(this);
		});

		// select 요소에서 선택된 옵션이 변경될 때마다 크기 조정
		$('select').on('change', function() {
			adjustSelectWidth(this);
		});
	} else {
		// viewportWidth가 1280을 초과할 때 select의 크기를 원래대로 되돌림
		$('select').each(function() {
			$(this).css('width', ''); // 기본 width 값으로 리셋
		});
	}
}

// resize 이벤트에 디바운싱 적용
window.addEventListener('resize', function() {
	clearTimeout(resizeTimeout);  // 이전 타이머를 취소
	resizeTimeout = setTimeout(checkViewportWidth, 100); // 200ms 후에 함수 실행
});