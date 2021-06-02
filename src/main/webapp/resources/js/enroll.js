/**
 * 
 */
$(document).ready(()=>{
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};
	window.fileCnt = 1;
	window.map = new kakao.maps.Map(container, options);
	window.geocoder = new kakao.maps.services.Geocoder();
	//마커 클릭 이벤트를 통해 좌표 설정
	kakao.maps.event.addListener(window.map, 'click', function(mouseEvent) {        
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    window.marker.setPosition(latlng);
	    setLoc(latlng.getLat(), latlng.getLng());
	});
	
	$("a[name='delete']").on("click",function(e){
        e.preventDefault();
        fileDelete($(this));
    });
    $("#add").on("click",function(e){
        e.preventDefault();
        fileAdd();
    });

});
 
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            
            window.geocoder.addressSearch(addr, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        console.log(coords);
				setLoc(coords.getLat(), coords.getLng());
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        window.marker = new kakao.maps.Marker({
		            map: window.map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        /*var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
		        });*/
		        //infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
            
            // 커서를 상세주소 필드로 이동한다.
            //document.getElementById("detailAddress").focus();
        }
    }).open();
}

function setLoc(lat, lon){
	$('#latitude').val(lat);
	$('#longitude').val(lon);
}

function fileDelete(obj){
    obj.parent().remove();
}

function fileAdd(){
    let str = "<p><input type='file' name='file_"+(fileCnt++)+"' class='input-label'/><a href='#this' name='delete' class='delete-btn'>사진 삭제하기</a></p> ";
    $("#fileContainer").append(str);
     $("a[name='delete']").on("click",function(e){
        e.preventDefault();
        fileDelete($(this));         
    })
} 