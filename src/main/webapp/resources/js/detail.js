/**
 * 
 */
$(document).ready(()=>{
	window.replyContainer = '';
	let commentsPageNum = 1;
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(latitude, longitude),
		level: 3
	};
	let map = new kakao.maps.Map(container, options);
	let marker = new kakao.maps.Marker({
			map: map,
			position: new kakao.maps.LatLng(latitude, longitude)
			});
	window.commentPage = 1;
	
	
	$('.comment-banner').on('click',()=>{
		if($('.comment-container').css("display") == "none"){
			$('.comment-container').show();
			window.commentPage = 1;
			getCommentList(1);
		} else{
			$('.comment-container').hide();
		}
	});
	$('#delete').on('click',()=>{
		$.ajax({
			url: "/team4/boards/" + getBoardNumber(),
            method: "DELETE"
		}).done(function (data, textStatus, xhr) {
		    switch(xhr.status){
		        case 204:
		        	location.href="/team4";
		            break;
    		}
		}).fail(function (data, textStatus, xhr){
			alert("권한이 없습니다");
		});
	});
	
	$('#update').on('click',()=>{
		location.href= "/team4/boards/update/"+getBoardNumber();
	});
	
});

function getBoardNumber(){
	let url = location.href;
	return url.substring(url.lastIndexOf("/") + 1);
}

function getCommentList(pageNum){
	//$('.comment-container').empty();
	$('.pagingBox').empty();
	$('.paging-ul').empty();
	window.commentPage = pageNum;
	$.ajax({ 
			url: "/team4/boards/" + getBoardNumber() + "/comments",
            method: "GET",
            data : {page : pageNum}
		}).done(function (data, textStatus, xhr) {
			setPagingComment(data);
			setPagingButton(data, pageNum);		
		}).fail(function (data, textStatus, xhr){
			alert("댓글 읽기 중 에러가 발생했습니다");
		});
}

function replyBtn(obj){
	let id = obj.closest('.comment-btn').find('input[name=id]').val();
	if(!!$('#replyForm')){
		$('#replyForm').remove();
	}
	let replyTag = ` <div class="comment-write" id="replyForm"> <input type="hidden" name="parentId" value="${id}">`
					+ '<textarea class="comment-write-form" placeholder="대댓글을 입력해주세요."></textarea>'
					+ '<button class="comment-submit" onclick="replySubmit($(this))">등록</button>'
					+ '<button class="reply-cancel" onclick="replyCancel($(this))">취소</button>';					
					+ '</div>';
	obj.parent().parent().parent().after(replyTag);
}

function modifyBtn(obj){
	let id = obj.closest('.comment-btn').find('input[name=id]').val();
	if(!!$('#modifyForm')){
		$('#modifyForm').parent().html(window.originalInfo);
	}
	let originalText = obj.parent().parent().next().html();
	window.originalInfo  = obj.parent().parent().parent().html();
	let modifyTag = ` <div class="comment-write" id="modifyForm"> <input type="hidden" name="id" value="${id}">`
					+ `<textarea class="comment-write-form" placeholder="수정할 내용을 입력해주세요.">${originalText}</textarea>`
					+ '<button class="comment-submit" onclick="modifySubmit($(this))">등록</button>'
					+ '<button class="reply-cancel" onclick="modifyCancel($(this))">취소</button>';					
					+ '</div>';
	obj.parent().parent().parent().html(modifyTag);
}

function deleteBtn(obj){
	let id = obj.closest('.comment-btn').find('input[name=id]').val();
	$.ajax({
			url: "/team4/boards/" + getBoardNumber() + "/comments/" + id,
            method: "DELETE"
		}).done(function (data, textStatus, xhr) {

		}).fail(function (data, textStatus, xhr){
			alert("권한이 없습니다");
		});
}

function replyCancel(obj){
	obj.parent().remove();
}

function commentSubmit(obj){
	let content = obj.parent().find('textarea').val();
	if(valueCheck(content)){
		$.ajax({
			url: "/team4/boards/" + getBoardNumber() + "/comments",
            method: "POST",
            data : {"content" : content}
		}).done(function (data, textStatus, xhr) {
			if(userNickname != writerNickName){
				let msg = `댓글:${writerNickName}:<a href="/team4/boards/${getBoardNumber()}">새로운 댓글을 달았습니다.</a>`;
				send(msg);
			}
		    location.reload();
		}).fail(function (data, textStatus, xhr){
			alert("권한이 없습니다");
		});	
	}
}

function replySubmit(obj){
	let content = obj.parent().find('textarea').val();
	let parentId = obj.parent().find('input').val();
	let commentWriterName = obj.parent().prev().children('.comment-top').children('.comment-writer').html();
	commentWriterName = commentWriterName.trim();
	if(valueCheck(content)){
		$.ajax({
			url: "/team4/boards/" + getBoardNumber() + "/comments",
            method: "POST",
            data : {"content" : content, "parentId" : parentId}
		}).done(function (data, textStatus, xhr) {
			if(userNickname != commentWriterName){
				let msg = `댓글:${writerNickName}:<a href="/team4/boards/${getBoardNumber()}">새로운 대댓글을 달았습니다.</a>`;
				send(msg);
			}
		    location.reload();
		}).fail(function (data, textStatus, xhr){
			alert("권한이 없습니다");
		});
	}
}

function setPagingComment(data){
	let str = "";
	let tabStr = '';
	let childTag = "child";
	let tag= '';
	let replyTag = '    <button class="comment-reply-btn" onclick="replyBtn($(this))">댓글</button>';
	let rt = '';
	let dt = '';
	let mt = '';
	for(let i = 0; i < data.length; i++){
		if(data[i].parentId > 0) {
			tag = childTag;
			rt = '';					
		} else if(data[i].deleted == 1){
			tag = '';
			rt = '';
		} else {
			tag = "";
			rt = replyTag;
		}
		if(userNickname == data[i].nickname){
			mt = '    <button class="comment-modify-btn" onclick="modifyBtn($(this))">수정</button>';
			dt = '    <button class="comment-delete-btn" onclick="deleteBtn($(this))">삭제</button>';
		} else{
			mt = '';
			dt = '';
		}
		str +=
		 `<div class="comment ${tag}">`
		+ '<div class="comment-top">'
		+ '  <div class="comment-writer">'
		+ `      ${data[i].nickname}`
		+ '  </div>'
		+ '  <div class="comment-btn">'
		+ rt
		+ mt
		+ dt
		+ `    <input type='hidden' name="id" value=${data[i].id}>  <input type="hidden" name="parentId" value=${data[i].parentId}>`
		+ '  </div>'
		+ '</div>'
		+ '<div class="comment-mid">'
		+ `${data[i].content}` 
		+ '</div>'
		+ '<div class="comment-bottom">'
		+ '  <div class="comment-time">'
		+ `${data[i].commentDate}`
		+ '  </div>'
		+ '  <hr>'
		+ '</div>'
		+ '</div>'
	}
	//$('.comment-container').prepend(str);
	$('.pagingBox').append(str);
}

function setPagingButton(data, page){
	console.log(data);
	if(data.length == 0) return;
	let totalCount = data[0].totalCount;
	let totalEndPage = Math.ceil(data[0].totalCount / 10);
	let startPageNum = Math.floor((page - 1) / 5) + 1;
	let str = "";
	let prev = Math.floor((page - 1) / 5) * 5; 
	let nnext =  (Math.floor((page - 1) / 5) + 1) * 5  + 1;
	if(havePrevButton(page)) str += `<li class="paging-move" onclick="getCommentList(${prev})">이전</li>`;
	for(let i = startPageNum; i < startPageNum + 5 && i <= totalEndPage; i++){
		str += `<li class="paging-btn" onclick="getCommentList(${i})">${i}</li>`;
	}
	if(haveNextButton(page, totalEndPage)) str += `<li class="paging-move" onclick="getCommentList(${nnext})">다음</li>`;
	console.log(str);
	$('.paging-ul').append(str);
}


function havePrevButton(page) {
	console.log(page);
	console.log(Math.floor((page-1)/5));
	let key = Math.floor((page-1)/5);
	return (key != 0);  // 0 != 0 ---> false
}

function haveNextButton(page, lastPage) {
	return (Math.floor((page - 1) /5 ) != Math.floor((lastPage - 1) /5 ));
}

function modifyCancel(obj){
	obj.parent().parent().html(window.originalInfo);
}


function modifySubmit(obj){
	let id = obj.parent().find('input').val();
	let content = obj.parent().find('textarea').val();
	$.ajax({
			url: "/team4/boards/" + getBoardNumber() + "/comments/" + id,
            method: "POST",	
            data : {"content" : content}
		}).done(function (data, textStatus, xhr) {
		    location.reload();
		}).fail(function (data, textStatus, xhr){
			alert("권한이 없습니다");
		});
}

function valueCheck(str){
	if(str == '') {
		alert("내용을 입력하세요!");
		return false;	
	}
	return true;
}

function contact(){
	let minId = Math.min(writerId, userId);
	let maxId = Math.max(writerId, userId);
	$.ajax({
			url: "/team4/messages/",
            method: "POST",	
            data : {"minId" : minId, "maxId" : maxId}
		}).done(function (data, textStatus, xhr) {
		    location.reload();
		}).fail(function (data, textStatus, xhr){
			alert("권한이 없습니다");
		});
}