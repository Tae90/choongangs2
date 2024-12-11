<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Racing+Sans+One&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@100..900&display=swap"
	rel="stylesheet">

<link href="/css/icons.css" rel="stylesheet">
<link href="/css/font.css" rel="stylesheet">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/header_login.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/categorypage.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
.loading-spinner {
    position: fixed;
    bottom: 200px;
    left: 50%;
    transform: translateX(-50%);
    display: none;
    border: 4px solid rgba(0, 0, 0, 0.1);
    border-radius: 50%;
    border-top-color: #9832a8;
    width: 40px;
    height: 40px;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    from {
        transform: translateX(-50%) rotate(0deg);
    }
    to {
        transform: translateX(-50%) rotate(360deg);
    }
}
</style>

<title>Insert title here</title>

<script>
/* 무한 스크롤 스크립트 */
let page = 4;
let loading = false;
let hasMore = true;
let loadedLessonIds = [];

function loadMoreLessons() {
    if (loading || !hasMore) return;
    loading = true;
    
    $('.loading-spinner').show();
    
    console.log("loadMoreLessons method in");
    console.log("page", page);
    console.log("subcate_num:", ${subcate_num});
    
    $.ajax({
        url: 'loadMoreLessons',
        method: 'GET',
        data: {
           "page": page,
           "subcategory_number": ${subcate_num},
           "order": "${order}",
           "loadedLessonIds": loadedLessonIds
        },
        success: function(response) {
            if (response && response.length > 0) {
                // 데이터가 있을 경우에만 1~2초 지연 후 표시
                setTimeout(function() {
                    response.forEach(function(lesson) {
                        let lessonHtml = 
                            '<div class="flex-item">' +
                                '<a href="paymentdetail?lesson_number=' + lesson.lesson_number + '" class="class_link"  target="_blank">' +
                                    '<div class="image-container">' +
                                        '<img src="' + lesson.lesson_thumbnail + '" style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">' +
                                    '</div>' +
                                    '<div class="text-container" style="font-size: 14px;">' +
                                        lesson.lesson_title +
                                    '</div>' +
                                    '<div class="text-container" style="font-size: 14px; font-weight: 600;">' +
                                        lesson.lesson_price + '원' +
                                    '</div>' +
                                    '<div class="text-container" style="font-size: 12px;">' +
                                        '<span style="color: gold; font-size: 16px; text-align: center;">★</span>&nbsp;' + 
                                        lesson.avg_reply_score + '&nbsp;(' + lesson.reply_count + ')' +
                                    '</div>' +
                                '</a>' +
                            '</div>';
                        $('#lessonContainer').append(lessonHtml);
                        loadedLessonIds.push(lesson.lesson_number);
                    });
                    page++;
                    loading = false;
                    $('.loading-spinner').hide();
                }, Math.random() * 1000 + 1000);
            } else {
                // 데이터가 없을 경우 즉시 처리
                hasMore = false;
                loading = false;
                $('.loading-spinner').hide();
            }
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
            loading = false;
            $('.loading-spinner').hide();
        }
    });
}

//초기 로딩 시 이미 표시된 강의의 ID를 저장
$(document).ready(function() {
    $('.flex-item').each(function() {
        let lessonId = $(this).data('lesson-id');
        if (lessonId) {
            loadedLessonIds.push(lessonId);
        }
    });
});

// 스크롤 이벤트 디바운싱 (변경 없음)
let scrollTimeout;
$(window).scroll(function() {
    clearTimeout(scrollTimeout);
    scrollTimeout = setTimeout(function() {
        if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
            if (!loading && hasMore) {
                loadMoreLessons();
            }
        }
    }, 100);
});


/* 추천순, 리뷰순, 최신순을 누를때 그 페이지로 갔음을 알려주는 함수 */
 
 document.addEventListener('DOMContentLoaded', function() {
  const currentURL = window.location.href;
  const links = document.querySelectorAll('.review a');

  links.forEach(link => {
    if (link.href === currentURL) {
      link.classList.add('active');
    }
  });
});

</script>


</head>
<body>

	<!-- 헤더 부분 -->
	<!-- 세션값이 있으면 header_login 없으면 header를 불러온다. -->
	<c:choose>
		<c:when test="${not empty sessionScope.userSession}">
			<jsp:include page="${path}/WEB-INF/views/header_login.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<jsp:include page="${path}/WEB-INF/views/header.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>
	
	

	<div style="margin: auto; max-width: 1280px;">

		<div class="second_cate">

			<c:forEach var="subcategory" items="${subcate}">
				<a
					href="category_page?Maincategory_number=${subcategory.maincategory_number}&Subcategory_number=${subcategory.subcategory_number}"
					class="${subcategory.subcategory_number == selectedSubcategory ? 'selected' : ''}">
					<span>${subcategory.subcategory_name}</span>
				</a>
			</c:forEach>

		</div>


		<div class="review">
			<a
				href="category_page?Maincategory_number=${subcategory.maincategory_number}&Subcategory_number=${subcategory.subcategory_number}&order=favorite"
				class="${param.order == 'favorite' ? 'active' : ''}">추천순</a>&nbsp; <a
				href="category_page?Maincategory_number=${subcategory.maincategory_number}&Subcategory_number=${subcategory.subcategory_number}&order=review"
				class="${param.order == 'review' ? 'active' : ''}">리뷰순</a>&nbsp; <a
				href="category_page?Maincategory_number=${subcategory.maincategory_number}&Subcategory_number=${subcategory.subcategory_number}"
				class="${empty param.order ? 'active' : ''}">최신순</a>
		</div>
		<br>


		<div class="flex-container" id="lessonContainer"
			style="margin-top: 100px;">



			<c:forEach var="lesson" items="${cateclass }" begin="0" end="11">
				<div class="flex-item" data-lesson-id="${lesson.lesson_number}">
					<a href="paymentdetail?lesson_number=${lesson.lesson_number}" class="class_link" target="_blank">
						<div class="image-container">
							<img src="'${lesson.lesson_thumbnail }'"
								style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
						</div>
						<div class="text-container" style="font-size: 14px;">
							${lesson.lesson_title }</div>
						<div class="text-container"
							style="font-size: 14px; font-weight: 600;">
							${lesson.lesson_price }원</div>
						<div class="text-container" style="font-size: 12px;">
							<span style="color: gold; font-size: 16px; text-align: center;">★</span>&nbsp;${lesson.avg_reply_score }&nbsp;(${lesson.reply_count })
						</div>
					</a>
				</div>
			</c:forEach>

		</div>




		<div id="loading" class="loading-spinner" style="display: none;"></div>

	</div>


	<!-- 이용약관 footer -->
	<jsp:include page="${path}/WEB-INF/views/footer.jsp"></jsp:include>


</body>
</html>

