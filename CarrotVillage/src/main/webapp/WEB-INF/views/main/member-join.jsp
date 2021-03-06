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

.join_item_wrap > div:nth-child(1):not(:nth-child(4)) {
	border-bottom: silver 2px solid;
    margin: 5px 0;
    padding: 0 10px;
}

.join {
	border:none;
	width:95%;
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
	height:60px;
}
#email_auth_btn {
	margin-top: 11px;
    width: 150px;
    height: 35px;
    background: #f3f3f3;
    border: 1px solid silver;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;

}
#email_auth_btn:hover {
	background:#dedede;
	box-shadow: 0px 1px 4px 1px silver;
}
#email_auth > div:nth-child(2) {
	margin-top: 11px;
    width: 170px;
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
#email_auth_msg {
	margin-left:20px;
}

.join_msg {
	font-size:12px;
}
button:focus {
	outline:none;
}
button:hover {
	box-shadow: 0px 1px 4px 1px silver;
}
.x {
	display:block;width:16px;height:16px;
	border-radius:10px;margin:14px 0;cursor:pointer;
	background:url(${pageContext.request.contextPath}/resources/image/nhj_x.png) no-repeat;
	background-size:16px 16px;
	visibility:hidden;
}
#id_count, #name_count {
	height: 15px;font-size: 13px;color: silver;margin:10px 0 20px 20px;
}
</style>
<script>

$(function() {
	var checkId = false;
	var checkPassword = false;
	var checkPasswordChk = false;
	var checkEmail = false;
	var checkEmailAuth = false;
	
	$('form').on("submit", function() {
		
		if(!checkId) {
			alert("아이디를 형식에 맞게 입력해 주세요.");
			$("#id").focus();
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
		if(!checkEmail) {
			alert("이메일을 형식에 맞게 입력해 주세요.");
			$("#email").focus();
			return false;
		}
		if (!checkEmailAuth) {
			alert("이메일 인증을 완료해 주세요.");
			return false;
		}
		
	});
	
	//아이디
	$("#id").on('keyup', function() {
		$("#id_msg").empty();
		var pattern = /^[0-9a-zA-Z]+$/;
		var id = $("#id").val();
	
		if(!pattern.test(id)) {
			$("#id_msg").css('color', 'red').html("특수문자, 한글은 사용할 수 없습니다.");
			$("#id_msg").prev().css('border-color', 'red');
			checkId = false;
		} else {
			
			if (id.length < 4) {
				$("#id_msg").css('color', 'red').html("4자 이상 입력하세요.");
				$("#id_msg").prev().css('border-color', 'red');
				checkId = false;
			} else {
				
				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/main/joinCheck",
					data : { "field" : "id", "value" : id },
					success : function(rdata) {
						if(rdata.result == '-1') {
							$("#id_msg").prev().css('border-color', 'silver');
							$("#id_msg").empty();
							checkId = true;
						} else {
							$("#id_msg").prev().css('border-color', 'red');
							$("#id_msg").css('color', 'red').html("사용중인 아이디입니다.");
							checkId = false;
						}
					}
				});
				
			}
			
		}
		if (!id) {
			$("#id_msg").prev().css('border-color', 'silver');
			$("#id_msg").empty();
			$("#id_count").empty();
			checkId = false;
			$("#id_count").css("visibility", "hidden");
			$("#idx").css("visibility", "hidden");
		} else {
			$("#id_count").css("visibility", "visible");
			$("#idx").css("visibility", "visible");
			if (id.length >= 20) {
				$("#id_count").css("color", "red");
			} else {
				$("#id_count").css("color", "silver");
			}
		}
		
		var length = id.length;
		if (length > 20) {
			length = 20;
			$(this).val(id.substring(0, length));
		}
		$("#id_count").text(length + "/20");

		
		
	});
	
	$("#idx").click(function() {
		$("#id").val("");
		$("#id_msg").empty();
		$("#id_msg").prev().css('border-color', 'silver');
		$("#id_count").css("visibility", "hidden");
		$(this).css("visibility", "hidden");
		checkId = false;
	});
	
	//비밀번호
	var password = $("#password").val();
	
	$("#password").on('keyup', function() {
		$("#password_msg").empty();
		var pattern = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
		password = $("#password").val();
		if(!pattern.test(password)) {
			$("#password_msg").css('color', 'red').html("비밀번호는 숫자,영문,특수문자(!@#$%^&*()?_~)조합으로 8~20자리를 사용해야 합니다.");
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
		checkPasswordChk = false;
	}
	
	$("#passwordx").click(function() {
		$("#password").val("");
		$("#password_msg").empty();
		$("#password_msg").prev().css('border-color', 'silver');
		$(this).css("visibility", "hidden");
		checkPassword = false;
		passChkx();  //비밀번호에 있는 x를 누르면 비밀번호확인의 내용도 같이 지워집니다.
	});
	
	//비밀번호 확인
	$("#password_chk").on('keyup', function () {
		$("#password_chk_msg").empty();
		var passwordChk = $("#password_chk").val();
		if (password != passwordChk) {
			$("#password_chk_msg").css('color', 'red').html("비밀번호가 다릅니다.");
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
	
	//이메일
	var email = $("#email").val();
	
	$("#email").on('keyup', function() {
		$("#email_msg").empty();
		var pattern = /^\w+@\w+[.]\w{2,3}$/;
		email = $("#email").val();
		if(!pattern.test(email)) {
			$("#email_msg").css('color', 'red').html("이메일형식이 맞지 않습니다.");
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
		checkEmail = false;
	});
	
	
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
			$("#email_auth_msg").empty();
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
				
				if (checkEmailAuth) {
					clearInterval(x);
				}
				
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
		
		
		$("#email_auth_key_input").keyup(function(){
			if ($(this).val() == authKey && $(this).val().length > 0) {
				$("#email_auth_msg").css('color', 'green').html("이메일 인증번호가 일치합니다.");
				checkEmailAuth = true;
			} else if ($(this).val() != authKey && $(this).val().length >= 6) {
				$("#email_auth_msg").css('color', 'red').html("이메일 인증번호가 일치하지 않습니다.");
				checkEmailAuth = false;
			} else if ($(this).val().length < 6) {
				$("#email_auth_msg").empty();
				checkEmailAuth = false;
			}
		});
		
	});
	
	
	function twoDigits(n) {
		return (n < 10 ? '0' : '') + n;
	}
	
});
</script>
</head>
<body>
	<form action="joinMore" method="post">
		<div id="join_wrap">

			<div id="join_header">
				<p>당근빌리지</p>
			</div>


			<div id="join_content">
			
				<div>
				
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="text" placeholder="아이디" name="id" id="id" class="join">
							<div style="flex-direction:row;">
								<span id="idx" class="x"></span>
								<span id="id_count"></span>
							</div>
						</div>
						<div class="join_msg" id="id_msg"></div>
					</div>
				
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="password" placeholder="비밀번호" name="password" id="password" class="join">
							<div style="margin-left:10px;">
								<span id="passwordx" class="x"></span>
							</div>
						</div>
						<div class="join_msg" id="password_msg"></div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="password" placeholder="비밀번호 확인" name="password_chk" id="password_chk" class="join">
							<div style="margin-left:10px;">
								<span id="password_chkx" class="x"></span>
							</div>
						</div>
						<div class="join_msg" id="password_chk_msg"></div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="text" placeholder="이메일" name="email" id="email" class="join">
							<div style="margin-left:10px;">
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
						<div class="join_msg" id="email_auth_msg"></div>
					</div>
					
					
				</div>
				
				<div>
					<button type="submit" id="join_btn">다음으로</button>
				</div>

			</div>


		</div>
	</form>
</body>
</html>
