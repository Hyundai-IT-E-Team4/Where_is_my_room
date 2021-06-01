<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" href="../resources/css/update.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<!-- favicon -->
<link rel="shortcut icon" href="../resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="../resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src="//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">

	// 닉네임 중복 체크
	function registerCheckFunction() {
		var nickname = $('#nickname').val();

		$.ajax({
			type : 'POST',
			url : './CheckNickname',
			data : {
				nickname : nickname
			},
			success : function(result) {
				if (result == 1) {
					alert("이미 있는 닉네임입니다.");
				} else {
					alert("사용할 수 있는 닉네임입니다.");
				}
			}
		});
	}
	
</script>
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
			<div class="update">
				<form class="register-form" method="post" action="update">
					<h1>개인정보 변경</h1>
					<div class="input">
						<div class="label">
							<label>이름</label>
						</div>
						<input type="hidden" name="email" value="${sessionScope.userInfo.email}"> 
						<input class="input-info" id="name" type="text" name="name" maxlength="20" placeholder="이름" required="required" value="${sessionScope.userInfo.name}">
					</div>
					<div class="input">
						<div class="label">
							<label>닉네임</label>
						</div>
						<div class="inputs">
							<input class="input-info" id="nickname" type="text" name="nickname" maxlength="20" required="required" placeholder="닉네임" value="${sessionScope.userInfo.nickname}">
                        	<button class="check-btn" onclick="registerCheckFunction();" type="button">Check</button>
                        </div>
					</div>
					<div class="input">
						<div class="label">
							<label>성별</label>
						</div>
						<c:choose>
                              <c:when test="${sessionScope.userInfo.gender == '남성'}">
                                 <select class="input-info" name="gender">
			                        <option value="남성" selected="selected">남성</option>
			                        <option value="여성">여성</option>
								</select>
                              </c:when>
                              <c:otherwise>
                                 <select class="input-info" name="gender">
			                        <option value="남성">남성</option>
			                        <option value="여성" selected="selected">여성</option>
								</select>                         
                              </c:otherwise>
                         </c:choose>
					</div>															
					<div class="input">
						<div class="label">
							<label>계정 비밀번호</label>
						</div>
						<input class="input-info" type="password" name="password" maxlength="20" placeholder="계정 비밀번호" autocomplete="off">
					</div>
					<input type="submit" value="개인정보 변경">
				</form>
			</div>
		</div>
	</section>


	<!-- app -->
	<script src="../resources/js/dropdown-menu.js"></script>
</body>
</html>
