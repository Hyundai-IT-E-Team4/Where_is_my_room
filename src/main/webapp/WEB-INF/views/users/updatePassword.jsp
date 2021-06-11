<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" href="${contextPath}/resources/css/updatePassword.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/popup.css" />

<!-- favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="${contextPath}/resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${contextPath}/resources/js/global.js"></script>
<script type="text/javascript">

	function passwordCheckFunction() {
		var userPassword1 = $('#userPassword1').val();
		var userPassword2 = $('#userPassword2').val();
		
		if (userPassword1.length < 4) {
			$('#check-length').html('4자 이상 입력하세요.');
		} else {
			$('#check-length').html('');
		}
	
		if (userPassword2 != '' && userPassword1 != userPassword2) {
			$('#check-diff').html('비밀번호가 서로 일치하지 않습니다.');
		} else {
			$('#check-diff').html('');
		}
	}
	
</script>
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
			<div class="update-Password">
				<form method="post" action="updatePassword">
					<h1>비밀번호 변경</h1>
					<div class="input">
						<div class="label">
							<label>새 비밀번호</label>
							<p>4~20자</p>
						</div>
						<input onkeyup="passwordCheckFunction();"
								id="userPassword1" type="password" name="passwordAfter" maxlength="20" placeholder="새 비밀번호">
						<h5 class="caution" id="check-length"></h5>
						<input onkeyup="passwordCheckFunction();"
								id="userPassword2" type="password" maxlength="20" placeholder="새 비밀번호 확인">
						<h5 class="caution" id="check-diff"></h5>
					</div>
					<div class="input">
						<div class="label">
							<label>현재 비밀번호</label>
						</div>
						<input type="hidden" name="email" value="${sessionScope.userInfo.email}">
						<input type="password" name="passwordBefore" maxlength="20" placeholder="현재 비밀번호">
					</div>
					<div class="rules">
						<p>	
							<strong>※ 타인에게 비밀번호를 공유하는 것은 개인정보 유출로 이어질 수 있습니다.</strong>
							<br>
					        <span style="color: #c62917;">자신의 비밀번호를 공유하지 마세요!</span>
					    </p> 
					</div>
					<input type="submit" value="비밀번호 변경">
				</form>
			</div>
		</div>
	</section>

	<!-- app -->
	<script src="${contextPath}/resources/js/dropdown-menu.js"></script>
</body>
</html>
