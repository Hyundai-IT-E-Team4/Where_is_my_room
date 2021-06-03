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
<link rel="stylesheet" href="${contextPath}/resources/css/withdraw.css" />

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
         <div class="withdraw">
            <form method="post" action="findPassword">
               <h1>비밀번호 찾기</h1>
               <div class="input">
                  <div class="label">
                     <label>이름</label>
                  </div>
                  <input type="text" name="name" placeholder="이름" autocomplete="off">
               </div>
               <div class="input">
                  <div class="label">
                     <label>가입한 이메일</label>
                  </div>
                  <input type="email" name="email" placeholder="이메일" autocomplete="off">
               </div>
               <div class="rules">
                  <p>
                     ※ 탈퇴할 계정으로 로그인한 후, 비밀번호를 입력하세요.<br> 
                     ※ 탈퇴 시, 계정 개인 정보가 삭제됩니다.
                  </p>
               </div>
               <input type="submit" value="비밀번호 찾기">
            </form>
         </div>
      </div>
   </section>

   <!-- app -->
   <script src="${contextPath}/resources/js/dropdown-menu.js"></script>
</body>
</html>