<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- description -->
<meta charset="UTF-8" />
<meta name="keywords" content="Where is my room" />
<meta name="description" content="짧게 머무는 방 찾기 서비스" />
<meta name="init" content="Han seunghoon" />
<meta name="author" content="Hyndai IT&E KTH, BEJ, HMS, HSH" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>짧게 머물자, 구해줘 룸즈!</title>
<!-- fonts -->
<link
   href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap"
   rel="stylesheet" />
<!-- styles -->
<link rel="stylesheet" href="${contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/grid.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/dropdown.css" />
<!-- 해당 페이지의 css 적용! style 지우고 해당 css 입력! -->
<link rel="stylesheet" href="${contextPath}/resources/css/map.css" />

<!-- favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/img/favicon.ico"
   type="image/x-icon" />
<link rel="icon" href="${contextPath}/resources/img/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css"/>

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://pagination.js.org/dist/2.1.5/pagination.min.js"></script>
<script type="text/javascript" src="https://unpkg.com/default-passive-events"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services,clusterer"></script>
<script src="${contextPath}/resources/js/map.js" ></script>
</head>
<body>
   <header class="page-header">

      <div class="header-logo">
         <a href="${contextPath}/"> <img src="${contextPath}/resources/img/icon.png" alt="Logo" />
         </a>
      </div>
      <div class="header-menu">
         <nav class="header-navigation">
            <a href="${contextPath}/map">지도</a> <a href="${contextPath}/boards/enroll">방 내놓기</a> <a href="/project/qna">Q&amp;A</a>
         </nav>
         <div class="header-profile dropdown">
            <button type="button" class="dropdown-button">
               <img src="https://avatars.githubusercontent.com/u/50897259?v=4"
                  alt="Profile Image" draggable="false" />
            </button>
            <div class="dropdown-menu"  style="z-index:2">
               <h3>
                  <!-- 세션 없을 시  : <a href="/project/users/login">Sign in</a> -->
                  반갑습니다 :) <strong>한승훈</strong> 님
               </h3>
               <ul>
                  <li><a href="${contextPath}/users/info">내 정보</a></li>
                  <li><a href="#">내가 등록한 방</a></li>
                  <li><a href="#">최근 본 방</a></li>
                  <li><a href="${contextPath}/messages">쪽지</a></li>
               </ul>
               <ul>
                  <li><a href="">로그아웃</a></li>
               </ul>
            </div>
         </div>
      </div>
   </header>



   <!-- 여기에 지도 작성하세요 :) -->
   <div class="map_wrap">
      <div id="map"></div>
      <div id="menu_wrap" class="bg_white">
         <div>
            <form onsubmit="searchPlaces()">
               장소명 : <input type="text" value="" id="keyword" size="15">
               <button type="submit">검색하기</button>
            </form>
         </div>
         <div>
         	<ul id="placesList"></ul>
         </div>
      	<div class="pagination" id="pagination"></div>
      </div>
   </div>
<script src="${contextPath}/resources/js/dropdown-menu.js"></script>  
</body>
</html>