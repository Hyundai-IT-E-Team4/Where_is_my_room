<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<script>
let latitude = "${boardDetailDTO.latitude}";
let longitude = "${boardDetailDTO.longitude}";
let roomType = "${boardDetailDTO.roomType}";
let contractType = "${boardDetailDTO.contractType}";
</script>
<!-- description -->
<meta charset="UTF-8" />
<meta name="keywords" content="Where is my room" />
<meta name="description" content="짧게 머무는 방 찾기 서비스" />
<meta name="initial" content="Han seunghoon" />
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
<link rel="stylesheet" href="${contextPath}/resources/css/enroll.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/popup.css" />

<!-- favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="${contextPath}/resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${contextPath}/resources/js/update.js"></script>
<script src="${contextPath}/resources/js/global.js"></script>
</head>
<body>
	<div class="popup-container"></div>
	<header class="page-header">
		<div class="header-logo">
			<a href="${contextPath}"> <img src="${contextPath}/resources/img/icon.png"
				alt="Logo" />
			</a>
		</div>
		<div class="header-menu">
			<nav class="header-navigation">
				<a href="${contextPath}/map"><b>지도</b></a> 
				<a href="${contextPath}/boards/enroll"><b>방 내놓기</b></a> 
				<a href="${contextPath}/messages"><b>메시지</b></a>
			</nav>
			<div class="header-profile dropdown">
				<button type="button" class="dropdown-button">
					<c:choose>
						<c:when test="${sessionScope.userInfo.profile_img eq null}">
							<img src="${contextPath}/resources/img/user.png" alt="Default Profile Image" draggable="false" />
						</c:when>
						<c:otherwise>
							<img src="${sessionScope.userInfo.profile_img}" alt="Profile Image" draggable="false" />
						</c:otherwise>
					</c:choose>
				</button>
				<div class="dropdown-menu">
					<c:choose>
						<c:when test="${sessionScope.userInfo.nickname ne null}">
							<h3>
								반갑습니다 :) <strong>${sessionScope.userInfo.nickname}</strong> 님
							</h3>
							<ul>
								<li><a href="${contextPath}/users/info">내 정보 관리</a></li>
								<li><a href="${contextPath}/messages">메시지</a></li>
							</ul>
							<ul>
								<li><a href="${contextPath}/users/logout">로그아웃</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<h3>로그인 후 이용해보세요!</h3>
							<ul>
								<li>
									<a href="${contextPath}/users/login">로그인 및 회원가입</a>
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
			<h1>방 정보 수정</h1>
			<form action="${contextPath}/boards/${id}" method="post" enctype="multipart/form-data">
				<div class="input-box row">
					<div class="input-label">매물 종류</div> 
					<input type="radio" value="원룸" name="roomType" />원룸 
					<input type="radio" value="투룸" name="roomType" />투룸
				</div>
				<div class="input-box row">
					<div class="input-label">계약 종류</div> 
					<input type="radio" value="양도" name="contractType" />양도 
					<input type="radio" value="대여" name="contractType" />대여
				</div>
				<div class="input-box row">
					<div class="input-label">희망 가격</div> 
					<input type="text" name="rentalFee" required="required" value="${boardDetailDTO.rentalFee}" style="width: 100px">&nbsp;(만)원
				</div>

				<div class="input-box row">
					<div class="input-label">게시글 제목을 입력해주세요</div> 
					<input type="text" name="title" required="required" value="${boardDetailDTO.title}" style="width: 300px">
				</div>

				<div class="input-box row">
					<div class="input-label">방에 대한 설명을 입력해주세요</div>
					<textarea rows="5" cols="10" name="content" required="required">
						${boardDetailDTO.content}
					</textarea>
				</div>
				<div class="input-box row">
					<div class="input-label">주소를 입력해주세요</div>
					<input type="text" id="postcode" placeholder="우편번호"> 
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn"><br>
				</div>
				<div class="input-box row">
					<div class="input-label">&nbsp;</div>
					<input type="text" id="address" placeholder="주소" name="address" required="required" value="${boardDetailDTO.address}">
					<input type="text" id="detailAddress" placeholder="상세주소" name="detailAddress" required="required" value="${boardDetailDTO.detailAddress}"> 
					<input type="text" id="extraAddress" placeholder="참고항목"> 
					<input type="hidden" name="latitude" id="latitude" value="${boardDetailDTO.latitude}"> 
					<input type="hidden" name="longitude" id="longitude" value="${boardDetailDTO.longitude}">
				</div>
				<div class="input-box row">
					<div class="input-label">사진 목록</div>
					<c:forEach var="file" items="${boardDetailDTO.files}">
						<div class="uploadImg">
							<img src="${file.url}" title="${file.uploadFileName}"> 
							<input type="hidden" name="img" value="${file.id}">
							<button class='imgDelete'>삭제</button>
						</div>
					</c:forEach>
				</div>
				<div id="fileContainer">
					<p>
						<input type="file" name="file1" class="input-label"> 
						<a href="#this" name="delete" class="delete-btn">사진 삭제하기</a>
					</p>
				</div>
				<a href="#this" id="add" class="add-btn">사진 추가하기</a> 
				
				<div id="map" style="width: 100%; height: 350px;"></div>
				
				<div style="display: flex; align-items: center">
					<input type="submit" value="등록하기" class="submit-btn"/>
				</div>
			</form>

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
	<script src="${contextPath}/resources/js/dropdown-menu.js"></script>
</body>
</html>
