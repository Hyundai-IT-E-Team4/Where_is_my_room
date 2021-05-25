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
    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>

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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services"></script>

<script>
var positions = [];
window.onload = function(){
	alert('윈도우 오픈');
	$.ajax({
		type : "GET",
		url  : "map2",
		error : function(error) {
			console.log("error");
		},
		success : function(data) {
			console.log("success");
			for(let i = 0; i < data.length; i++){
			    let position = {};
			    position.title = data[i].title;
			    position.latlng = new kakao.maps.LatLng(data[i].latitude, data[i].longitude);
			    positions.push(position);  
			}
			 console.log(positions);
			 marking(positions);
			 displayPlaces(positions);
		}
	});
	 
}; 

//console.log("남서쪽의 위도 : "+swLatLng.getLat());
//console.log("남서쪽의 경도 : "+swLatLng.getLng());
//console.log("북동쪽의 위도 : "+neLatLng.getLat());
//console.log("북동쪽의 경도 : "+neLatLng.getLng());

var getNearLocation = function(swLatLng,neLatLng){
	
	positions = [];
	plClear();
	let reqUrl = "map2/"+swLatLng.getLat()+"/"+swLatLng.getLng()+"/"+neLatLng.getLat()+"/"+neLatLng.getLng()+"/";
	console.log(reqUrl);
	$.ajax({
		type : "GET",
		url  : reqUrl,
		error : function(error) {
			console.log("error");
		},
		success : function(data) {
			console.log("success");
		 	for(let i = 0; i < data.length; i++){
			    let position = {};
			    position.title = data[i].title;
			    position.latlng = new kakao.maps.LatLng(data[i].latitude, data[i].longitude);
			    positions.push(position);  
			}
			 console.log(positions);
			 console.log(data);
			 marking(positions);
			 displayPlaces(positions);
		}
	});
	 
}; 
</script>
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
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
	
	
	<!-- 여기에 지도 작성하세요 :) -->
	
	<div id="map" style="width:100%;height:350px;"></div>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(37.5490198, 127.0092967), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
//마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

//마커를 담을 배열입니다
var markers = [];

//position
function marking(positions){
	for (var i = 0; i < positions.length; i ++) {
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	    markers.push(marker);
	}
} 





/* 실험 시작  ********************************************************************/


function searchPlaces(){

var ps = new kakao.maps.services.Places(); 
var keyword = document.getElementById('keyword').value;
// 키워드로 장소를 검색합니다
ps.keywordSearch(keyword, placesSearchCB); 

//제가 생각하는건 일단 지도에 다 뿌려져있음  -> 방 마커가 

}


// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();
        for (var i=0; i<data.length; i++) {
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
        var mylocation = map.getCenter();
        
    
       
    } 
}

//지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'center_changed', function() {
	removeMarker();
	
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

    
    
    //위도경도 출력
  /*   var message = '<p>지도 레벨은 ' + level + ' 이고</p>';
    message += '<p>중심 좌표는 위도 ' + myLocation.getLat() + ', 경도 ' + myLocation.getLng() + '입니다</p>';
	 */

	  
});
//addListener 끝

//지도 위에 표시되고 있는 마커를 모두 제거합니다

function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}


function displayPlaces(positions) {
	plClear();
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    //bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    //removeAllChildNods(listEl);
    // 지도에 표시되고 있는 마커를 제거합니다
    //removeMarker();
    
    for ( var i=0; i<positions.length; i++ ) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = positions[i].latlng,
           // marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, positions[i]); // 검색 결과 항목 Element를 생성합니다
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        	//bounds.extend(placePosition);
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
      /*   (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, positions[i].titile); */
        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    //map.setBounds(bounds);
}
function getListItem(index, positions) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + positions.title + '</h5>';
                '</div>';           
    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

function plClear(){
	var pl = document.getElementById('placesList');
	pl.innerHTML = "";
}


</script>



</body>
</html>