<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="${contextPath}/resources/css/boarddetail.css" />
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/popup.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/modal.css" />

<!-- favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/img/favicon.ico"
	type="image/x-icon" />
<link rel="icon" href="${contextPath}/resources/img/favicon.ico" type="image/x-icon" />

<!-- app -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9dad515bc29f7c64e401203f2300d728&libraries=services"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="${contextPath}/resources/js/global.js"></script>
<script src="${contextPath}/resources/js/detail.js"></script>
<script src="${contextPath}/resources/js/modal.js"></script>
<script>
	let latitude = "${boardDetailDTO.latitude}";
	let longitude = "${boardDetailDTO.longitude}";
	let userNickname = "${userInfo.nickname}";
	let writerNickName = "${boardDetailDTO.writerNickName}";
	let writerId = "${boardDetailDTO.writerId}";
	let userId = "${userInfo.id}";
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
			<div class="title-container">
				<h1>${boardDetailDTO.title }</h1>
				<div class="profile-container">
					<p>${boardDetailDTO.writerNickName }</p>
					<c:if test="${boardDetailDTO.writerId != userInfo.id}">
						<button class="chat-btn" onclick="modal()">연락하기</button>
					</c:if>
				</div>
			</div>
			

			
			<div class="info-container">
				<div class="info-sub-container blue">
					<h7>양도가격</h7>
					<h1>월 ${boardDetailDTO.rentalFee} 만원</h1>
				</div>
				<div class="info-sub-container">
					<h7>종류</h7>
					<h1>${boardDetailDTO.roomType }</h1>
				</div>
				<div class="info-sub-container">
					<h7>구분</h7>
					<h1>${boardDetailDTO.contractType }</h1>
				</div>
			</div>
			
			<h2>상세 정보</h2>
			<hr style="border-width: 0.01px; margin-top: 10px; margin-bottom: 10px">
			<p>${boardDetailDTO.content }</p>
			
			<p style="margin-top: 20px; margin-bottom: 15px"><strong>위치 : </strong>${boardDetailDTO.address} &nbsp; ${boardDetailDTO.detailAddress}</p>
			<div id="map" style="width: 100%; height: 350px;"></div>
			<c:set var="len" value="${fn:length(boardDetailDTO.files)}" />
			<c:if test="${len > 0}">
				<div class="swiper-container">
					<p style="margin-top: 20px; margin-bottom: 15px"><strong>사진</strong></p>
					<div class="swiper-wrapper">
						<c:forEach var="file" items="${boardDetailDTO.files}">
							<div class="swiper-slide">
								<img src="${file.url}" title="${file.uploadFileName}"
									width="50%" height="50%">
							</div>
						</c:forEach>
					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
				</div>
				<script>
					var mySwiper = new Swiper('.swiper-container', {
						direction : 'horizontal',
						loop : true,
						pagination : {
							el : '.swiper-pagination'
						},
						navigation : {
							nextEl : '.swiper-button-next',
							prevEl : '.swiper-button-prev'
						}
					});
				</script>
			</c:if>

			<div class="banner-container">
				<div class="comment-banner">&#x1F4AC; 댓글&nbsp;&nbsp;&or;</div>
				<div>
					<button id="list" onClick="location.href=history.back()"><strong>목록으로</strong></button>
					<script>
						console.log("${userInfo.id}");
						console.log("${boardDetailDTO.writerId}");
					</script>
					<c:if
						test="${userInfo != null &&  userInfo.id == boardDetailDTO.writerId }">
						<button id="delete"><strong>삭제하기</strong></button>
						<button id="update"><strong>수정하기</strong></button>
					</c:if>
				</div>
			</div>
			<div class="comment-container">
				<div class="pagingBox"></div>


				<div class="paging">
					<ul class="paging-ul">
					</ul>
				</div>

				<div class="comment-write">
					<div class="comment-write-writer">${sessionScope.userInfo.nickname}</div>
					<textarea class="comment-write-form" placeholder="댓글을 입력해주세요."></textarea>
					<button class="comment-submit" onclick="commentSubmit($(this))">등록</button>
				</div>

			</div>





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

	<div id='modal' style="display: none">
		<h2>쪽지</h2>
		<textarea id="modal-text-area"></textarea>
		<div class="modal-button-container">
			<button id="modal-submit-btn">전송</button>
			<button id="modal-close-btn">취소</button>
		</div>
	</div>
	<script src="${contextPath}/resources/js/dropdown-menu.js"></script>
</body>
</html>