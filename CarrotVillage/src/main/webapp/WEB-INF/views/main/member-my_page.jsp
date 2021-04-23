<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

#content_wrap table {
	margin:82px auto;
	font-size:13px;
}
#content_wrap tr {
	border-top: solid 1px silver;
    border-bottom: solid 1px silver;
}
#content_wrap th {
	width: 170px;
    padding: 10px 20px;
    background: whitesmoke;
    border-right: solid 1px silver;
    color:#565656;
}
#content_wrap td {
	width:450px;
	padding: 10px 20px;
	color:#5a5a5a;
}
#profile_img_wrap {
	display:flex;
    flex-direction:row;
}

#profile_img_wrap > div:nth-child(2) {
	margin-top: 25px;
}
#profile_img_wrap label {
	margin:0;
}
#content_wrap img {
	cursor:pointer;
	width:80px;
	height:80px;
}
#content_wrap input[type='button'],
#content_wrap input[type='submit'] {
	border:none;
	border-radius:3px;
	background:orange;
	height:27px;
	font-size:13px;
	color:white;
}
#content_wrap input[type='button']:hover,
#content_wrap input[type='submit']:hover {
	box-shadow: 0px 1px 4px 1px silver;
}
#new_password, #new_password_chk {
	width:200px;
	margin-bottom:3px;
}
</style>
<script>
	$(function() {
		//비밀번호 변경 버튼
		$(document).on("click", "#password_modify_btn", function() {
			output = "<form>"
				   + "    <input type='password' id='password_modify_check_input'"
				   + " 		     placeholder='현재 비밀번호를 입력하세요' style='width:200px;margin-right:10px' autocomplete='off'>"
				   + "    <input type='button' id='password_modify_check_btn' value='확인'>"
				   + "</form>";
			$("#my_page_password > td").html(output);
		});
		
		//기존 비밀번호 입력 버튼
		$(document).on("click", "#password_modify_check_btn", function() {
			
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/main/memberModifyPasswordChk",
				data : { "id" : "${user_info.id}", "password" : $("#password_modify_check_input").val() },
				success : function(rdata) {
					if (rdata == 1) {
						
						output = "<form>"
							   + "    <div style='display:flex;flex-direction:column;'>"
							   + "        <input type='password' placeholder='새 비밀번호 입력' id='new_password' autocomplete='off'>"
							   + "        <input type='password' placeholder='확인' id='new_password_chk' autocomplete='off'>"
							   + "        <div id='password_msg' style='font-size:11px;'></div>"
							   + "        <div style='display:flex;flex-direction:row;margin-top:5px;'>"
							   + "            <input type='button' value='변경' id='new_password_btn' style='margin-right:5px;'>"
							   + "            <input type='button' value='취소' id='new_password_cancel'>"
							   + "        </div>"
							   + "    </div>"
							   + "</form>";
						
						$("#my_page_password > td").html(output);
						
					} else {
						alert("비밀번호가 다릅니다.");
					}
				}
			});
			
		});
		
		var newPassword = "";
		var checkPassword = false;
		var checkPasswordChk = false;
		
		//새 비밀번호
		$(document).on("keyup", "#new_password", function() {
			$("#password_msg").empty();
			var pattern = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
			newPassword = $("#new_password").val();
			if(!pattern.test(newPassword)) {
				$("#password_msg").css('color', 'red').html("비밀번호는 숫자,영문,특수문자(!@#$%^&*()?_~)조합으로 8~20자리를 사용해야 합니다.");
				checkPassword = false;
			} else {
				
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/main/memberModifyPasswordChk",
					data : { "id" : "${user_info.id}", "password" : newPassword },
					success : function(rdata) {
						if (rdata == 1) {
							$("#password_msg").css('color', 'red').html("기존 비밀번호와 다른 비밀번호를 입력해주세요.");
							checkPassword = false;
						} else {
							$("#password_msg").empty();
							checkPassword = true;
						}
					}
				});
				
			}
			
			if (!newPassword) {
				$("#password_msg").css('color', 'red').html("비밀번호를 입력해주세요.");
				checkPassword = false;
			}
		});

		
		//비밀번호 확인
		$(document).on("keyup", "#new_password_chk", function () {
			$("#password_msg").empty();
			var newPasswordChk = $("#new_password_chk").val();
			if (newPassword != newPasswordChk) {
				$("#password_msg").css('color', 'red').html("비밀번호가 다릅니다.");
				checkPasswordChk = false;
			} else {
				$("#password_msg").empty();
				checkPasswordChk = true;
			}
		});
		
		//새 비밀번호로 변경 버튼
		$(document).on("click", "#new_password_btn", function() {
			if (checkPassword && checkPasswordChk) {
				
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/main/memberModify",
					data : { "field" : "password", "id" : "${user_info.id}", "password" : newPassword },
					success : function(rdata) {
						if (rdata == 1) {
							alert("비밀번호 변경이 완료되었습니다. 새로운 비밀번호로 다시 로그인 해주세요.");
							logout();
						} else {
							alert("비밀번호 변경 에러");
						}
					}
				});
				
			} else {
				alert("비밀번호를 확인해주세요.");
			}
		});
		
		//비밀번호 변경 취소
		$(document).on("click", "#new_password_cancel", function() {
			$("#my_page_password > td").html("<input type='button' id='password_modify_btn' value='변경'>");
		});
		
		
		//주소 변경 버튼
		$(document).on("click", "#address_modify_btn", function() {
			output = "<div>"
				   + "    <div><input type='text' id='new_post' style='border:none;display:none;' readonly></div>"
				   + "    <div>"
				   + "        <input type='text' id='new_address1' style='width:400px;border:none;display:none;' readonly>"
				   + "    </div>"
				   + "    <div style='margin:5px 0px 10px 0;'>"
				   + "        <input type='text' id='new_address2' style='width:250px;' readonly>"
				   + "        <input type='hidden' id='new_address'>"
				   + "    </div>"
				   + "    <div>"				   
				   + "        <input type='button' id='new_address_btn' value='변경'>"				   
				   + "        <input type='button' id='new_address_cancel' value='취소'>"				   
				   + "        <input type='button' id='new_address_search' value='검색'>"				   
				   + "    </div>"				   
				   + "</div>";
			$("#my_page_address > td").html(output);
		});
		
		//상세 주소 입력시 address1 + address2
		$(document).on("keyup", "#new_address2", function() {
			$("#new_address").val($("#new_address1").val() + " " + $("#new_address2").val());
		});
		
		//새 주소로 변경
		$(document).on("click", "#new_address_btn", function() {
			
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/main/memberModify",
				data : { "field" : "address",
						 "id" : "${user_info.id}",
						 "post" : $("#new_post").val(),
						 "address" : $("#new_address").val()
					   },
				success : function(rdata) {
					if (rdata == 1) {
						alert("주소 변경이 완료되었습니다.");
						window.location.reload();
						
						output = "<c:if test='${empty user_info.post}'>"
							   + "    주소를 등록해 주세요. &nbsp;&nbsp;"
							   + "</c:if>"
							   + "<c:if test='${!empty user_info.post}'>"
							   + "    ${user_info.post} ${user_info.address} &nbsp;&nbsp;"
							   + "</c:if>"
							   + "<input type='button' value='변경' id='address_modify_btn'>";
						
						$("#my_page_address > td").html(output);
					} else {
						alert("주소 변경 에러");
					}
				}
			});
			
		});
		
		//주소검색
		$(document).on("click", "#new_address_search", function() {
			execDaumPostcode();
			$("#new_address2").prop("readonly", false);
		});
		
		//주소변경 취소 
		$(document).on("click", "#new_address_cancel", function() {
			output = "<c:if test='${empty user_info.post}'>"
				   + "    주소를 등록해 주세요. &nbsp;&nbsp;"
				   + "</c:if>"
				   + "<c:if test='${!empty user_info.post}'>"
				   + "    ${user_info.post} ${user_info.address} &nbsp;&nbsp;"
				   + "</c:if>"
				   + "<input type='button' value='변경' id='address_modify_btn'>";
			$("#my_page_address > td").html(output);   
		});
		
		//전화번호 변경 버튼
		$(document).on("click", "#phone_num_modify_btn", function() {
			output = "<input type='text' placeholder='전화번호 입력' id='new_phone_num'>"			   
				   + "<input type='button' id='new_phone_num_btn' value='변경' style='margin-left:10px;'>"				   
				   + "<input type='button' id='new_phone_num_cancel' value='취소' style='margin-left:5px;'>"
				   + "<div id='phone_msg' style='font-size:12px;'></div>";
			$("#my_page_phone_num > td").html(output);
		});
		
		var checkPhone = false;
		
		//전화번호 유효성 검사
		$(document).on('keyup', "#new_phone_num", function() {
			$("#phone_msg").empty();
			var pattern = /^[0-9]+$/;
			var phone = $("#new_phone_num").val();
		
			if(!pattern.test(phone)) {
				$("#phone_msg").css('color', 'red').html("숫자만 입력하세요.");
				checkPhone = false;
			} else {
				checkPhone = true;
			}
		});
		
		//새 전화번호로 변경
		$(document).on("click", "#new_phone_num_btn", function() {
			if (checkPhone) {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/main/memberModify",
					data : { "field" : "phone_num",
							 "id" : "${user_info.id}",
							 "phone_num" : $("#new_phone_num").val()
						   },
					success : function(rdata) {
						if (rdata == 1) {
							alert("전화번호 변경이 완료되었습니다.");
							window.location.reload();
							
							output = "<c:if test='${empty user_info.phone_num}'>"
								   + "    전화번호를 등록해 주세요. &nbsp;&nbsp;"
								   + "</c:if>"
								   + "<c:if test='${!empty user_info.phone_num}'>"
								   + "    ${user_info.phone_num} &nbsp;&nbsp;"
								   + "</c:if>"
								   + "<input type='button' value='변경' id='phone_num_modify_btn'>";
							
							$("#my_page_phone_num > td").html(output);
						} else {
							alert("전화번호 변경 에러.");
						}
					}
				});
			} else {
				alert("전화번호를 입력하세요.");
			}
		});
		
		//전화번호 변경 취소 
		$(document).on("click", "#new_phone_num_cancel", function() {
			output = "<c:if test='${empty user_info.phone_num}'>"
				   + "    전화번호를 등록해 주세요. &nbsp;&nbsp;"
				   + "</c:if>"
				   + "<c:if test='${!empty user_info.phone_num}'>"
				   + "    ${user_info.phone_num} &nbsp;&nbsp;"
				   + "</c:if>"
				   + "<input type='button' value='변경' id='phone_num_modify_btn'>";
			$("#my_page_phone_num > td").html(output);
		});
		
		//생년월일 등록 버튼
		$(document).on("click", "#birth_modify_btn", function() {
			output = "<input type='text' placeholder='생년월일 입력(6자리)' id='new_birth'>"			   
				   + "<input type='button' id='new_birth_btn' value='변경' style='margin-left:10px;'>"				   
				   + "<input type='button' id='new_birth_cancel' value='취소' style='margin-left:5px;'>"
				   + "<div id='birth_msg' style='font-size:12px;'></div>";
			$("#my_page_birth > td").html(output);
		});
		
		var checkBirth
		
		//생년월일 유효성 검사
		$(document).on("keyup", "#new_birth",  function() {
			$("#birth_msg").empty();
			var pattern = /^[0-9]+$/;
			var birth = $("#new_birth").val();
		
			if(!pattern.test(birth)) {
				$("#birth_msg").css('color', 'red').html("숫자만 입력하세요.");
				checkBirth = false;
			} else {
				if (birth.length == 6) {
					$("#birth_msg").empty()
					checkBirth = true;
				} else {
					$("#birth_msg").css('color', 'red').html("6자리의 숫자로 입력하세요.");
					checkBirth = false;
				}
			}
		});
		
		//새 생년월일로 변경
		$(document).on("click", "#new_birth_btn", function() {
			if (checkBirth) {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/main/memberModify",
					data : { "field" : "birth",
							 "id" : "${user_info.id}",
							 "birth" : $("#new_birth").val()
						   },
					success : function(rdata) {
						if (rdata == 1) {
							alert("생년월일 변경이 완료되었습니다.");
							window.location.reload();
							
							output = "${user_info.birth} &nbsp;&nbsp;"
								   + "<input type='button' value='변경' id='phone_num_modify_btn'>";
							
							$("#my_page_phone_num > td").html(output);
						} else {
							alert("생년월일 변경 에러.");
						}
					}
				});
			} else {
				alert("생년월일을 입력하세요.");
			}
		});
		
		$(document).on("click", "#upload_btn", function() {
			$("#profile_img").click();
		});
		
		$(document).on("click", "#remove_btn", function() {
			$("#profile_img").val("");
			$('#profile_img_wrap img').attr('src', "${pageContext.request.contextPath}/resources/image/nhj_profile.png"); 
		});
		
		$(document).on("change", "#profile_img", function() {
			if($("#profile_img").val() == "") {
				$("#profile_img_wrap img").attr('src' , '');  
			}
			$('#img_area').css({ 'display' : '' });
			readURL(this);
		});
		
		
		$("#withdrawal_btn").click(function() {
			
			if(confirm("정말 탈퇴하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/main/memberWithdrawal",
					data : { "id" : "${user_info.id}" },
					success : function() {
						alert("회원 탈퇴 완료");
						location.href = "${pageContext.request.contextPath}/main/mainPage";
					}
				});
			}
			
		});

	});
	
if("${message}" == 1) {
	alert("프로필사진 변경이 완료되었습니다.");
}
	
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
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
			$("#new_post").val(data.zonecode);
			$("#new_address1").val(addr);
			// 커서를 상세주소 필드로 이동한다.
			$("#new_address2").focus();
			$("#new_post").css("display", "block");
			$("#new_address1").css("display", "block");
		}
	}).open();
}

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#profile_img_wrap img').attr('src', e.target.result); 
		}
		reader.readAsDataURL(input.files[0]);
	}
}
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
		<div id="content_title"><span>내 정보</span></div>
		
		<table>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${user_info.id}</td>
				</tr>
				
				<c:if test="${user_info.login_type == 'normal'}">
					<tr id="my_page_password">
						<th>비밀번호</th>
						<td><input type="button" id="password_modify_btn" value="변경"></td>
					</tr>
				</c:if>
				
				<tr>
					<th>이메일</th>
					<td>${user_info.email}</td>
				</tr>
				
				<tr>
					<th>이름</th>
					<td>${user_info.name}</td>
				</tr>
				
				<tr id="my_page_address">
					<th>주소</th>
					<td>
						<c:if test="${empty user_info.post}">
							주소를 등록해 주세요. &nbsp;&nbsp; 
						</c:if>
						<c:if test="${!empty user_info.post}">
							${user_info.post} ${user_info.address} &nbsp;&nbsp;
						</c:if>
						<input type="button" value="변경" id="address_modify_btn">
					</td>
				</tr>
				
				<tr id="my_page_phone_num">
					<th>전화번호</th>
					<td>
						<c:if test="${empty user_info.phone_num}">
							전화번호를 등록해 주세요. &nbsp;&nbsp; 
						</c:if>
						<c:if test="${!empty user_info.phone_num}">
							${user_info.phone_num} &nbsp;&nbsp;
						</c:if>
						<input type="button" value="변경" id="phone_num_modify_btn">
					</td>
				</tr>
				
				<tr id="my_page_birth">
					<th>생년월일</th>
					<td>
						<c:if test="${empty user_info.birth}">
							생년월일을 등록해 주세요. &nbsp;&nbsp; 
							<input type="button" value="등록" id="birth_modify_btn">
						</c:if>
						<c:if test="${!empty user_info.birth}">
							${user_info.birth}
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th>성별</th>
					<td>
						<c:if test="${user_info.gender == 'm'}">
							남자
						</c:if>
						<c:if test="${user_info.gender == 'f'}">
							여자
						</c:if>
						<c:if test="${user_info.gender == 'x'}">
							기타
						</c:if>
					</td>
				</tr>
				
				<tr id="my_page_profile_img">
					<th>프로필 사진</th>
					<td>
						<form action="profileImageModify" method="post" enctype="multipart/form-data">
							<input type="hidden" name="id" value="${user_info.id}">
							<c:if test="${user_info.login_type == 'normal'}">
								<div id="profile_img_wrap">
									<div id="img_area">
										<label for="profile_img"> 
											<img src="${pageContext.request.contextPath}/resources/upload/member_image${user_info.profile_img}">
										</label>
									</div>
									<div style="flex-direction: row;">
										<input type="file" name="uploadfile" id="profile_img"accept="image/*" style="display: none;">
										<input type="button" id="upload_btn" style="margin-left: 40px;"value="사진등록">
										<input type="button" id="remove_btn" value="삭제">
										<input type="submit" value="변경">
									</div>
								</div>
							</c:if>
							<c:if test="${user_info.login_type != 'normal' && user_info.profile_img != 'undefined'}">
								<img src="${user_info.profile_img}">
							</c:if>
							<c:if test="${user_info.profile_img == 'undefined'}">
								<img src="${pageContext.request.contextPath}/resources/image/nhj_profile.png">
							</c:if>
						</form>
					</td>
				</tr>
				
				<tr>
					<th>등급</th>
					<td>
						<c:if test="${user_info.auth_lev == 'none'}">
							일반회원
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th>탈퇴신청</th>
					<td><input type="button" value="탈퇴" id="withdrawal_btn"></td>
				</tr>
				
			</tbody>
		</table>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>