<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" href="../resources/css/chat.css" />

<!-- favicon -->
<link rel="shortcut icon" href="../resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="../resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="../resources/js/message.js" ></script>

</head>
<body>
	<input type="hidden" value="${sessionScope.userInfo.id}" id="user-id"/>
	<input type="hidden" value="${sessionScope.userInfo.nickname}" id="user-nick"/>
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
						반갑습니다 :) <strong>${sessionScope.userInfo.name}</strong> 님
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

	<section class="chatting">
		<div class="container">
			<div class="chat">

				<div class="chat-list">
					<h2>쪽지함</h2>

					<div class="items scroll message-list" id="autoScroll">

						<c:forEach var="msgr" items="${messageRoomList}">
							<script>
								window.messageId = ${msgr.messageId}; 
								window.userId = ${sessionScope.userInfo.id};
								connect();
							</script>
							<div class="message" onclick="getMessage(${msgr.messageId})">
								<div class="message-user">
									<a href="#"> <img
										src="https://avatars.githubusercontent.com/u/50897259?v=4"
										alt="Profile Image" />
									</a>
								</div>
								<div class="message-content">
									<div class="message-info">
										<strong class="message-sender"> <a href="#">${msgr.partnerName}</a>
										</strong>
										<div class="message-timestamp">
											<fmt:formatDate value="${msgr.sendDate }" pattern="yyyy-MM-dd hh:mm:ss"/>
										</div>
									</div>
									<p class="message-text">${msgr.message}</p>
								</div>
							</div>
						</c:forEach>

					</div>
				</div>

				<div class="chat-message">
					<h2>내용</h2>

					<div class="items scroll message-log" id="autoScroll">

					</div>

					<div class="chat-form">
							<input class="message_input" type="text" placeholder="메시지를 입력하세요">
							<input class="submit_btn" type="button" value="전송">

					</div>

				</div>
			</div>
		</div>
	</section>


	<!-- app -->
	<script src="../resources/js/dropdown-menu.js"></script>
</body>
</html>
