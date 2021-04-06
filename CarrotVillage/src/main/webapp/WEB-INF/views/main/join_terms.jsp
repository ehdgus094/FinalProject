<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
	margin: 0;
}

form {
	width: 490px;
	margin: 0;
}

#terms_wrap {
	padding: 20px;
}

h3 {
	padding: 0 0 10px 0;
	font-size: 15px;
	color: black;
	font-weight: 600;
	border-bottom: 2px solid orange;
	margin: 0;
}

input[type="checkbox"] {
	display: none;
}

input[type="checkbox"]+label {
	display: inline-block;
	margin: 15px 0;
	width: 100%;
	font-size: 14px;
	cursor: pointer;
	height: 20px;
}

input[type="checkbox"]+label span {
	display: inline-block;
	width: 18px;
	height: 18px;
	margin: 1px 10px 0 0;
	vertical-align: middle;
	background:
		url(${pageContext.request.contextPath}/resources/image/nhj_unchecked.png)
		no-repeat;
	background-size: 18px 18px;
	cursor: pointer;
	float: right;
	border: none;
}

input[type="checkbox"]:checked+label span {
	background:
		url(${pageContext.request.contextPath}/resources/image/nhj_checked.png)
		no-repeat;
	border: none;
	background-size: 18px 18px;
}

#chk_all_wrap {
	border-bottom: silver 1px solid;
	height: 50px;
}

textarea {
	overflow: auto;
	padding: 20px;
	width: 100%;
	height: 150px;
	background: #fff;
	border: 1px solid #d8d9df;
	font-size: 12px;
	color: #98989f;
	line-height: 1.6em;
	resize: none;
}
textarea:focus {
	outline: orange .1em solid;
}
button {
	background:silver;
	color:white;
	width:100%;
	border:none;
	border-radius:3px;
	height:45px;
	font-size:18px;
	font-weight:400;
}
button:focus {
	outline:none;
}
#terms_wrap > div:nth-child(5) {
	margin-top: 30px;
}
</style>
<script>
	$(document).ready(function() {
		
		var check = false;
		
		$("#chk_all").change(function() {
			
			if ($(this).prop("checked")) {
				$(".chk").prop("checked", true);
				check = true;
				$("button").css("background", "orange");
			} else { 
				$(".chk").prop("checked", false);
				check = false;
				$("button").css("background", "silver");
			}
			
		});
		$(".chk").change(function() {
			
			if ($("#chk1").prop("checked") === true && $("#chk2").prop("checked") === true) {
				$("#chk_all").prop("checked", true);
				check = true;
				$("button").css("background", "orange");
			} else {
				$("#chk_all").prop("checked", false);
				check = false;
				$("button").css("background", "silver");
			}
			
		});
		
		$('form').submit(function() {

			if (!check) {
				alert('회원가입 약관의 내용에 동의하셔야 회원가입 하실 수 있습니다.');
				return false;
			}

		});
       
	}); 
</script>
</head>
<body>
	<form action="${pageContext.request.contextPath}/main/join">
		<div id="terms_wrap">

			<div>
				<h3>약관 동의</h3>
			</div>

			<div id="chk_all_wrap">
				<input type="checkbox" id="chk_all">
				<label for="chk_all">회원가입 약관에 모두 동의합니다 <span></span></label>
			</div>


			<div>
				<div style="height: 50px;">
					<input type="checkbox" id="chk1" class="chk">
					<label for="chk1">이용약관 동의<a style="color: red;">&nbsp;(필수)</a> <span></span></label>
				</div>
				<div>
					<script>
						$.ajax({
				       		url : "${pageContext.request.contextPath}/resources/txt/이용약관.txt",
				        	dataType: "text",
				        	success : function (data) {
				            	$("#ta1").text(data);
				        	}
				    	});	
					</script>
					<textarea readonly id="ta1">
					</textarea>
				</div>
			</div>


			<div>
				<div style="height: 50px;">
					<input type="checkbox" id="chk2" class="chk"> 
					<label for="chk2">개인정보 수집 및 이용 동의<a style="color: red;">&nbsp;(필수)</a> <span></span></label>
				</div>
				<div>
					<script>
						$.ajax({
				       		url : "${pageContext.request.contextPath}/resources/txt/개인정보 수집 및 이용.txt",
				        	dataType: "text",
				        	success : function (data) {
				            	$("#ta2").text(data);
				        	}
				    	});	
					</script>
					<textarea readonly id="ta2"></textarea>
				</div>
			</div>


			<div>
				<button type="submit">다음</button>
			</div>

		</div>
	</form>



</body>
</html>