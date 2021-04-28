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

</head>
<style>
#ww{
text-align:center;
margin-top:200px;
margin-bottom:200px
}
#ww > img{
    width: 40px;
    padding-right: 0px;
    margin-right: 20px;
}
   .form-button {
	text-align: center;
	margin: 40px 0px 40px 0px
}

</style>
<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">
		<div id="int_wrap">Carrot Mart</div>
			<hr>
			
			<h3 id="ww" ><img src="${pageContext.request.contextPath}/resources/image/kdh_cancel.png">주문에 실패하였습니다<br>처음부터 다시 주문해주세요</h3>
		
			<hr>
			<div class="form-button ">
			<button type="button" class="btn btn-primary"
						onclick="location.href='submarket'"
						id="Modify">메인으로 돌아가기</button>
					
			
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>