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
#int_subj {
	
	font-size:2.5em;
	text-align: -webkit-center
}
.report_content{

}
tbody{
margin-right:30px;
}
</style>
<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">

			<div id="int_wrap">Carrot Mart</div>
			<hr>


			<div id="int_subj">Report</div>
			<div class="report_content">
				<table>
					
					<tr>
						<td>아이디 :</td>
						<td>${ㅇㅇ}</td>
					</tr>
					<tr>
						<td>신고날짜 :</td>
						<td>날짜요~</td>
					</tr>
					<tr>
						<td>제 목 :</td>
						<td><input type="text" name="rep_subj" id="rep_subj"
							placeholder="제목을 입력해주세요"></td>
					</tr>

					<tr>
						<td>신고내용 :</td>
						<td><textarea></textarea></td>
					</tr>


				</table>
			</div>

			<div class="clearfix">
				<input type="button" value="전송" id="send"> <input
					type="button" value="리셋" id="reset">
			</div>
		</div>



		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>