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
<!-- 해당 페이지의 css 적용! style 지우고 해당 css 입력! -->
<link rel="stylesheet" href="../resources/css/login.css" />

<!-- favicon -->
<link rel="shortcut icon" href="../resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="../resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<header class="page-header">
		<div class="header-logo">
			<a href="./index.html"> 
				<img src="../resources/img/icon.png" alt="Logo" />
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
					<img src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" draggable="false" />
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
	</header>

	<section class="login">
		<div class="container">
			<form class="login-form" action="login" method="POST">
				<a href="./index.html"> 
					<img src="../resources/img/icon.png" alt="Logo" width=360 />
				</a>
				<p>
					지금 바로 <b>구해줘 룸즈</b>를 시작하세요!
				</p>
				<input type="email" name="email" placeholder="example@naver.com" />
				<input type="password" name="password" placeholder="****" />

				<button type="submit">로그인</button>

				<div class="login-option">
					<label> 
						<input type="checkbox" name="autologin" value="1">로그인 유지
					</label>
					<p>
						<a href="/forgot">아이디/비밀번호 찾기</a>
					</p>
				</div>

				<div class="login-register">
					<p>구해줘 룸즈가 처음이신가요?</p>
					<a href="./index.html"> 회원가입 </a>
				</div>
			</form>
		</div>
	</section>

	<!-- app -->
	<script src="../resources/js/dropdown-menu.js"></script>
</body>
</html>
