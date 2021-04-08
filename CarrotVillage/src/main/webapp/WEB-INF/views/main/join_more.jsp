<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

.join_item_wrap > div:nth-child(1) {
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
#name_count {
	height: 15px;font-size: 13px;color: silver;margin:10px 0 20px 20px;
}
#post_search {
	cursor:pointer;
	font-size:13px;
	border-radius:3px;
	background: orange;
	height:30px;
	margin: 6px 0px 0px 10px;
	color:white
}
#post_search:hover {
	box-shadow: 0px 1px 4px 1px silver;
}
input[type='radio'] {
    margin-bottom: 17px;
    margin-right: 3px;
    cursor:pointer;
    -webkit-appearance: none;
    width: 15px;
    height: 15px;
    border-radius: 50%;
    outline: none;
    border: 1px solid gray;
}
input[type='radio'] + label {
	margin-right:12px;
	cursor:pointer;
	margin-bottom: 12px;
}

input[type='radio']:before {
	content: '';
    display: block;
    width: 62%;
    height: 62%;
    margin: 23% auto;
    border-radius: 50%;
}

input[type="radio"]:checked:before {
	background: orange;
}
    
input[type="radio"]:checked {
    border-color:orange;
}
#profile_img_wrap {
	width: 100%;
    height: 80px;
    margin-top: 20px;
    flex-direction:row;
    justify-content:space-around;
}
#img_area {
	width:80px;
	height:80px;
	border-radius:50%;
}
#profile_img_wrap > div:nth-child(2) {
	width:170px;
	height:100%;
}
#profile_img_wrap img {
	cursor:pointer;
	margin-left:20px;
	width:80px;
	height:80px;
}
#profile_img_wrap input[type='button'] {
	border:none;
	border-radius:3px;
	background:#ececec;
	height:30px;
	margin:20px 5px;
	font-size:13px;
}
#profile_img_wrap input[type='button']:hover {
	box-shadow: 0px 1px 4px 1px silver;
}
</style>
<script>

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
           $("#post").val(data.zonecode);
           $("#address1").val(addr);
            // 커서를 상세주소 필드로 이동한다.
           $("#address2").focus();
        }
    }).open();
}

$(function() {
	var checkName = false;
	var checkPhone = false;
	var checkBirth = false;
	
	$('form').on("submit", function() {
		
		$("#address").val($("#address1").val() + " " + $("#address2").val());
		
		if(!checkName) {
			alert("이름을 형식에 맞게 입력해 주세요.");
			$("#name").focus();
			return false;
		}
		if(!checkPhone) {
			$("#phone_num").focus();
			return false;
		}
		if(!checkBirth) {
			$("#birth").focus();
			return false;
		}
			
	});
	
	//이름
	$("#name").on('keyup', function() {
		$("#name_msg").empty();
		var pattern = /^[0-9가-힇a-zA-Z]+$/;
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
				$("#name_msg").prev().css('border-color', 'silver');
				$("#name_msg").empty();
				checkName = true;
			}

		}
		
		if (!name) {
			$("#name_msg").prev().css('border-color', 'silver');
			$("#name_msg").empty();
			$("#name_count").empty();
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
		checkName = false;
	});
	
	//주소
	$("#address2").on('keyup', function() {
		if (!name) {
			$("#address2x").css("visibility", "hidden");
		} else {
			$("#address2x").css("visibility", "visible");
		}
	});
	
	$("#address2x").click(function() {
		$("#address2").val("");
		$(this).css("visibility", "hidden");
	});
	
	$("#post_search").click(function() {
		execDaumPostcode()
	});
	
	//전화번호
	$("#phone_num").on('keyup', function() {
		$("#phone_msg").empty();
		var pattern = /^[0-9]+$/;
		var phone = $("#phone_num").val();
	
		if(!pattern.test(phone)) {
			$("#phone_msg").css('color', '#e00000').html("숫자만 입력하세요.");
			$("#phone_msg").prev().css('border-color', 'red');
			checkPhone = false;
		} else {
			checkPhone = true;
		}
		
		if (!phone) {
			$("#phone_msg").prev().css('border-color', 'silver');
			$("#phone_msg").empty()
			$("#phonex").css("visibility", "hidden");
		} else {
			$("#phonex").css("visibility", "visible");
		}
	});
	
	$("#phonex").click(function() {
		$("#phone_num").val("");
		$("#phone_msg").empty();
		$("#phone_msg").prev().css('border-color', 'silver');
		$(this).css("visibility", "hidden");
	});
	
	//생년월일
	$("#birth").on('keyup', function() {
		$("#birth_msg").empty();
		var pattern = /^[0-9]+$/;
		var birth = $("#birth").val();
	
		if(!pattern.test(birth)) {
			$("#birth_msg").css('color', '#e00000').html("숫자만 입력하세요.");
			$("#birth_wrap").css('border-color', 'red');
			checkBirth = false;
		} else {
			checkBirth = true;
		}
		
		if (!birth) {
			$("#birth_msg").prev().css('border-color', 'silver');
			$("#birth_msg").empty()
			$("#birthx").css("visibility", "hidden");
		} else {
			$("#birthx").css("visibility", "visible");
		}
	});
	
	$("#birthx").click(function() {
		$("#birth").val("");
		$("#birth_msg").empty();
		$("#birth_wrap").css('border-color', 'silver');
		$(this).css("visibility", "hidden");
	});
	
	$("#upload_btn").click(function() {
		$("#profile_img").click();
	});
	
	$("#remove_btn").click(function() {
		$("#profile_img").val("");
		$('#profile_img_wrap img').attr('src', "${pageContext.request.contextPath}/resources/image/nhj_profile.png"); 
	});
	
	$("#profile_img").change(function() {
		if($("#profile_img").val() == "") {
			$("#profile_img_wrap img").attr('src' , '');  
		}
		$('#img_area').css({ 'display' : '' });
		readURL(this);
	});

});

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#profile_img_wrap img').attr('src', e.target.result); 
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function imgAreaError(){
	$('#img_area').css({ 'display' : 'none' });
}

</script>
</head>
<body>
	<form action="joinProcess" method="post" enctype="multipart/form-data">
	
		<input type="hidden" name="id" value="${id}">
		<input type="hidden" name="password" value="${password}">
		<input type="hidden" name="email" value="${email}">
		
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
							<input type="text" placeholder="주소" name="address1" id="address1" class="join" style="width:82%;">
							<input type="text" name="post" id="post" class="join" style="width:18%;text-align:center">
						</div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;justify-content: space-between;">
							<input type="text" placeholder="상세주소" name="address2" id="address2" class="join" style="width:65%;">
							<div style="width:5%;">
								<span id="address2x" class="x"></span>
							</div>
							<input type="button" id="post_search" class="join" value="우편번호 찾기" style="width:30%;">
							<input type="hidden" name="address" id="address">
						</div>
					</div>
					
					<div class="join_item_wrap">
						<div style="flex-direction:row;">
							<input type="text" placeholder="전화번호('-'없이 입력)" name="phone_num" id="phone_num" class="join">
							<div>
								<span id="phonex" class="x"></span>
							</div>
						</div>
						<div class="join_msg" id="phone_msg"></div>
					</div>
					
					<div class="join_item_wrap" style="flex-direction:row;justify-content: space-between;border:none;">
						<div style="flex-direction:row;" id="birth_wrap">
							<input type="text" placeholder="생년월일(8자리)" name="birth" id="birth" class="join" style="margin-top:10px;width:150px">
							<div>
								<span id="birthx" class="x" style="margin-top:23px;"></span>
							</div>
						</div>
						<div class="genders" style="flex-direction:row;justify-content:space-around;align-items:flex-end">
							<input type="radio" name="gender" value="m" id="m"><label for="m">남</label>
							<input type="radio" name="gender" value="f" id="f"><label for="f">여</label>
							<input type="radio" name="gender" value="x" id="x" checked><label for="x">기타</label>
						</div>
					</div>
					<div class="join_msg" id="birth_msg" style="width:150px;"></div>
					
					<div id="profile_img_wrap">
						<div id="img_area">
							<label for="profile_img">
								<img src="${pageContext.request.contextPath}/resources/image/nhj_profile.png">
							</label>
						</div>
						<div style="flex-direction:row;">
							<input type="file" name="profile_img" id="profile_img" 
								   accept="image/*" style="display:none;">
							<input type="button" id="upload_btn" style="margin-left:40px;" value="사진등록">
							<input type="button" id="remove_btn" value="삭제">
						</div>
					</div>
					
				</div>
				
				<div>
					<button type="submit" id="join_btn">가입하기</button>
				</div>

			</div>


		</div>
	</form>
</body>
</html>