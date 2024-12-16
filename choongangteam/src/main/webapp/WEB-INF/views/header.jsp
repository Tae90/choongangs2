<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="top_block">
    <div class="top_menu">

        <div class="title_search">
            <a href="mainpage" class="title">
                <span class="do-hyeon-regular">메이</span>
                <span class="racing-sans-one-regular">Kit</span>
            </a>
            <div class="search" >
                <form action="keyword_search"  method="get" style="margin-top: 5px;">
                    <input type="text" placeholder="키워드를 검색하세요" id="lesson_keyword" name="lesson_keyword" class="search_word">
                    <button type="submit" style="background-color: #F6F6F6; border-style: none; cursor: pointer;">
                        <span class="material-symbols-outlined" style="color: #8c8c8c;">search</span>
                    </button>
                </form>
            </div>
        </div>





        <div class="top_right_menu">
            <a href="loginpage" class="login">로그인</a>
        </div>

 	<hr style="border-style: ridge; border-width: 1px; width: 100%; max-width: 1280px; position: absolute; bottom: 0;">

    </div>

    <div class="top_menu" style="height: 40px;">
        <div class="categories">
            <div style="display: flex; align-items: center;">
                <span class="material-symbols-outlined" style="color: black;">reorder</span><span
                    style="margin-left: 5px; margin-bottom: 4px;">카테고리</span>
            </div>
            <div class="dropdown-content">
                <div class="dropright">
                    <a style="display: flex; align-items: center;">공예<span class="material-symbols-outlined"
                            style="position: absolute; right: 0px;">chevron_right</span></a>

                    <div class="dropright-content">
                        <a href="category_page?Maincategory_number=1&Subcategory_number=101">뜨개질</a>
                        <a href="category_page?Maincategory_number=1&Subcategory_number=102">레진아트</a>
                        <a href="category_page?Maincategory_number=1&Subcategory_number=103">비즈 공예</a>
                        <a href="category_page?Maincategory_number=1&Subcategory_number=104">스탬프</a>
                        <a href="category_page?Maincategory_number=1&Subcategory_number=105">한지 공예</a>
                    </div>

                </div>
                
                
                <div class="dropright">
                    <a style="display: flex; align-items: center;">라이프 스타일<span class="material-symbols-outlined"
                            style="position: absolute; right: 0px;">chevron_right</span></a>

                    <div class="dropright-content">
                        <a href="category_page?Maincategory_number=2&Subcategory_number=201">디퓨저</a>
                        <a href="category_page?Maincategory_number=2&Subcategory_number=202">아로마 테라피</a>
                        <a href="category_page?Maincategory_number=2&Subcategory_number=203">입욕제/비누</a>
                        <a href="category_page?Maincategory_number=2&Subcategory_number=204">캔들</a>
                    </div>
                </div>


                <div class="dropright">
                    <a style="display: flex; align-items: center;">미술<span class="material-symbols-outlined"
                            style="position: absolute; right: 0px;">chevron_right</span></a>

                    <div class="dropright-content">
                        <a href="category_page?Maincategory_number=3&Subcategory_number=301">디지털 아트</a>
                        <a href="category_page?Maincategory_number=3&Subcategory_number=302">만다라 아트</a>
                        <a href="category_page?Maincategory_number=3&Subcategory_number=303">수채화</a>
                        <a href="category_page?Maincategory_number=3&Subcategory_number=304">캘리그라피</a>
                        <a href="category_page?Maincategory_number=3&Subcategory_number=305">판화</a>
                    </div>
                </div>


                <div class="dropright">
                    <a style="display: flex; align-items: center;">홈 데코<span class="material-symbols-outlined"
                            style="position: absolute; right: 0px;">chevron_right</span></a>

                    <div class="dropright-content">
                        <a href="category_page?Maincategory_number=4&Subcategory_number=401">업사이클링</a>
                        <a href="category_page?Maincategory_number=4&Subcategory_number=402">DIY 가구</a>
                        <a href="category_page?Maincategory_number=4&Subcategory_number=403">DIY 홈데코</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


</header>




  <!-- 크기가 작아지면 하단에 생기는 메뉴 -->
  <div class="bottom_menu">
    <a href="mainpage" class="item">
        <span class="material-symbols-outlined bottom-icon"> home</span>
        <span style=" font-size: 14px;">홈</span>
    </a>

<!--     <a href="" class="item">
        <span class="material-symbols-outlined bottom-icon">reorder</span>
        <span style=" font-size: 14px;">카테고리</span>
    </a> -->
<c:choose>
    <c:when test="${not empty sessionScope.userSession}">
        <a href="favoritelist" class="item">
            <span class="material-symbols-outlined bottom-icon">favorite</span>
            <span style="font-size: 14px;">찜</span>
        </a>
    </c:when>
    <c:otherwise>
        <a href="loginpage" class="item">
            <span class="material-symbols-outlined bottom-icon">favorite</span>
            <span style="font-size: 14px;">찜</span>
        </a>
    </c:otherwise>
</c:choose>



    <c:choose>
    <c:when test="${not empty sessionScope.userSession}">
        <a href="myclass" class="item">
            <span class="material-symbols-outlined bottom-icon">school</span>
            <span style="font-size: 14px;">마이클래스</span>
        </a>
    </c:when>
    <c:otherwise>
        <a href="loginpage" class="item">
            <span class="material-symbols-outlined bottom-icon">school</span>
            <span style="font-size: 14px;">마이클래스</span>
        </a>
    </c:otherwise>
</c:choose>



<c:choose>
    <c:when test="${not empty sessionScope.userSession}">
        <a href="mypage" class="item">
            <span class="material-symbols-outlined bottom-icon">account_circle</span>
            <span style="font-size: 14px;">내 정보</span>
        </a>
    </c:when>
    <c:otherwise>
        <a href="loginpage" class="item">
            <span class="material-symbols-outlined bottom-icon">account_circle</span>
            <span style="font-size: 14px;">내 정보</span>
        </a>
    </c:otherwise>
</c:choose>
</div>