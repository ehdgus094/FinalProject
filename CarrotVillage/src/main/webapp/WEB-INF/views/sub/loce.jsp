<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/loce.js"></script>
<head>
<meta charset="utf-8">
<title>현재 위치</title>
<style>
.map_wrap {
	position: relative;
	width: 100%;
	height: 350px;
}

.title {
	font-weight: bold;
	display: block;
}

.hAddr {
	position: absolute;
	left: 10px;
	top: 10px;
	border-radius: 2px;
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	z-index: 1;
	padding: 5px;
}

#centerAddr {
	display: block;
	margin-top: 2px;
	font-weight: normal;
}

.bAddr {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

div>img {
	width: 25px;
	height: 25px;
}

div>img:hover {
	cursor: pointer;
}
</style>
</head>
<body>

	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
		<div class="hAddr">
			<span class="title">지도중심기준 행정동 주소정보</span> <span id="centerAddr"></span>
		</div>
		<span id="fin_loc"></span><img
			src="<%=request.getContextPath()%>/resources/image/pjh_loc.JPG" id ="reloc">
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52c732afd14ae73c2cd9e58f251c5c38&libraries=services"></script>

</body>
</html>