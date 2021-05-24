<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- description -->
<meta charset="UTF-8" />
<meta name="keywords" content="Where is my room" />
<meta name="description" content="짧게 머무는 방 찾기 서비스" />
<meta name="initial" content="Han seunghoon" />
<meta name="author" content="Hyndai IT&E KTH, BEJ, HMS, HSH" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>짧게 머물자, 구해줘 룸즈!</title>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services"></script>
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

<!-- favicon -->
<link rel="shortcut icon" href="resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<header class="page-header">
		<div class="header-logo">
			<a href="./index.html"> <img src="resources/img/icon.png"
				alt="Logo" />
			</a>
		</div>
		<div class="header-menu">
			<nav class="header-navigation">
				<a href="/project/map">지도</a> 
				<a href="/project/boards/insert">방 내놓기</a> 
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
						<li><a href="/project/users/logout">로그아웃</a></li>
					</ul>
				</div>
			</div>
		</div>
		</div>
	</header>
	<section>
		<div class="container">
			<!-- 여기에 작성하세요 :) -->
			<form method="post">
			<div>
			<strong>매물 종류</strong>
			<input type="radio" value="원룸" name="room_type"/>원룸
			<input type="radio" value="투룸" name="room_type"/>투룸
			</div>
			<br><br>
			<div>
			<strong>계약 종류</strong>
			<input type="radio" value="양도" name="contract_type"/>양도
			<input type="radio" value="대여" name="contract_type"/>대여
			</div>
			


<div>
<strong>희망 가격</strong>
<input type="text" name="rental_fee">
</div>

<div>
<strong>게시글 제목을 입력해주세요</strong>
<input type="text" name="title">
</div>


<div>
<strong>방에 대한 설명을 입력해주세요</strong>
<textarea rows="5" cols="10" name="content"></textarea>
</div>
<div>

<strong>작성자 아이디</strong>
<input type="text" name="writer_id">(세션에서 가져올 예정) + writer_id라서 user와 조인 필요 
</div>
<div>
<strong>위도 경도 출력되는 곳</strong>
<input type="text" name="latitude" id="latitude" value="">
<input type="text" name="longitude" id="longitude" value="">
</div>
<div>
<strong>주소입력하는 곳</strong>
<input type="text" id="address" name="address">
<button onclick='getAddress()' type="button">확인</button>
</div>
<input type="submit" value="등록하기"/>
</form>


		
		
			<!-- 지도 표시 영역 시작-->
<div id="map" style="width:100%;height:350px;"></div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };  
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
function getAddress(){
	var keyword = document.getElementById('address').value;
	geocoder.addressSearch(keyword , function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			console.log(result[0].y);//lat
			console.log(result[0].x);//lng
			var lat = document.getElementById("latitude");
			var lon = document.getElementById("longitude");
			lat.value = result[0].y;
			lon.value = result[0].x;
			console.log(lat.value);
			console.log(lon.value);
			// 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
}
</script>
<!-- 지도 표시 영역 끝-->

			
		</div>
	</section>



	<!-- Footer Section -->
	<footer class="page-footer">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<ul class="footer-links">
						<li><a href="#">Terms</a></li>
						<li><a href="#">privacy</a></li>
						<li><a href="#">Security</a></li>
						<li><a href="#">Status</a></li>
						<li><a href="#">Blog</a></li>
						<li><a href="#">Github</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>

	<!-- app -->
	<script src="resources/js/dropdown-menu.js"></script>
	
	
</body>
</html>