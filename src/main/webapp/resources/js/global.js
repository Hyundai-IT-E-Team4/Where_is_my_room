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
   console.log(evt.data);
   let receiveData = JSON.parse(evt.data);
   let message = evt.data.split(":");
   let command = receiveData.command;
   let senderNick = receiveData.senderNick;
   let content = receiveData.content;
   plusMsg = '';
   plusMsg += `   <div class="popup">`
           +  '        <button class="closeBtn" onClick="closePopup($(this))">X</button>'
           +  `      <p class="popup-title">📧새로운 ${command}</p>`
         +  `      <p class="popup-content">${senderNick} : ${content}</p>`
         +  '   </div>';
   
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