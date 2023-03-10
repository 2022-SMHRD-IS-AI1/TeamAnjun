<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>userLocation</title>
<style type="text/css">
body, html {
	height: 100%;
}
</style>
</head>
<body>
	<div id="map" style="width: 100%; height: 100%;"></div>
	<form method="post"
		action="Main.jsp" id="gpsForm">
		<input type="hidden" id="lat" name="latitude" value="">
		<input type="hidden" id="lng" name="longitude" value="">
	</form>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca54d6e7a228681985539226b15919d4"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨 
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		var lat = null;
		var lon = null;

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도

				var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div style="padding:4px;"></div>'; // 인포윈도우에 표시될 내용입니다
				
				// 마커와 인포윈도우를 표시합니다
				displayMarker(locPosition, message);

			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

			displayMarker(locPosition, message);
		}

		// 마커 이미지의 주소
		var markerImageUrl = 'https://i.postimg.cc/xj3dRgxD/User-Location.png', 
		    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
		    markerImageOptions = { 
		        offset : new kakao.maps.Point(19, 41)// 마커 좌표에 일치시킬 이미지 안의 좌표
		    };

		// 마커 이미지를 생성한다
		var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);

		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				position : locPosition,
				map : map,
				image : markerImage
			// 마커이미지 설정 
			});

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(locPosition);

		}
		
	</script>

</body>
</html>