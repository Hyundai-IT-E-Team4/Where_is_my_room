<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
<link rel="stylesheet" href="${contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/grid.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/dropdown.css" />
<!-- 해당 페이지의 css 적용! style 지우고 해당 css 입력! -->
<link rel="stylesheet" href="${contextPath}/resources/css/home.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/popup.css" />

<!-- favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="${contextPath}/resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
				<a href="/team4/map"><b>지도</b></a> 
				<a href="/team4/boards/enroll"><b>방 내놓기</b></a> 
				<a href="/team4/messages"><b>메시지</b></a>
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
								<li><a href="/team4/users/info">내 정보 관리</a></li>
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
	
	<section class="landing">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="landing-content">
						<h1 class="landing-title">Where Is My Room!</h1>
						<p class="landing-desc">원하는 방을 찾고 빠르게 연락하세요 :-)</p>
						<form>
							<div class="landing-search">
								<img width="24" height="24"
									src="https://image.flaticon.com/icons/png/128/14/14877.png"
									alt="Search" /> <input placeholder="지역 &amp; 단지명을 입력해서 찾아보세요!" />
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="service">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6">
					<h2 class="service-title">쉽고 빠르게 자신의 집을 공유해보세요!</h2>
					<p class="service-desc">방학, 휴가 등 거주하지 않는 집을 내버려두지 않고 소득을 얻을 수
						있는 서비스입니다. 자신의 집을 소개해보세요!</p>
				</div>
				<div class="col-12 col-md-6">
					<h2 class="service-title">짧은 기간동안 머무를 집이 필요한가요?</h2>
					<p class="service-desc">1년 미만 정도의 기간동안 편하게 머무를 수 있는 공간을 쉽고 빠르게
						다양한 집을 만나보세요!</p>
				</div>
			</div>
		</div>
	</section>
	<section class="program section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 col-md-10">
					<strong class="section-category"> Guide </strong>
					<h1 class="section-desc">🙋🏻‍♂️ 구해줘 룸즈가 알려주는 방 거래 가이드</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-md-4">
					<a href="#" class="program-card"> <img
						src="https://media.giphy.com/media/HoffxyN8ghVuw/giphy.gif" alt="" />
						<h2>✔️ 허위 매물 예방 5단계</h2>
					</a>
				</div>
				<div class="col-12 col-md-4">
					<a href="#" class="program-card"> <img
						src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1573179615/noticon/jn4bbvjmjjlaa0ekrygc.gif"
						alt="" />
						<h2>😍 매력적인 방 소개 작성법</h2>
					</a>
				</div>
				<div class="col-12 col-md-4">
					<a href="#" class="program-card"> <img
						src="https://media.giphy.com/media/4TcL7e5ZQkDWBMx84z/giphy.gif"
						alt="" />
						<h2>🙏🏻 나에게 꼭 맞는 방 찾는 방법</h2>
					</a>
				</div>
			</div>
		</div>
	</section>
	<footer class="page-footer">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<ul class="footer-links">
						<li><a href="#">Terms</a></li>
						<li><a href="#">privacy</a></li>
						<li><a href="#">Security</a></li>
						<li><a href="#">Status</a></li>
						<li><a href="https://1coding.tistory.com/">Blog</a></li>
						<li><a href="https://github.com/Hanseunghoon">Github</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>

	<!-- app -->
	<script src="${contextPath}/resources/js/dropdown-menu.js"></script>
</body>
</html>