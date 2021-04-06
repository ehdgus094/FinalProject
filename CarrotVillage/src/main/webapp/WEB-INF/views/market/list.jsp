<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지 - 중고마켓</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
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

/*------------- 여기까지 고정 css 속성 -------------*/

#content_wrap {margin-top:20px}

#content_header {
	display:flex;
	justify-content:center;
}

#content_function {
	display:grid;
	grid-template-columns:1fr 1fr 1fr;
	margin:30px 0
}

#search {
	display:flex;
	justify-content:center;
	border-radius:20px;
	border:1px solid silver;
	padding:10px
}

#search > input {
	border:0;
	width:100%;
	background:none;
	padding:0
}

#search img {width:30px}

#sell {display:flex; justify-content:flex-end}

#content_body {
	display:grid;
	grid-template-columns:1fr 1fr 1fr 1fr;
	column-gap:3%;
}

#content_wrap button {border:0; background:none; padding:0}

#sell>button {
	background:orange;
	border-radius:20px;
	padding:10px;
	color:white
}

#content_wrap button:focus, #search input:focus {outline:0}

#content_body>div {
	opacity:0;
	margin-bottom:10%;
	position:relative;
	top:20px
}

#content_body img {
	width:100%;
	height:273px;
	border-radius:20px;
}

#content_body>div>* {margin-bottom:5px}
</style>
<script>
$(document).ready(function() {
	function show_gradually(index) {
		
		if($('.article:nth-child('+index+')').length > 0) {
			$('.article:nth-child('+index+')').animate(
					{
						opacity : 1,
						top : 0
					}, 200, 'linear', function() {
				show_gradually(index+1);
			});
		}
	}
	show_gradually(1);
	
	$('#sell>button').click(function() {
		location.href="${pageContext.request.contextPath}/market/sell";
	})
});
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
		<h2 id=content_header>
			중고 마켓
		</h2>
		<div id=content_function>
			<div></div>
			<div id=search>
				<input type=text placeholder="검색어를 입력해주세요.">
				<button><img src="${pageContext.request.contextPath}/resources/image/kdh_search.png"></button>	
			</div>
			<div id=sell><button>판매하기</button></div>
		</div>
		<div id=content_body>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
			<div class=article>
				<img src="${pageContext.request.contextPath}/resources/image/kdh_sample.jpg">
				<div>제목</div>
				<div>가격</div>
				<div>위치</div>
			</div>
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>