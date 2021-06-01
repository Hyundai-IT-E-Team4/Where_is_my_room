window.onload = ()=>{
	
	window.wsocket;
	window.userId = document.getElementById('user-id').value; // 접속한 사용자 아이디
	window.lastChatId = 16;  //채팅방의 마지막 읽은 채팅방 번호
	window.findAll = false; // 채팅방 다 찾았는지 여부
	window.messageId = 0;
	
	connect();
	
	getMessageList();
	
	$('.list-btn').hide();
	$('.delete-btn').hide();
	
	$(".submit_btn").click(function() {
		$(".message_input").focus();
		send();
	})
	
	$(".message_input").keydown(function(key){
		if(key.keyCode == 13){
			$(".message_input").focus();
			send();
		}
	});
	
	// 채팅 내역 스크롤 될 경우
	$(".message-log").scroll(()=> {
		if($(".message-log").scrollTop() == 0 && window.chatMessageFindAll == false){
			getMessageAppend();
		}	
	});
	
};


function connect() {
	window.wsocket = new WebSocket("ws://" + window.location.hostname + "/team4/messages/socket/"+ window.messageId);
	wsocket.onopen = onOpen;
	wsocket.onmessage = onMessage;
};

function disconnect() {
	wsocket.close();
};

function onOpen(evt) {
	console.log('socket connected');
};

function onMessage(evt) {
	let date = dateFormat(new Date());

	let data = evt.data;
	let parseData = data.split(":");
	
	if(parseData.length > 3) {
		let messageId  = parseData[0]
		let senderId   = parseData[1]
		let senderNick = parseData[2];
		let msg        = parseData[3];
		
		let plusMsg = '';
			
		if (senderId == window.userId) {
			
			plusMsg += '<div class="message-reverse">'
			        +  '	<div class="message-user-reverse">'    
		            +  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>' 
		            +  '	</div>'
		            +  '	<div class="message-content-reverse">'
		            +  '		<div class="message-info-reverse">'
		            +  '			<strong class="message-sender-reverse"> <a href="#">' + senderNick + '</a> </strong>'
		            +  '			<div class="message-timestamp-reverse">' + date + '</div> '
		            +  '		</div>'
		            +  '		<p class="message-text-reverse">' + msg + '</p>'
		            +  '	</div>'
		            +  '</div>'
		} else {
					plusMsg += '<div class="message">'
			        +  '	<div class="message-user">'    
		            +  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>' 
		            +  '	</div>'
		            +  '	<div class="message-content">'
		            +  '		<div class="message-info">'
		            +  '			<strong class="message-sender"> <a href="#">' + senderNick + '</a> </strong>'
		            +  '			<div class="message-timestamp">' + date + '</div> '
		            +  '		</div>'
		            +  '		<p class="message-text">' + msg + '</p>'
		            +  '	</div>'
		            +  '</div>'
		}

		
		$('.message-log').append(plusMsg);
		$('.message-log').scrollTop($('.message-log')[0].scrollHeight);
		
	} else{
		
		let message = evt.data.split(":");
		let command = message[0];
		let senderNick = message[1];
		let content = message[2];
		
		plusMsg = '';
		plusMsg += `	<div class="popup">`
		        +  '        <button class="closeBtn" onClick="closePopup($(this))">X</button>'
		        +  `		<p class="popup-title">📧새로운 ${command}</p>`
				+  `		<p class="popup-content">${senderNick} : ${content}</p>`
				+  '	</div>';
		
		$(".popup-container").append(plusMsg);
		$('.popup' + window.popupId).hide();
		$('.popup' + window.popupId).show("slow");
		
		setTimeout(()=>{
			$('.popup:first').remove();
		}, 5000);
	}

};

function onClose(evt) {
	console.log('socket disconnected');
};

function send() {
	let msg = $(".message_input").val();
	wsocket.send(window.partnerName + ":" + msg);
	$(".message_input").val("");
	window.lastChatMessageId += 1;
};


// 채팅방의 메세지 내역 보여주는 함수
function getMessage(messageId, startDate, partnerName) { 

	window.messageId = messageId;
	window.lastChatMessageId = 21; // 마지막으로 읽은 메시지 아이디
	window.chatMessageFindAll = false; // 채팅방의 메시지를 다 읽었는지
	window.partnerName = partnerName;
	
	if (window.wsocket != null) {
		disconnect();
	}
	
	connect();
	
	$('.chat-list').hide('slow');
	$('.chat-message').width('100%');
	$('.chat-form').width('100%');
	$('.list-btn').fadeIn('slow');
	$('.delete-btn').fadeIn('slow');
	$('.message-log').empty();
	
	$.ajax({
		url:'./detail',
		type:'get',
		data:{"messageId" : window.messageId, "startDate" : startDate},
		success:function(res) {

			let readList = res;
			
			window.startDate = startDate;
			
			if(readList.length < 20) {
				findLll = true;
			}
			
			let plusMsg = '';
			
			for(let i=0; i<readList.length; i++) {

				if(readList[i].senderId == userId) {
					plusMsg += '<div class="message-reverse">'
					        +  '	<div class="message-user-reverse">'    
	                        +  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>' 
	                        +  '	</div>'
	                        +  '	<div class="message-content-reverse">'
	                        +  '		<div class="message-info-reverse">'
	                        +  '			<strong class="message-sender-reverse"> <a href="#">' + readList[i].nickname + '</a> </strong>'
	                        +  '			<div class="message-timestamp-reverse">' + dateFormat(new Date(readList[i].sendDate)) + '</div> '
	                        +  '		</div>'
	                        +  '		<p class="message-text-reverse">' + readList[i].message + '</p>'
	                        +  '	</div>'
	                        +  '</div>'
	
				} else {
					plusMsg += '<div class="message">'
					        +  '	<div class="message-user">'    
	                        +  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>' 
	                        +  '	</div>'
	                        +  '	<div class="message-content">'
	                        +  '		<div class="message-info">'
	                        +  '			<strong class="message-sender"> <a href="#">' + readList[i].nickname + '</a> </strong>'
	                        +  '			<div class="message-timestamp">' + dateFormat(new Date(readList[i].sendDate)) + '</div> '
	                        +  '		</div>'
	                        +  '		<p class="message-text">' + readList[i].message + '</p>'
	                        +  '	</div>'
	                        +  '</div>'
				}
			}
			$('.message-log').append(plusMsg);
			window.lastChatId = readList[readList.length-1].rnum + 1;
			$('.message-log').scrollTop($('.message-log')[0].scrollHeight);
			$(".message_input").focus();
			
		}
	});

};

// 채팅방의 채팅내역을 추가로 불러오는 함수
function getMessageAppend() {
	
	let container = $('.message-log');
	
	$.ajax({
		url:'./detailappend',
		type:'get',
		data:{'messageId':window.messageId, 'lastChatId':window.lastChatMessageId, 'startDate':window.startDate},
		success:function(res) {
			
			let readList = res;
			if(readList.length < 20) {
				window.chatMessageFindAll = true;
			}
			
			let plusMsg = '';
			moveLength = readList.length;
			for(let i=0; i<readList.length; i++) {
				if(readList[i].senderId == window.userId) {
					plusMsg += '<div class="message-reverse">'
					        +  '	<div class="message-user-reverse">'    
	                        +  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>' 
	                        +  '	</div>'
	                        +  '	<div class="message-content-reverse">'
	                        +  '		<div class="message-info-reverse">'
	                        +  '			<strong class="message-sender-reverse"> <a href="#">' + readList[i].nickname + '</a> </strong>'
	                        +  '			<div class="message-timestamp-reverse">' + dateFormat(new Date(readList[i].sendDate)) + '</div> '
	                        +  '		</div>'
	                        +  '		<p class="message-text-reverse">' + readList[i].message + '</p>'
	                        +  '	</div>'
	                        +  '</div>'
	
				} else {
					plusMsg += '<div class="message">'
					        +  '	<div class="message-user">'    
	                        +  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>' 
	                        +  '	</div>'
	                        +  '	<div class="message-content">'
	                        +  '		<div class="message-info">'
	                        +  '			<strong class="message-sender"> <a href="#">' + readList[i].nickname + '</a> </strong>'
	                        +  '			<div class="message-timestamp">' + dateFormat(new Date(readList[i].sendDate)) + '</div> '
	                        +  '		</div>'
	                        +  '		<p class="message-text">' + readList[i].message + '</p>'
	                        +  '	</div>'
	                        +  '</div>'
				}
	
			}
			plusMsg += $('.message-log').html();
			window.lastChatHeight = $('.message-log')[0].scrollHeight;
			$('.message-log').html(plusMsg);
			$('.message-log').scrollTop($('.message-log')[0].scrollHeight - window.lastChatHeight);
			window.lastChatMessageId = readList[0].rnum + 1;
		}
	});
	
};

function getMessageList() {
	
	$('.message-list').empty();
	
	$.ajax({
		url:'./list',
		type:'get',
		success:function(res) {
		
		let readList = res;
		let plusMsg = "";
		for(let i =0 ; i < readList.length; i++){
			plusMsg += '<div class="message" onclick="getMessage(' + readList[i].messageId + ',\'' + dateFormat(new Date(readList[i].startDate)) + '\',\'' + readList[i].partnerName + '\'' + ')">'
					+  '	<div class="message-user">'
					+  '		<a href="#"> <img src="https://avatars.githubusercontent.com/u/50897259?v=4" alt="Profile Image" /> </a>'
					+  '	</div>'
					+  '	<div class="message-content">'
					+  '		<div class="message-info">'
					+  '			<strong class="message-sender"> <a href="#">' + readList[i].partnerName + '</a> </strong>'
					+  '			<div class="message-timestamp">' + dateFormat(new Date(readList[i].sendDate)) + '</div>'
					+  '		</div>'
					+  '		<p class="message-text">' + readList[i].message + '</p>'
					+  '    </div>'
					+  '</div>'
		}
		
		$('.message-list').append(plusMsg);
		}
	});
}

function listOpen() {
	getMessageList();
	window.messageId = 0;
	$('.chat-message').removeAttr("style");
	$('.chat-list').show("fast");
	$('.list-btn').fadeOut('slow');
	$('.delete-btn').fadeOut('slow')
	$('.message-log').empty();
	
	if (window.wsocket != null) {
		disconnect();
	}
	connect();
}

function deleteMsg() {
	$.ajax({
		url:"delete",
		type:"GET",
		data:{"messageId":window.messageId},
		success:function(res) {
			listOpen();
		}
	});
}

// 날짜 포매팅 함수
function dateFormat(date) {
    let month  = date.getMonth() + 1;
    let day    = date.getDate();
    let hour   = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();

    month  = month >= 10 ? month : '0' + month;
    day    = day >= 10 ? day : '0' + day;
    hour   = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
    second = second >= 10 ? second : '0' + second;

    return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
};
