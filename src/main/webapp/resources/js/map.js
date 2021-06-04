/**
 * 
 */
 
   window.addEventListener ("touchmove", function (event) { event.preventDefault (); }, {passive: false});
   // 장소를 검색하면 그 장소를 지도 중앙으로 이동

function searchPlaces() {
   event.preventDefault();
      var places = new kakao.maps.services.Places();
       var keyword = document.getElementById('keyword').value;
       if (!keyword.replace(/^\s+|\s+$/g, '')) {
		  alert('장소를 입력해주세요.');
          return false;
       }
       var callback = function(result, status) {
      if (status === kakao.maps.services.Status.OK) {
             var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
             map.setCenter(coords);
             map.setLevel(3, {
                animate : true
             });
          }
};
       
       places.keywordSearch(keyword, callback);
    }
    
    
    
    var map;
    
    
$(document).ready(()=>{
	var keyword = document.getElementById('keyword').value;
   var keywordbtn = document.getElementById('keyword-btn');
   if(keyword.length>0){
      keywordbtn.click();
   }
          var mapContainer = document.getElementById('map') // 지도를 표시할 div 
      var mapOption = {
         center : new kakao.maps.LatLng(37.565372333169925 , 126.9725291823543), // 지도의 중심좌표
         level : 4
      };
      // 지도 생성
       var maps = new kakao.maps.Map(mapContainer, mapOption);
       map=maps;
         // 마커 클러스터러 생성
        var clusterer = new kakao.maps.MarkerClusterer({
         map : map, 
         averageCenter : true, 
         minLevel : 1,
     styles: [{ // calculator 각 사이 값 마다 적용될 스타일을 지정한다
                width : '30px', height : '30px',
                background: 'rgba(51, 204, 255, .8)',
                borderRadius: '15px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '31px'
            },
            {
                width : '40px', height : '40px',
                background: 'rgba(255, 153, 0, .8)',
                borderRadius: '20px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '41px'
            },
            {
                width : '50px', height : '50px',
                background: 'rgba(255, 51, 204, .8)',
                borderRadius: '25px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '51px'
            },
            {
                width : '60px', height : '60px',
                background: 'rgba(255, 80, 80, .8)',
                borderRadius: '30px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '61px'
            }
        ]
});
       
       
       // 지도 이동 및 변경 이벤트 리스너
      kakao.maps.event.addListener(map, 'tilesloaded', function() {
         var level = map.getLevel();
         var myLocation = map.getCenter();
         var bounds = map.getBounds();
         
         var swLatLng = bounds.getSouthWest();
         var neLatLng = bounds.getNorthEast();
         
         getNearLocation(swLatLng, neLatLng);

         
      });
      
      function getNearLocation(swLatLng, neLatLng) {
          var reqUrl = "map/" + swLatLng.getLat() + "/" + swLatLng.getLng() + "/" + neLatLng.getLat() + "/" + neLatLng.getLng()+"/";
         $.get(reqUrl, function(data) {
            datas = data;
            console.log(data);
            var markers = $(data.positions).map(
               function(i, position) {
                  return new kakao.maps.Marker({
                     position : new kakao.maps.LatLng(position.latitude, position.longitude)
                  });
            });
            console.log(data);
            // 목록 출력
            displayPlaces();
            // 기존 클러서터러 지우고 새롭게 추가
            clusterer.clear();
            clusterer.addMarkers(markers);

         });
      }

 	maps.relayout();
});



//document.ready 종료






  var datas;
      
            // 검색 결과 목록 표출하는 함수
      function displayPlaces() {

         var listEl = document.getElementById('placesList');
         var menuEl = document.getElementById('menu_wrap');
         
         var fragment = document.createDocumentFragment();
         var listStr = '';
         
         $('#pagination').pagination({
             dataSource: datas,
             locator: 'positions',
             pageSize: 8,
             autoHidePrevious: true,
             autoHideNext: true,
             callback: function (data, pagination) {
                removeAllChildNods(listEl);
                 $.each(data, function (index, item) {
                    $('#placesList').eq(0).append(getListItem(item));
                 });
             }
         })
            
        listEl.appendChild(fragment);
            menuEl.scrollTop = 0;         
      }
      
      function getListItem(place) {
          var el = document.createElement('li');
          let imgTag = (place.repreFile == null) ? '' : `<div class="info-img"><img src="${place.repreFile}"></div>`;
          var itemStr = `<div class="info-wrap" onclick='location.href="boards/${place.boardId}"'>`
			          +  	imgTag
                      + '	<div class="info-text">'
			          + `		<h1>월세&nbsp;${place.rentalFee}&nbsp;(만)원</h1>`
			          + `		<p>${place.contractType}/${place.roomType}</p>`
			          + `		<strong>${place.address}</strong>`
					  + `	</div>`
				      + `</div>`;
           console.log(place.address);
          el.innerHTML += itemStr;
          el.className = 'item';
          return el;
      }
     
   function removeAllChildNods(el) {   
          while (el.hasChildNodes()) {
              el.removeChild (el.lastChild);
          }
      }   