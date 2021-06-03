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
<link rel="stylesheet" href="${contextPath}/resources/css/register.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/check.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<!-- favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="${contextPath}/resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src="//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var code = "";

	var button_joinus = $('.submit-btn');

	var authEmail = false;
	var checkNickname = false;

	// 닉네임 중복 체크
	function registerCheckFunction() {
		var nickname = $('#nickname').val();
		var check = $(".check-nickname");

		$.ajax({
			type : 'POST',
			url : './CheckNickname',
			data : {
				nickname : nickname
			},
			success : function(result) {
				if (result == 1) {
					checkNickname = false;
					alert("이미 있는 닉네임입니다.");
				} else {
					checkNickname = true;
					alert("사용할 수 있는 닉네임입니다.");
					check.css("visibility", "visible");
					
					if(authEmail)
						check.disabled = false;
				}
			}
		});
	}

	// 비밀번호 확인 체크
	function passwordCheckFunction() {
		var userPassword1 = $('#userPassword1').val();
		var userPassword2 = $('#userPassword2').val();

		if (userPassword2 != '' && userPassword1 != userPassword2) {
			$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
		} else {
			$('#passwordCheckMessage').html('');
		}
	}

	// 이메일 자동완성
	$(function() {
		$('#select').change(function() {
			if ($('#select').val() == 'directly') {
				$('#textEmail').attr("disabled", false);
				$('#textEmail').val("");
				$('#textEmail').focus();
			} else {
				$('#textEmail').val($('#select').val());
			}
		})
	});

	/* 인증번호 이메일 전송 및 확인 */
	$(function() {
		$('.mail_check_btn').click(function() {
			
			var email = $("#email").val() + '@' + $("#textEmail").val();

			var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스
			var chkbtn = $(".mail_check_btn");
			var check = $(".check-email");

			if (chkbtn.val() == '인증번호 전송') {
				$.ajax({
					type : "GET",
					url : "./mailCheck?email=" + email,
					success : function(data) {
						console.log("data : " + data);
						alert('인증번호를 전송하였습니다! 메일에서 확인해주세요!');
						boxWrap.attr("disabled", false);
						boxWrap.attr("id", "mail_check_input_box_true");

						chkbtn.val("인증번호 확인");
						code = data;
					}
				});
			} else if (chkbtn.val() == '인증번호 확인') {
				let input = boxWrap.val();

				if (input == code) {
					authEmail = true;
					check.css("visibility", "visible");	
					alert('인증번호가 일치합니다.');
					
					if(checkNickname)
						check.disabled = false;
				} else {
					authEmail = false;
					alert('인증번호가 일치하지 않습니다.');
				}
			}
		})
	});
</script>
</head>
<body>
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
			<form class="register-form" method="post" action="register">
				<a href="${contextPath}"> <img src="${contextPath}/resources/img/icon.png"
					alt="Logo" width=360 />
				</a>
				<table class="register-form-table">
					<thead>
						<tr>
							<th><h3>회원 가입</h3></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<h5>이메일</h5>
							<td>
								<div class="email-input">
									<input type="text" id="email" name="email" maxlength="20"
										placeholder="이메일"> <strong>@</strong> <input
										id="textEmail" name="textEmail" placeholder="이메일 선택">
									<select id="select">
										<option value="" disabled selected>E-Mail 선택</option>
										<option value="naver.com" id="naver.com">naver.com</option>
										<option value="hanmail.net" id="hanmail.net">hanmail.net</option>
										<option value="gmail.com" id="gmail.com">gmail.com</option>
										<option value="nate.com" id="nate.com">nate.com</option>
										<option value="directly" id="textEmail">직접 입력하기</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td>
							<td class="inputs">
								<input class="mail_check_input_box"
								id="mail_check_input_box_false" maxlength="6"
								disabled="disabled" placeholder="인증번호 6자리"> 
								<input
								class="mail_check_btn" style="cursor: pointer;" type="button"
								value="인증번호 전송">
								<div class="check-email" style="visibility: hidden;">
									<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 130.2 130.2">
										<circle class="path circle" fill="none" stroke="#73AF55" stroke-width="6" stroke-miterlimit="10" cx="65.1" cy="65.1" r="62.1" />
  										<polyline class="path check" fill="none" stroke="#73AF55"
											stroke-width="6" stroke-linecap="round"
											stroke-miterlimit="10"
											points="100.2,40.2 51.5,88.8 29.8,67.5 " />
									</svg>
								</div>
							</td>
						</tr>
						<tr>
							<td><h5>비밀번호</h5>
							<td><input onkeyup="passwordCheckFunction();"
								id="userPassword1" type="password" name="password"
								maxlength="20" placeholder="비밀번호를 입력하시오."></td>
						</tr>
						<tr>
							<td><h5>비밀번호 확인</h5>
							<td><input onkeyup="passwordCheckFunction();"
								id="userPassword2" type="password" maxlength="20"
								placeholder="비밀번호 확인을 입력하시오."></td>
						</tr>
						<tr>
							<td><h5>이름</h5>
							<td><input id="name" type="text" name="name" maxlength="20"
								placeholder="이름을 입력하시오."></td>
						</tr>
						<tr>
							<td><h5>닉네임</h5>
							<td class="inputs"><input id="nickname" type="text"
								name="nickname" maxlength="20" placeholder="닉네임을 입력하시오.">
								<button class="check-btn" onclick="registerCheckFunction();"
									type="button">확인</button>
								<div class="check-nickname" style="visibility: hidden;">
									<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 130.2 130.2">
										<circle class="path circle" fill="none" stroke="#73AF55" stroke-width="6" stroke-miterlimit="10" cx="65.1" cy="65.1" r="62.1" />
  										<polyline class="path check" fill="none" stroke="#73AF55"
											stroke-width="6" stroke-linecap="round"
											stroke-miterlimit="10"
											points="100.2,40.2 51.5,88.8 29.8,67.5 " />
									</svg>
								</div>
							</td>
						</tr>
						<tr>
							<td><h5>성별</h5>
							<td>
								<div class="inputs">
									<select class="input-info" name="gender">
										<option selected="selected">성별</option>
										<option value="남성">남성</option>
										<option value="여성">여성</option>
									</select>
								</div>
							</td>
						</tr>
					</tbody>
				</table>

				<h5 style="color: red;" id="passwordCheckMessage"></h5>
				<button class="submit-btn disabled" type="submit">가입하기</button>

			</form>
		</div>
	</section>
	
	<!-- app -->
	<script src="${contextPath}/resources/js/dropdown-menu.js"></script>
</body>
</html>
