<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/css/pjh_submain.css"
	rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pjh_addmart.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<style>
#martlistadd {
	font-size: 1.5em;
	text-align: center
}

#content_wrap > form > div.martlistifo > p > label > input[type=text]{
	width: 800px;
}

lable {
	display: block;
}

.martlistifo {
	text-align: center;
	font-size: 1.3em;
}

.clearfix {
text-align: center
}
#content_wrap > form > div.martlistifo > p:nth-child(2) > label > input[type=text]:nth-child(1){
width: 700px;
}
</style>

<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">
			<div id="int_wrap">Carrot Mart</div>
			<hr>
			<form action="addmartPro" method="post">
				<div id="martlistadd">시장목록추가하기</div>
				<hr>
				<div class="martlistifo">
					<p>
						<label for="martname">시장 이름&emsp; :&emsp; <input
							type="text" name="martname" placeholder="OO시장의 형식으로 작성해주세요" required >
						</label>
					</p>
					<p>

						<label for="martloc">시장 주소&emsp; :&emsp; <input
							type="text" name="martloc" id="martloc" required>
							 <input type="button" value="주소검색" id="postcode">
							
						</label>
					</p>
					<p>

						<label for="mart_delloc">배달 지역&emsp; :&emsp; <input
							type="text" name="mart_delloc"placeholder="구단위로 작성해주세요" required>
						</label>
					</p>
					<p>

						<label for="mart_deltime">배달 시간&emsp; :&emsp; <input
							type="text" name="mart_deltime" required>
						</label>
					</p>

					<p>
						<label for="mart_delpri">배달 비용&emsp; :&emsp; <input
							type="text" id="mart_delpri" name="mart_delpri" required>
						</label>
					</p>



				</div>
				<hr>
				<div class="clearfix">
					<button class="btn btn-primary" type="submit">등록</button>
					<button class="btn btn-danger" type="reset">취소</button>
				</div>
			</form>
		</div>
		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>