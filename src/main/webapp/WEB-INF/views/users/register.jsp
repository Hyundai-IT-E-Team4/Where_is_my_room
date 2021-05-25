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
<link rel="stylesheet" href="../resources/css/register.css" />
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
	function registerCheckFunction() {
		var nickname = $('#nickname').val();
		
		$.ajax({
			type : 'POST',
			url : './UserRegisterCheckNickname',
			data : {
				nickname : nickname
			},
			success : function(result) {
				if (result == 1) {
					
					$('a[href="#ex7"]').modal({
				        fadeDuration: 250
				     });
					//$('#checkMessage').html('사용할 수 있는 닉네임입니다.');
					//$('#checkType').attr('class',
							//' modal-content panel-success');
				} else {
					$('a[href="#ex7"]').modal({
				        fadeDuration: 250
				     });
					//$('#checkMessage').html('사용할 수 없는 닉네임입니다.');
					//$('#checkType').attr('class',
						//	' modal-content panel-warning');
				}
			}
		});
	}

	function passwordCheckFunction() {
		var userPassword1 = $('#userPassword1').val();
		var userPassword2 = $('#userPassword2').val();

		if (userPassword2 != '' && userPassword1 != userPassword2) {
			$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
		} else {
			$('#passwordCheckMessage').html('');
		}
	}
</script>
</head>
<body>
	<header class="page-header">
		<div class="header-logo">
			<a href="./index.html"> <img src="../resources/img/icon.png"
				alt="Logo" />
			</a>
		</div>
		<div class="header-menu">
			<nav class="header-navigation">
				<a href="/project/map">지도</a> <a href="/project/boards/insert">방
					내놓기</a> <a href="/project/qna">Q&amp;A</a>
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
          <form class="register-form" method="post" action="register">
            <a href="./index.html">
              <img src="../resources/img/icon.png" alt="Logo" width=360/>
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
                  <td><input type="text" id="email" name="email"
                    maxlength="20" placeholder="이메일을 입력하시오."></td>
             
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
                  <td><input id="name" type="text" name="name"
                    maxlength="20" placeholder="이름을 입력하시오."></td>
                </tr>
                <tr>
                  <td><h5>닉네임</h5>
                  <td class="inputs">
                    <input id="nickname" type="text" name="nickname" maxlength="20" placeholder="닉네임을 입력하시오.">
                    <button class="check-btn" onclick="registerCheckFunction();" type="button">
                      Check
                    </button>
                  </td>
                </tr>
                <tr>
                  <td><h5>성별</h5>
                  <td>
                    <div class="inputs">
                      <label>남자</label>
                      <input class="radio" type="radio" name="gender" value="M" checked>
                      <label>여자</label>
                      <input class="radio" type="radio" name="gender" value="F">
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>

            <h5 style="color: red;" id="passwordCheckMessage"></h5>
            <button class="submit-btn" type="submit">가입하기

          </form>
        </div>
      </section>

	
	<!-- app -->
	<script src="../resources/js/dropdown-menu.js"></script>
</body>
</html>
