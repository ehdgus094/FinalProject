<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
	margin:0;
}
form {
	width:490px;
	margin:0;
}
button {
	cursor:pointer;
}
#login_wrap {
	width:420px;
	height:560px;
	padding:30px;
	margin:auto;
}
#login_header {
	height:15%;
}
#login_header p {
	font-size:25px;
	color:orange;
	text-align:center;
}
#login_content {
	height:55%;
}
#login_content input[type='text'], #login_content input[type='password'] {
	border:none;
	width:70%;
	height:40px;
}
#login_content input[type='text']:focus, #login_content input[type='password']:focus {
	outline:none;
}
#login_content > div:nth-child(1) > div:nth-child(1),
#login_content > div:nth-child(1) > div:nth-child(3) {
	border-bottom: silver 2px solid;
    margin: 5px 0;
    padding: 0 10px;
}
#login_content > div:nth-child(1) > div > div {
	width:30%;
}
#login_content > div:nth-child(2) {
	margin:12px 0;
	height: 40px;
}
#stay_signed_in {
	width:15px;
	height:15px;
	margin-bottom: 3px;
}

#login_content > div:nth-child(3) {
	margin:20px 0;
}
#login_btn {
	background:orange;
	color:white;
	width:100%;
	border-radius:3px;
	border:1px orange solid;
	height:45px;
	font-size:18px;
	font-weight:400;
}
#login_content > div:nth-child(3) > button:focus {
	outline:none;
}
#login_content > div:nth-child(4) {
	width:100%;
	display:flex;
	justify-content:space-between;
}
#login_content > div:nth-child(4) a {
	font-size:13px;
	text-decoration:none;
	color:silver;
}
#login_content > div:nth-child(4) a:hover {
	color:black;
	text-decoration:underline;
}
#login_content input::placeholder {
	color:silver;
	font-weight:400;
	letter-spacing:1px;
}
#login_other {
	height:30%;
	display:flex;
	flex-direction:column;
}
#login_other button {
	background:white;
	width:100%;
	border-radius:3px;
	border:1px #a7a7a7 solid;
	height:45px;
	font-size:18px;
	margin:3px 0;
	text-align:center;
	color:#505050;
	font-weight: 100;
}
#login_other button > img {
	float:left;
}
#naver_id_login img:nth-child(2) {
	display:none;
}
#naver_id_login{
	height: 42px;
	width:100%;
	margin-bottom:5px;
}
#kakao_id_login {
	margin-top:5px;
	height: 40px;
	border: solid 1px #a0a0a0;
	display: flex;
    flex-direction: row;
    border-radius: 3px;
    cursor:pointer;
}
#kakao_id_login:hover {
	background:#f3f3f3;
}

#naver_id_login_anchor {
	border: solid 1px #a0a0a0;
	background:white;
    display: flex;
    flex-direction:row;
    width:360px;
   	height: 40px;
    border-radius: 3px;
}
#naver_id_login_anchor:hover {
	cursor:pointer;
	text-decoration:none;
	background:#f3f3f3;
}
#naver_id_login_anchor p,
#kakao_id_login p {
	font-size:18px;
	margin: 5px 45px;
	color:#505050;
}
#naver_logo {
	display:block;
	width:30px;
	height:30px;
	margin:5px;
}
#kakao_logo {
	display:block;
	width:30px;
	height:25px;
	margin:7px 5px;
}
input[type="checkbox"] {
	display: none;
}

input[type="checkbox"]+label {
	display: inline-block;
	width: 100%;
	font-size: 13px;
	cursor: pointer;
	height: 20px;
	margin: 0 0 0 7px;
    color: #4a4a4a;
}

input[type="checkbox"]+label span {
	display: inline-block;
	width: 18px;
	height: 18px;
	margin: 1px 10px 3px 0;
	vertical-align: middle;
	background:url(${pageContext.request.contextPath}/resources/image/nhj_unchecked.png) no-repeat;
	background-size:18px 18px;
	cursor: pointer;
	border:none;
}

input[type="checkbox"]:checked+label span {
	background:url(${pageContext.request.contextPath}/resources/image/nhj_checked.png) no-repeat;
	border: none;
	background-size:18px 18px;
}
#id_msg, #password_msg {
	font-size:12px;
}
#kakao-login-btn {
	display:none;
}
button:hover {
	box-shadow: 0px 1px 4px 1px silver;
}
</style>
<script>
$(function() {

	if ($("#id").val().length < 1) {
		$("#id").focus();
	}
	
	var result = "${result}";
	console.log(result);
	if (result == '0') {
		$("#password_msg").css("color", "red").html("비밀번호가 일치하지 않습니다.");
		$("#password_msg").prev().css("border-color", "red");
		$("#password").select();
	} else if (result == '-1') {
		$("#id_msg").css("color", "red").html("아이디가 존재하지 않습니다.");
		$("#id_msg").prev().css("border-color", "red");
		$("#id").select();
	} else if (result == '1') {
		window.opener.location.reload();
		window.close();
	}
	
	$("form").submit(function() {
		if ($("#id").val().length < 1) {
			return false;
		} else if ($("#password").val().length < 1) {
			return false;
		}
	});
	
	$("#login_chk").change(function() {
		if ($(this).prop("checked")) {
			$(this).val("1");
			console.log($(this).val());
		} else {
			$(this).val("0")
			console.log($(this).val());
		}
	});
	
	$("#id").on("keyup", function() {
		$("#id_div").css("border-color", "silver");
		$("#id_msg").empty();
	});
	$("#password").on("keyup", function() {
		$("#password_div").css("border-color", "silver");
		$("#password_msg").empty();
	});
	
	if (window.event.keyCode == 13) {
		$("form").submit();
	}
	
});

</script>
</head>
<body>
	<form method="post" action="loginProcess">
		<div id="login_wrap">

			<div id="login_header">
				<p>당근빌리지</p>
			</div>


			<div id="login_content">
				<div><!-- 1 -->
				
					<div id="id_div">
						<input type="text" placeholder="아이디" name="id" 
							   id="id" value="${id}" required>
					</div>
					<div id="id_msg"></div>
					
					<div id="password_div">
						<input type="password" placeholder="비밀번호" name="password" 
							   id="password" value="${password}" required>
					</div>
					<div id="password_msg"></div>
					
				</div>
				<div><!-- 2 -->
					<input type="checkbox" id="login_chk" name="login_chk" value="0">
					<label for="login_chk"><span></span>로그인 유지하기  </label>
				</div>
				<div><!-- 3 -->
					<button id="login_btn" type="submit">로그인</button>
				</div>
				<div><!-- 4 -->
					<a id="join_terms" href="${pageContext.request.contextPath}/main/joinTerms">회원가입</a>
					<a href="">아이디/비밀번호 찾기</a>
				</div>
			</div>

			<div id="login_other">
			
				<div id="naver_id_login"></div>
				
				<script type="text/javascript">
					var naver_id_login = new naver_id_login("ac6ZedX0lErobHrFaU_k",
															"http://localhost:8088/myhome/main/naverLogin");  // Client ID, CallBack URL 삽입
																											  // 단 'localhost'가 포함된 CallBack URL
					var state = naver_id_login.getUniqState();

					naver_id_login.setButton("green", 3, 40);
					naver_id_login.setDomain("http://localhost:8088/myhome/main/login");	//  URL
					naver_id_login.setState(state);
					//naver_id_login.setPopup();
					naver_id_login.init_naver_id_login();
					
					$(function() {
						$("#naver_id_login_anchor").html("<img src='${pageContext.request.contextPath}"
													   + "/resources/image/nhj_naver_logo.PNG' id='naver_logo'>"
													   + "<p>네이버 아이디로 로그인</p>");
					});
				</script>
				
				
				<div id="kakao_id_login"></div>
				
				<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
				<script>
					Kakao.init('22ed35d588d5fe869fcf7c44448a0aaa');
					Kakao.isInitialized();
					
					console.log("Kakao.isInitialized()", Kakao.isInitialized());
					
					Kakao.Auth.createLoginButton({
						container : '#kakao_id_login',
						success : function(authObj) {
							Kakao.API.request({
								url : '/v2/user/me',
								success : function(res) {
									sessionStorage.setItem("id", res.id);
									sessionStorage.setItem("email", res.kakao_account.email);
									sessionStorage.setItem("name", res.kakao_account.profile.nickname);
									sessionStorage.setItem("profile_image", res.kakao_account.profile.thumbnail_image_url);
									location.href = "${pageContext.request.contextPath}/main/kakaoLogin";
								},
								fail : function(error) {
									alert(JSON.stringify(error))
								},
							})
						},
						fail : function(err) {
							console.log(JSON.stringify(err));	
						}
					});
					
					$(function() {
						$("#kakao_id_login").html("<img src='${pageContext.request.contextPath}"
													   + "/resources/image/nhj_kakao_logo.png' id='kakao_logo'>"
													   + "<p>카카오 아이디로 로그인</p>");
					});
				</script>
				
				
			</div>

		</div>
		<input type="hidden" name="login_type" value="normal">
	</form>
	
</body>
</html>