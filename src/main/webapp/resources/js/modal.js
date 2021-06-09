/**
 * 
 */
 
 function modal() {
    var zIndex = 9999;
    var modal = document.getElementById('modal');

    // 모달 div 뒤에 희끄무레한 레이어
    var bg = document.createElement('div');
    bg.setStyle({
        position: 'fixed',
        zIndex: zIndex,
        left: '0px',
        top: '0px',
        width: '100%',
        height: '100%',
        overflow: 'auto',
        // 레이어 색갈은 여기서 바꾸면 됨
        backgroundColor: 'rgba(0,0,0,0.4)'
    });
    document.body.append(bg);

    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    modal.querySelector('#modal-close-btn').addEventListener('click', function() {
        bg.remove();
        modal.style.display = 'none';
    });

    modal.setStyle({
        position: 'fixed',
        display: 'block',
        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

        // 시꺼먼 레이어 보다 한칸 위에 보이기
        zIndex: zIndex + 1,

        // div center 정렬
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        msTransform: 'translate(-50%, -50%)',
        webkitTransform: 'translate(-50%, -50%)'
    });
    
    document.getElementById('modal-submit-btn').addEventListener('click', function(){
      let message = $('#modal-text-area').val();
      $.ajax({ 
         url: "/team4/messages",
            method: "POST",
            data : { "message" : message, "userId1" : userId, "userId2" : writerId}
      }).done(function (data, textStatus, xhr) {
			Swal.fire({
			  title:'전송되었습니다.',
			  icon:'success'
			})
         bg.remove();
           modal.style.display = 'none';
           let sendData = {"command":"쪽지", "receiverName" : writerNickName, "content" : message};
         send(JSON.stringify(sendData));
      }).fail(function (data, textStatus, xhr){
			Swal.fire({
			  title:'전송 실패',
			  icon:'error'
			})
      });
	  $('#modal-text-area').val('');
   });
}

// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
Element.prototype.setStyle = function(styles) {
    for (var k in styles) this.style[k] = styles[k];
    return this;
};