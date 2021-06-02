<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- description -->
<meta charset="UTF-8" />
<meta name="keywords" content="Where is my room" />
<meta name="description" content="짧게 머무는 방 찾기 서비스" />
<meta name="init" content="Han seunghoon" />
<meta name="author" content="Hyndai IT&E KTH, BEJ, HMS, HSH" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>짧게 머물자, 구해줘 룸즈!</title>

<style>
.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
   color: #000;
   text-decoration: none;
}
.map_wrap {
   position: relative;
   width: 100%;
   height: 970px;
}
#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 250px;
   margin: 10px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: #ffffff;
   z-index: 1;
   font-size: 12px;
   border-radius: 10px;
}
#menu_wrap hr {
   display: block;
   height: 1px;
   border: 0;
   border-top: 2px solid #5F5F5F;
   margin: 3px 0;
}
#menu_wrap .option {
   text-align: center;
}
#menu_wrap .option p {
   margin: 10px 0;
}
#menu_wrap .option button {
   margin-left: 5px;
}
#placesList li {
   list-style: none;
}
#placesList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}
#placesList .item span {
   display: block;
   margin-top: 4px;
}
#placesList .item h5, #placesList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}
#placesList .item .info {
   padding: 10px 0 10px 55px;
}
#placesList .info .gray {
   color: #8a8a8a;
}
#pagination {
   margin: 10px auto;
   text-align: center;
}
#pagination a {
   display: inline-block;
   margin-right: 10px;
}
#pagination .on {
   font-weight: bold;
   cursor: default;
   color: #777;
}
</style>
<!-- fonts -->
<link
   href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap"
   rel="stylesheet" />
<!-- styles -->
<link rel="stylesheet" href="resources/css/reset.css" />
<link rel="stylesheet" href="resources/css/grid.min.css" />
<link rel="stylesheet" href="resources/css/header.css" />
<link rel="stylesheet" href="resources/css/footer.css" />
<link rel="stylesheet" href="resources/css/dropdown.css" />
<!-- 해당 페이지의 css 적용! style 지우고 해당 css 입력! -->
<!-- <link rel="stylesheet" href="../assets/css/page.css" /> -->

<!-- favicon -->
<link rel="shortcut icon" href="resources/img/favicon.ico"
   type="image/x-icon" />
<link rel="icon" href="resources/img/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css"/>

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://pagination.js.org/dist/2.1.5/pagination.min.js"></script>
<script type="text/javascript" src="https://unpkg.com/default-passive-events"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services,clusterer"></script>
<script src="resources/js/map.js" ></script>
</head>
<body>
   <header class="page-header">

      <div class="header-logo">
         <a href="/"> <img src="resources/img/icon.png" alt="Logo" />
         </a>
      </div>
      <div class="header-menu">
         <nav class="header-navigation">
            <a href="">지도</a> <a href="">방 내놓기</a> <a href="/project/qna">Q&amp;A</a>
         </nav>
         <div class="header-profile dropdown">
            <button type="button" class="dropdown-button">
               <img src="https://avatars.githubusercontent.com/u/50897259?v=4"
                  alt="Profile Image" draggable="false" />
            </button>
            <div class="dropdown-menu">
               <h3>
                  <!-- 세션 없을 시  : <a href="/project/users/login">Sign in</a> -->
                  반갑습니다 :) <strong>한승훈</strong> 님
               </h3>
               <ul>
                  <li><a href="#">내 정보</a></li>
                  <li><a href="#">내가 등록한 방</a></li>
                  <li><a href="#">최근 본 방</a></li>
                  <li><a href="#">쪽지</a></li>
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
      <div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
      <div id="menu_wrap" class="bg_white">
         <div>
            <form onsubmit="searchPlaces() return false;">
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
<script type="text/javascript">
</script>   
</body>
</html>