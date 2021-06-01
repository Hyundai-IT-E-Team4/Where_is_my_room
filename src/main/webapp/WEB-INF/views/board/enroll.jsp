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
<meta name="initial" content="Han seunghoon" />
<meta name="author" content="Hyndai IT&E KTH, BEJ, HMS, HSH" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>짧게 머물자, 구해줘 룸즈!</title>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="../resources/js/enroll.js" ></script>
<!-- fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap"
	rel="stylesheet" />

<!-- styles -->
<link rel="stylesheet" href="../resources/css/reset.css" />
<link rel="stylesheet" href="../resources/css/grid.min.css" />
<link rel="stylesheet" href="../resources/css/header.css" />
<link rel="stylesheet" href="../resources/css/footer.css" />
<link rel="stylesheet" href="../resources/css/dropdown.css" />

<!-- favicon -->
<link rel="shortcut icon" href="../resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="../resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
</head>
<body>
	<header class="page-header">
		<div class="header-logo">
			<a href="/team4/"> <img src="../resources/img/icon.png"
				alt="Logo" />
			</a>
		</div>
		<div class="header-menu">
			<nav class="header-navigation">
				<a href="/team4/map">지도</a> 
				<a href="/team4/board/enroll">방 내놓기</a> 
				<a href="/team4/qna">Q&amp;A</a>
			</nav>
			<div class="header-profile dropdown">
				<button type="button" class="dropdown-button">
					<img src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" draggable="false" />
				</button>
				<div class="dropdown-menu">
					<c:choose>
						<c:when test="${sessionScope.userInfo.nickname ne null}">
							<h3>
								반갑습니다 :) <strong>${sessionScope.userInfo.nickname}</strong> 님
							</h3>
							<ul>
								<li><a href="/team4/users/info">내 정보 관리</a></li>
								<li><a href="#">내가 등록한 방</a></li>
								<li><a href="#">최근 본 방</a></li>
								<li><a href="/team4/messages">메시지</a></li>
							</ul>
							<ul>
								<li><a href="/team4/users/logout">로그아웃</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<h3>로그인 후 이용해보세요!</h3>
							<ul>
								<li>
									<a href="/team4/users/login">로그인 및 회원가입</a>
								</li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</header>
	
	<section>
		<div class="container">
			<!-- 여기에 작성하세요 :) -->
			<form action="../boards" method="post" enctype="multipart/form-data">
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
			<input type="text" name="rental_fee" required="required">
		</div>

		<div>
			<strong>게시글 제목을 입력해주세요</strong>
			<input type="text" name="title" required="required">
		</div>

		<div>
			<strong>방에 대한 설명을 입력해주세요</strong>
			<textarea rows="5" cols="10" name="content" required="required"></textarea>
		</div>
		<div>
			<input type="text" id="postcode" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" placeholder="주소" name="address" required="required"><br>
			<input type="text" id="detailAddress" placeholder="상세주소" name="detailAddress" required="required">
			<input type="text" id="extraAddress" placeholder="참고항목">
			<input type="hidden" name="latitude" id="latitude">
			<input type="hidden" name="longitude" id="longitude">
		</div>
		<div id="fileContainer">
			<p>
				<input type="file" name="file1">
				<a href="#this" name="delete" >삭제하기</a>
			</p>
		</div>
		<a href="#this" id="add">파일 추가하기</a>
		<input type="submit" value="등록하기"/>
		</form>

	<!-- 지도 표시 영역 시작-->
	<div id="map" style="width:100%;height:350px;"></div>
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
	<script src="../resources/js/dropdown-menu.js"></script>
	
	
</body>
</html>