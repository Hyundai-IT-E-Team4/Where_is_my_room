$(document).ready(()=>{
	connect();
});

function connect() {
	window.wsocket = new WebSocket("ws://" + window.location.hostname + "/team4/messages/socket/0");
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
};

function onClose(evt) {
	console.log('socket disconnected');
};

function send(msg) {
	wsocket.send(msg);
};

function closePopup(obj) {
	obj.closest('div').remove();
}