/**
 * 
 */
$(document).ready(()=>{
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
	$('#showComments').on('click',()=>{
		$('#commentsContainer').html("댓글열림");
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
});

function getBoardNumber(){
	let url = location.href;
	return url.substring(url.lastIndexOf("/") + 1);
}
