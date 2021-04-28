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
<style>

html, body {
	margin:0;
	height:100%;
}
#wrap {
	height:100%;
	width: 100%;
    display:grid;
    grid-template-rows: 175px auto 150px;
}
#content_wrap {
	width:1200px;
	margin:0 auto;
}
#content_title {
	width:100%;
	height:70px;
	padding:10px 0 0 5px;
	border-bottom:1px solid #545454;
}
#content_title > span {
	font-size:25px;
	color:#545454;
	display: block;
    margin: 5px 0 0 5px;
}

/*------------- 여기까지 고정 css 속성 -------------*/

#write_form {
	width: 1000px;
    margin: 40px auto;
}
#write_form > div:nth-child(1) {
	margin-top:25px;
}
#write_form > div:nth-child(1) span {
	display: block;
    font-size: 20px;
    font-weight: 600;
    color: orange;
    width: fit-content;
    margin-left: 3px;
}
#write_form > div:nth-child(3) {
	display:flex;
	flex-direction:column;
	margin-top:8px;
}
#write_form > div:last-child {
	display:flex;
	flex-direction:row-reverse;
}
#write_form input[type='text'] {
	border: silver 1px solid;
    border-radius: 5px;
    padding:6px;
}
#write_form textarea {
	margin-top:15px;
	border: silver 1px solid;
	resize:none;
	height:350px;
	padding:6px;
	focus:none;
}
#write_form textarea:focus {
	outline:none;
}
#write_form input[type="button"] {
	margin: 20px 0 0 10px;
    height: 38px;
    width: 70px;
    border-radius: 5px;
    border:1px solid silver;
    background:white;
    font-size:14px;
}
#write_form > div:last-child button[type="submit"] {
	margin: 20px 0 0 10px;
    height: 38px;
    width: 70px;
    border-radius: 5px;
	background: orange;
    border: none;
    color:white;
    font-size:14px;
}
</style>
<script>
	$(function() {
		var subjectCheck = false;
		var contentCheck = false;
		
		$("#write_form").submit(function() {
			
			if ($("input[name='subject']").val().length < 1) {
				alert("제목을 입력해주세요.");
				$("input[name='subject']").focus();
				return false;
			}
			
			if ($("input[name='content']").val().length < 1) {
				alert("내용을 입력해주세요.");
				$("input[name='content']").focus();
				return false;
			}
			
		});
		
	});
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
		<div id="content_title"><span>자유 게시판</span></div>
	
		<form action="${pageContext.request.contextPath}/board/writeProcess" method="post" id="write_form">
			<div><span>글 쓰기</span></div>
			<input type="hidden" name="member_id" value="${user_info.id}">
			<div>
				<input type="text" placeholder="제목을 입력해주세요." name="subject" maxlength="32" required>
				<textarea placeholder="내용을 입력해주세요." name="content" required></textarea>
			</div>
		
			<div>
				<button type="submit">등록</button>
				<input type="button" value="취소" onclick="window.history.back()">
			</div>
		
		</form>
		
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>