// 날짜 포매팅 함수
function dateFormat(date) {
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hour = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
    second = second >= 10 ? second : '0' + second;

    return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
};


//채팅방의 메세지 내역 보여주는 함수
function getMessage(messageId) { 
	
	window.messageId = messageId;
	window.lastChatHeight = 0;
	
	window.lastChatMessageId = 21; // 마지막으로 읽은 메시지 아이디
	window.chatMessageFindAll = false; // 채팅방의 메시지를 다 읽었는지
	
	let userId = document.getElementById('user-id').value;
	
	$('.message-log').empty();
	
	const req = new XMLHttpRequest();
	let uri = './detail/' + messageId;
	req.open('GET', uri, true);
	req.send();
	
	req.onload = ()=>{
		
		let res = JSON.parse(req.responseText);
		
		let readList = res;
		console.log(readList);
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
		window.lastChatMessageId = readList[0].rnum + 1;
		console.log('getMessage에서 lastChatMessageId : ' + lastChatMessageId);
		console.log(readList);
		$('.message-log').scrollTop($('.message-log')[0].scrollHeight);
			
	}
	
};

// 채팅방의 채팅내역을 추가로 불러오는 함수
function getMessageAppend() {
	let userId = document.getElementById('user-id').value;
	let container = $('.message-log');
	
		
		if(window.chatMessageFindAll == false){
	
			const req = new XMLHttpRequest();
			let uri = './detail/' + window.messageId + '/' + window.lastChatMessageId;
			req.open('GET', uri, true);
			req.send();
			
			req.onload = ()=>{
				console.log('window.lastChatId' + window.lastChatId);
				console.log('window.findAll' + window.findAll);
				console.log('window.lastChatMessageId' + window.lastChatMessageId);
				console.log('window.chatMessageFindAll' + window.chatMessageFindAll);
				let res = JSON.parse(req.responseText);
				let moveLength = 0;
				let readList = res;
				if(readList.length < 20) {
					window.chatMessageFindAll = true;
				}
				let plusMsg = '';
				moveLength = readList.length;
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
				plusMsg += $('.message-log').html();
				window.lastChatHeight = $('.message-log')[0].scrollHeight;
				$('.message-log').html(plusMsg);
				$('.message-log').scrollTop($('.message-log')[0].scrollHeight - window.lastChatHeight);
				window.lastChatMessageId = readList[0].rnum + 1;
			}
		}
		
	
};

window.onload = ()=>{
	
	window.lastChatId = 16;  //채팅방의 마지막 읽은 채팅방 번호
	window.findAll = false; // 채팅방 다 찾았는지 여부

	
	//채팅방 목록 스크롤 될 경우
	$(".message-list").scroll(()=> {
		
		if($(".message-list").scrollTop() >= $(".message-list").prop('scrollHeight') - $(".message-list").innerHeight() && window.findAll == false){

			const req = new XMLHttpRequest();
			let uri = "./list/" + window.lastChatId;
			req.open('GET', uri, true);
			req.send();
			
			req.onload = ()=>{
				
				let res = JSON.parse(req.responseText);
			
				let readList = res;
				if(readList.length < 15){
					window.findAll = true;
				}
				let plusMsg = "";
				for(let i =0 ; i < readList.length; i++){
					plusMsg += '<div class="message" onclick="getMessage(' + readList[i].messageId + ')">'
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
				
				window.lastChatId = readList[readList.length-1].rnum + 1;
				
			}	
		}
	});
	
	// 채팅 내역 스크롤 될 경우
	$(".message-log").scroll(()=> {
		if($(".message-log").scrollTop() == 0 && window.chatMessageFindAll == false){
			getMessageAppend(window.messageId, window.lastChatMessageId);
		}	
	});
	
};
