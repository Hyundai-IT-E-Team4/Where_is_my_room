/**
 * 
 */
 
 $(document).ready(()=>{
 
   window.addEventListener ("touchmove", function (event) { event.preventDefault (); }, {passive: false});
    var mapContainer = document.getElementById('map') // 지도를 표시할 div 
      var mapOption = {
         center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
         level : 4
      };
      // 지도 생성
       var map = new kakao.maps.Map(mapContainer, mapOption);
      
      var datas;
 
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
      
      
      
      
      
      var datas;
      
    
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
      
              // 커스텀 오버레이에 표시할 컨텐츠 입니다
// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
// 별도의 이벤트 메소드를 제공하지 않습니다 
var content = '<div class="wrap">' + 
            '    <div class="info">' + 
            '        <div class="title">' + 
            '            서울역' + 
            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="img">' +
            '           </div>' + 
            '            <div class="desc">' + 
            '                <div class="ellipsis">서울특별시 용산구 동자동 43-205</div>' + 
            '                <div class="jibun ellipsis"> 서울역은 서울특별시 용산구와 중구에 </div>' + 
            '                <div class="jibun ellipsis"> 위치한 민자역사 철도역이다. </div>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';
      
      
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
          var itemStr = `<div class="info" onclick='location.href="boards/${place.boardId}"'>` 	
           +'   <h5>' + place.title + '</h5>'
           +'   <h5>' + place.contractType + '</h5>'
           +'   <h5>' + place.roomType + '</h5>'
           +'   <h5>' + place.rentalFee + '</h5>'
           +'   <h5>' + place.nickName + '</h5>'
           +'   <h5>' + place.address + '</h5></div>';
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
      
     
 });
 
 // 장소를 검색하면 그 장소를 지도 중앙으로 이동
  function searchPlaces() {

         var keyword = document.getElementById('keyword').value;

         if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
         }

         geocoder.addressSearch(keyword, function(result, status) {
			 if (status === kakao.maps.services.Status.OK) {
               var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
               map.setCenter(coords);
               map.setLevel(7, {
                  animate : true
               });
            }
         });
      }

	 

      
      