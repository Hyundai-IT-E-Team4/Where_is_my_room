<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services"></script>
<script src="../resources/js/detail.js" ></script>
<script>
let latitude = "${boardDetailDTO.latitude}";
let longitude = "${boardDetailDTO.longitude}";
</script>

</head>
<body>
	${boardDetailDTO.content }
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
		<strong>집 상세 정보</strong>
		<div class="container">
			<!-- 여기에 작성하세요 :) -->
			<div>
			<strong>제목</strong>
			${boardDetailDTO.title }
			</div>
			<div>
			<strong>집 정보</strong><br>
			<div>
			<strong>종류</strong>
			${boardDetailDTO.roomType } &nbsp;
			<strong>구분</strong>
			${boardDetailDTO.contractType }
			
			<strong>양도 가격</strong>
			${boardDetailDTO.rentalFee} (만)원
			</div>
			<div>
			<strong>위치</strong>
			${boardDetailDTO.address} ${boardDetailDTO.detailAddress}
			</div>
			<div id="map" style="width:100%;height:350px;"></div>
			<div>
			<strong>집 사진</strong>
			<c:forEach var="file" items="${boardDetailDTO.files}">
    		<img src="${file.url}" title="${file.uploadFileName}" width="50%" height="50%">
			</c:forEach>
			</div>
			<div>
			
			</div>
			</div>
			<div>
			<strong>상세 설명</strong><br>
			${boardDetailDTO.content}
			</div>
		</div>
		<div>
		<strong id="list" onClick="location.href=history.back()">목록으로</strong>
		<strong id="showComments">댓글보기</strong>
		<%-- <c:if test="${userInfo} != null && ${userInfo}.id == ${boardDetailDTO.writerId }"> --%>
			<strong id="delete">삭제하기</strong>
		<%-- </c:if> --%>
		</div>
		<div id="commentsContainer"></div>
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
