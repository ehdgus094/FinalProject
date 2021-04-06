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
*:focus {
	outline:none;
}
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
div {
	display:flex;
	flex-direction:column;
}
#join_wrap {
	width:420px;
	height:560px;
	padding: 30px 30px 0px 30px;
	margin:auto;
}
#join_header {
	height:15%;
}
#join_header p {
	font-size:25px;
	color:orange;
	text-align:center;
}
#join_content {
	height:85%;
}
#join_content > div:nth-child(1) {
	height:90%;
}

.join_item_wrap > div:nth-child(1):not(:nth-child(3)) {
	border-bottom: silver 2px solid;
    margin: 5px 0;
    padding: 0 10px;
}

.join {
	border:none;
	width:80%;
	height:42px;
}
#join_content input::placeholder {
	color:silver;
	font-weight:400;
	letter-spacing:1px;
}
#join_btn {
	background:orange;
	color:white;
	width:100%;
	border-radius:3px;
	border:1px orange solid;
	height:45px;
	font-size:18px;
	font-weight:400;
}
#email_auth {
	display:flex;
	flex-direction:row;
	justify-content: space-between;
	border:none;
	height:65px;
}
#email_auth_btn {
	margin-top: 11px;
    width: 150px;
    height: 35px;
    background: white;
    border: 1px solid silver;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;

}

#email_auth > div:nth-child(2) {
	margin-top: 11px;
    width: 180px;
    height: 35px;
    border: 1px solid silver;
    border-radius: 20px;
    font-size: 13px;
    text-indent: 26px;
    flex-direction:row;
}

#email_auth_key_input {
	border: none;
    margin-left: 14px;
    font-size: 20px;
    text-align: center;
}
#email_auth_timer {
	width:40px;
}
#email_auth_timer div {
	margin-top:6px;
}

.join_msg {
	font-size:12px;
}
button:focus {
	outline:none;
}
.x {
	display:block;width:16px;height:16px;
	border-radius:10px;margin:14px 0;cursor:pointer;
	background:url(${pageContext.request.contextPath}/resources/image/nhj_x.png) no-repeat;
	background-size:16px 16px;
	visibility:hidden;
}
#name_count {
	height: 15px;font-size: 13px;color: silver;margin:10px 0 20px 20px;
}
</style>
<script>

$(function() {
	var checkName = false;
	var checkEmail = false;
	var checkPassword = false;
	var checkPasswordChk = false;
	
	$('form').on("submit", function() {
		
		if ($("#email_auth_key_input").val() != authKey) {
			alert("이메일 인증번호가 일치하지 않습니다.");
			return false;
		}
		
		if(!checkName) {
			alert("이름을 형식에 맞게 입력해 주세요.");
			$("#name").focus();
			return false;
		}
		if(!checkEmail) {
			alert("이메일을 형식에 맞게 입력해 주세요.");
			$("#email").focus();
			return false;
		}
		if(!checkPassword) {
			alert("비밀번호를 형식에 맞게 입력해 주세요.");
			$("#password").focus();
			return false;
		}
		if(!checkPasswordChk) {
			$("#password_chk").focus();
			return false;
		}
		
		alert("회원가입이 완료되었습니다.");
		
	});
	
	//이름
	$("#name").on('keyup', function() {
		$("#name_msg").empty();
		var pattern = /^[0-9가-힣a-zA-Z]+$/;
		var name = $("#name").val();
	
		if(!pattern.test(name)) {
			$("#name_msg").css('color', '#e00000').html("특수문자는 사용할 수 없습니다.");
			$("#name_msg").prev().css('border-color', 'red');
			checkName = false;
		} else {
			
			if (name.length < 2) {
				$("#name_msg").css('color', '#e00000').html("2자 이상 입력하세요.");
				$("#name_msg").prev().css('border-color', 'red');
				checkName = false;
			} else {
				
				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/main/joinCheck",
					data : { "field" : "name", "value" : name },
					success : function(rdata) {
						if(rdata.result == '-1') {
							$("#name_msg").prev().css('border-color', 'silver');
							$("#name_msg").empty();
							checkName = true;
						} else {
							$("#name_msg").prev().css('border-color', 'red');
							$("#name_msg").css('color', 'red').html("사용중인 아이디 입니다.");
							checkName = false;
						}
					}
				});
				
			}
			
		}
		if (!name) {
			$("#name_msg").prev().css('border-color', 'silver');
			$("#name_msg").empty();
			$("name_count").empty();
			checkName = false;
			$("#name_count").css("visibility", "hidden");
			$("#namex").css("visibility", "hidden");
		} else {
			$("#name_count").css("visibility", "visible");
			$("#namex").css("visibility", "visible");
			if (name.length >= 15) {
				$("#name_count").css("color", "red");
			} else {
				$("#name_count").css("color", "silver");
			}
		}
		
		var length = name.length;
		if (length > 15) {
			length = 15;
			$(this).val(name.substring(0, length));
		}
		$("#name_count").text(length + "/15");

		
		
	});
	
	$("#namex").click(function() {
		$("#name").val("");
		$("#name_msg").empty();
		$("#name_msg").prev().css('border-color', 'silver');
		$("#name_count").css("visibility", "hidden");
		$(this).css("visibility", "hidden");
	});
	
	//이메일
	var email = $("#email").val();
	
	$("#email").on('keyup', function() {
		$("#email_msg").empty();
		var pattern = /^\w+@\w+[.]\w{2,3}$/;
		email = $("#email").val();
		if(!pattern.test(email)) {
			$("#email_msg").css('color', '#e00000').html("이메일형식이 맞지 않습니다.");
			$("#email_msg").prev().css('border-color', 'red');
			checkEmail = false;
		} else {
			$("#email_msg").prev().css('border-color', 'silver');
			$("#email_msg").empty();
			
			$.ajax({
				type : "get",
				url : "${pageContext.request.contextPath}/main/joinCheck",
				data : { "field" : "email", "value" : email },
				success : function(rdata) {
					if(rdata.result == '-1') {
						$("#email_msg").prev().css('border-color', 'silver');
						$("#email_msg").empty();
						checkEmail = true;
					} else {
						$("#email_msg").prev().css('border-color', 'red');
						$("#email_msg").css('color', 'red').html("사용중인 이메일 입니다.");
						checkEmail = false;
					}
				}
			});
			
		}
		if (!email) {
			$("#email_msg").prev().css('border-color', 'silver');
			$("#email_msg").empty();
			checkEmail = false;
			$("#emailx").css("visibility", "hidden");
		} else {
			$("#emailx").css("visibility", "visible");
		}
		
		
		
	});
	
	$("#emailx").click(function() {
		$("#email").val("");
		$("#email_msg").empty();
		$("#email_msg").prev().css('border-color', 'silver');
		$(this).css("visibility", "hidden");
	});
	
	//비밀번호
	var password = $("#password").val();
	
	$("#password").on('keyup', function() {
		$("#password_msg").empty();
		var pattern = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
		password = $("#password").val();
		if(!pattern.test(password)) {
			$("#password_msg").css('color', '#e00000').html("비밀번호는 숫자,영문,특수문자(!@#$%^&*()?_~)조합으로 8~20자리를 사용해야 합니다.");
			$("#password_msg").prev().css('border-color', 'red');
			checkPassword = false;
		} else {
			$("#password_msg").prev().css('border-color', 'silver');
			$("#password_msg").empty();
			checkPassword = true;
		}
		if (!password) {
			$("#password_msg").prev().css('border-color', 'silver');
			$("#password_msg").empty();
			checkPassword = false;
			$("#passwordx").css("visibility", "hidden");
		} else {
			$("#passwordx").css("visibility", "visible");
		}

	});
	
	//비밀번호 확인 x버튼
	var passChkx = function passChkx() {
		$("#password_chk").val("");
		$("#password_chk_msg").empty();
		$("#password_chk_msg").prev().css('border-color', 'silver');
		$("#password_chkx").css("visibility", "hidden");
	}
	
	$("#passwordx").click(function() {
		$("#password").val("");
		$("#password_msg").empty();
		$("#password_msg").prev().css('border-color', 'silver');
		$(this).css("visibility", "hidden");
		passChkx();
	});
	
	//비밀번호 확인
	$("#password_chk").on('keyup', function () {
		$("#password_chk_msg").empty();
		var passwordChk = $("#password_chk").val();
		if (password != passwordChk) {
			$("#password_chk_msg").css('color', '#e00000').html("비밀번호가 다릅니다.");
			$("#password_chk_msg").prev().css('border-color', 'red');
			checkPasswordChk = false;
		} else {
			$("#password_chk_msg").prev().css('border-color', 'silver');
			$("#password_chk_msg").empty();
			checkPasswordChk = true;
		}
		if (!passwordChk) {
			$("#password_chk_msg").prev().css('border-color', 'silver');
			$("#password_chk_msg").empty();
			checkPasswordChk = false;
			$("#password_chkx").css("visibility", "hidden");
		} else {
			$("#password_chkx").css("visibility", "visible");
		}
	});
	
	$("#password_chkx").click(passChkx);
	
	//이메일 인증
	var authKey = "";
	
	$("#email_auth_btn").click(function() {
		if (!email) {
			alert("이메일을 입력해 주세요.");
			return false;
		} else if (!checkEmail) {
			alert("이메일을 형식에 맞게 입력해 주세요.");
			$("#email").focus();
			return false;
		} else {
			alert("이메일이 전송 되었습니다 인증번호를 확인해 주세요.");
			
			$.ajax({
				type : "get",
				url : "${pageContext.request.contextPath}/main/emailAuth",
				data : { "email" : email },  //210번 라인
				dataType : "json",
				success : function(rdata) {
					authKey = rdata.authKey;
				}
			});
			
			//타이머
			var time = 180;
			var min = 0;
			var sec = 0;
			var x = setInterval(function() {
				min = parseInt(time/60);
				sec = time % 60;
				$("#email_auth_timer div").text(min + ":" + twoDigits(sec));
				time--;
				
				var color = time > 60 ? "black" : "red";
				$("#email_auth_timer div").css("color", color);
				
				if (time < 0) {
					clearInterval(x);
					$("#email_auth_timer div").text("0:00");
					authKey = "";
					
					if (!authKey) {
						alert("이메일 인증 시간이 만료되었습니다.");
					}
				}
				
				$("#email_auth_btn").click(function() {
					clearInterval(x);
				});
				
			}, 1000);
			
		}
		
	});
	
	function twoDigits(n) {
		return (n < 10 ? '0' : '') + n;
	}
	
});
</script>
</head>
<body>
	<form action="joinProcess" method="post">
		<div id="join_wrap">

			<div id="join_header">
				<p>당근빌리지</p>
			</div>


			<div id="join_content">
			
				<div>
				
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="text" placeholder="이름" name="name" id="name" class="join">
							<div style="flex-direction:row;">
								<span id="namex" class="x"></span>
								<span id="name_count"></span>
							</div>
						</div>
						<div class="join_msg" id="name_msg"></div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="text" placeholder="이메일" name="email" id="email" class="join">
							<div style="margin-left:70px;">
								<span id="emailx" class="x"></span>
							</div>
						</div>
						<div class="join_msg" id="email_msg"></div>
					</div>
					
					<div class="join_item_wrap">
						<div id="email_auth">
							<div><input type="button" id="email_auth_btn" value="이메일 인증하기"></div>
							<div>
								<div style="width:65%"><input type="text" id="email_auth_key_input"></div>
								<div id="email_auth_timer"><div></div></div>
							</div>
						</div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="password" placeholder="비밀번호" name="password" id="password" class="join">
							<div style="margin-left:70px;">
								<span id="passwordx" class="x"></span>
							</div>
						</div>
						<div class="join_msg" id="password_msg"></div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="password" placeholder="확인" name="password_chk" id="password_chk" class="join">
							<div style="margin-left:70px;">
								<span id="password_chkx" class="x"></span>
							</div>
						</div>
						<div class="join_msg" id="password_chk_msg"></div>
					</div>
					
				</div>
				
				<div>
					<button type="submit" id="join_btn">가입하기</button>
				</div>

			</div>


		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</body>
</html>