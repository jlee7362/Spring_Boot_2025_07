<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>

<div>kakao Map api 데이터 확인 페이지</div>

<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width: 500px; height: 350px; margin: auto;"></div>
<p>
	<button class="btn btn-sm" onclick="setCenter()">지도 중심좌표 이동시키기</button>
	<button class="btn btn-sm" onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button>
</p>


<script>
	let tashuLat;
	let tashuLon;
</script>

<script>
	const API_KEY = ''; // Encoding된 키

	async function getTashuData() {
		const url = 'https://apis.data.go.kr/6300000/openapi2022/tasuInfo/gettasuInfo'
				+ '?serviceKey=' + API_KEY + '&pageNo=1&numOfRows=10';

		try {
			const response = await
			fetch(url);
			if (!response.ok) {
				throw new Error(`HTTP 오류! 상태 코드: ${response.status}`);
			}
			const data = await
			response.json();
			console.log("타슈 데이터:", data);
			console.log("타슈 데이터1 위도tashuLon:",
					data.response.body.items[0].loCrdnt);
			console.log("타슈 데이터1 경도tashuLat:",
					data.response.body.items[0].laCrdnt);
			tashuLat = data.response.body.items[0].laCrdnt;
			tashuLon = data.response.body.items[0].loCrdnt;

			initMap();
		} catch (e) {
			console.error("API 호출 실패:", e);
		}
	}
</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey="></script>
<script>
	var map;
	function initMap() {

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(tashuLat, tashuLon);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	}
	function setCenter() {
		// 이동할 위도 경도 위치를 생성합니다 
		var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);

		// 지도 중심을 이동 시킵니다
		map.setCenter(moveLatLon);
	}

	function panTo() {
		// 이동할 위도 경도 위치를 생성합니다 
		var moveLatLon = new kakao.maps.LatLng(tashuLat, tashuLon);

		// 지도 중심을 부드럽게 이동시킵니다
		// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		map.panTo(moveLatLon);
	}

	getTashuData();
</script>


<%@ include file="../common/foot.jspf"%>