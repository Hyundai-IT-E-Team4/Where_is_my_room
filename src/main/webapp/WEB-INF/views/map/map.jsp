<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services,clusterer"></script>
</head>
<body>
	<header class="page-header">
	
		<div class="header-logo">
			<a href="/"> <img src="resources/img/icon.png"
				alt="Logo" />
			</a>
		</div>
		<div class="header-menu">
			<nav class="header-navigation">
				<a href="">지도</a> 
				<a href="">방 내놓기</a> 
				<a href="/project/qna">Q&amp;A</a>
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
<div id="menu_wrap">
 <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
</div>
      <ul id="placesList"></ul>
</div>
<div id="map" style="width:100%;height:350px;"></div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(37.5490198, 127.0092967), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); 
/***********************검색 기능 시작 검색을 하면 지도의 중심으로 이동********************************************/
var geocoder = new kakao.maps.services.Geocoder();

function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }
    
    //오토컴플릿기능 추가 예정

    //주소로 좌표를 검색합니다
    geocoder.addressSearch(keyword, function(result, status) {
        // 정상적으로 검색이 완료됐으면 
         if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
            map.setLevel(7, {animate: true});

         } 
    });    
}

//검색 및 이동을 할 때 좌표 정보를 가져와 목록을 로드한다 


/********************************************** 검색 기능 끝**********************************************/
/********************************** 클러스터링 시작 **********************************/    
    // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 2 // 클러스터 할 최소 지도 레벨 
    });
 
    // 데이터를 가져오기 위해 jQuery를 사용합니다
    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다

var getNearLocation = function(swLatLng,neLatLng){
	var reqUrl = "map/"+swLatLng.getLat()+"/"+swLatLng.getLng()+"/"+neLatLng.getLat()+"/"+neLatLng.getLng()+"/";	
	 $.get(reqUrl, function(data) {
	        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        
	        var markers = $(data.positions).map(function(i, position) {
	            return new kakao.maps.Marker({
	                position : new kakao.maps.LatLng(position.latitude, position.longitude)
	            	
	            });
	        });
	        
	        console.log(data.positions[0]);
	        displayPlaces(data.positions);
	        
	        //데이터가 자바스크립트 안에있다.
	        //이 데이터를 저렇게 html 보내야된다.
	        
	        
	        // 클러스터러에 마커들을 추가합니다
	        clusterer.clear();
	        clusterer.addMarkers(markers);
	 		  
	 });    	
    }    

kakao.maps.event.addListener(map, 'tilesloaded', function() {   	
        // 지도의  레벨을 얻어옵니다
        var level = map.getLevel();
        // 지도의 중심좌표를 얻어옵니다 
        var myLocation = map.getCenter(); 
        var bounds = map.getBounds();
         // "((33.44843745687413, 126.56798357402302), (33.452964008206735, 126.57333898904454))"
     	 var swLatLng = bounds.getSouthWest(); 
         //영역의 남서쪽 좌표를 얻어온다.
         var neLatLng = bounds.getNorthEast(); 
         getNearLocation(swLatLng,neLatLng);
         
         //영역의 북동쪽 좌표를 얻어온다.    
    });
    

/********************************** 클러스터링 끝 **********************************/        


/********** 목록만들기 시작 ***********/
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'),
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    
    for ( var i=0; i<places.length; i++ ) {
      var itemEl = getListItem(places[i]); // 검색 결과 항목 Element를 생성합니다
        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
}


function getListItem(place) {
    var el = document.createElement('li');
    var itemStr = '<div class="info">' +
        '   <h5>' + place.title + '</h5></div>';
	el.innerHTML += itemStr;
    el.className = 'item';
    console.log(place.title);
    console.log(el);
    return el;
}

function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

/********** 목록만들기 끝 ***********/

</script>


<!---------------------  지도 끝        ------------->

</body>
</html>