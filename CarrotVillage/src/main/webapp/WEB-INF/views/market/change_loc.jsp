<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=18a58432c8c3b67a9b0539cabeaae472&libraries=services"></script> <!-- 카카오 지도 api -->
<style>
	#map {width:100%; height:599px}
</style>
<script>
$(document).ready(function() {
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	var mapOption = { 
	        center: new kakao.maps.LatLng(${latitude}, ${longitude}), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨 
	    }; 
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	var locPosition = new kakao.maps.LatLng(${latitude}, ${longitude}); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
   	var message = '<div style="padding:5px;">내 위치</div>'; // 인포윈도우에 표시될 내용입니다
	var markers = [];
   	var infowindows = [];
   	
   	setMarker(locPosition, message);
   	
	// 지도를 클릭했을때 클릭한 위치에 마커를 추가하도록 지도에 클릭이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		// 이전 마커를 제거합니다
		hideMarker();
		// 클릭한 위치에 마커를 표시합니다 
		setMarker(mouseEvent.latLng, '<div><button id=change_loc>변경하기</button></div>');             
	});
	
	$('#map').on('click', '#change_loc', function() {
		//지도에서 변경하기 버튼 클릭시
	});
	
	function setMarker(location, message) {
		var marker = new kakao.maps.Marker({
        	map : map,
        	position : location
        });
        var infowindow = new kakao.maps.InfoWindow({
        	content : message,
        	removable : true
        });
        infowindow.open(map, marker);
        markers.push(marker);
        infowindows.push(infowindow);
	}
	
	function hideMarker() {
		markers[markers.length-1].setMap(null);
		infowindows[infowindows.length-1].close();
	}
});
</script>
</head>
<body>
	<div id=map_wrap>
		<div id=map></div>
	</div>
</body>
</html>