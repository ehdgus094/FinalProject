<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
</head>

<style>
input:focus { outline:none; }
button:focus { outline:none; }
#msg_wrap {
	position:fixed;
	bottom:0;
	right:80px;
	z-index:999;
	width:650px;
	visibility:hidden;
    height:460px;
    background:white;
    border-top-left-radius: 5px;
    border-top-right-radius: 5px;
    box-shadow: 0px 0px 12px 1px rgb(0 0 0 / 20%);
}

#msg_wrap.show {
	visibility:visible;
}
#msg_wrap > div {
	height:100%;
	float:left;
}
#msg_left {
	width:40%;
	border-top-left-radius: 5px;
	border-right:1px solid #dedede;
}
#msg_right {
	width:60%;
	border-top-right-radius: 5px;
	padding:10px;
}
#msg_left > div:first-child {
	width:100%;
	height:35px;
	background:#ffb52c;
	border-top-left-radius: 5px;
}
#msg_left > div:first-child > img {
	width:20px;
	height:15px;
	margin:10px;
	cursor:pointer;
}
#msg_input_wrap {
	width:100%;
	height:10%;
	display:flex;
}
#msg_text_input {
	width: 85%;
    height: 73%;
    margin: 8px 0 0px 3px;
    border-radius: 5px 0 0 5px;
    border: solid 1px silver;
    border-right:none;
}
#msg_send_btn {
	height: 32px;
    border: solid 1px silver;
    display: block;
    margin-top: 8px;
    width: 48px;
    border-radius: 0 3px 3px 0;
    background:orange;
}
#msg_send_btn:hover { box-shadow: 2px 0px 7px 1px rgb(0 0 0 / 20%); } 
#msg_send_btn > img {
	width:18px;
	height:18px;
	margin:0 0 4px 0;
}
#msg_slider { 
	margin:14px 15px 0 0;
	border:none; 
	height: 8px;
}
#msg_slider span {
	background: #006500;
    border-radius: 50%;
    border: none;
    margin-top: 2px;
    cursor: pointer;
    width: 15px;
    height: 15px;
}
#msg_slider span:focus {
	outline:none;
}

.messages ul {
	max-height:390px;
	overflow:auto;
}
#msg_wrap ul {
	list-style: none;
	padding:0;
	-ms-overflow-style: none;
	scrollbar-width: none;
}
#msg_wrap ul::-webkit-scrollbar {
	display:none !important;
}
.messages li {
	margin: 2px 10px 18px 10px;
	display:inline-block;
	width:350px;
}

.messages img {
	width:35px;
	height:35px;
}
.messages div {
	display:flex;
}
.messages p {
	margin-bottom:7px;
	font-size:13px;
	word-break: break-all;
}

#reply_img_wrap > div {
	width:auto;
	height:35px;
	border-radius:50%;
	margin: 10px 3px 0 7px;
}
#reply_wrap {
	flex-direction:row;
	background:#f1f1f1;
	border-radius:5px;
	min-width: 112px;
	max-width:60%;
}
#reply_content {
	margin: 4px 10px 6px 8px;
}
#reply_content_wrap {
	flex-direction:column;
}
#reply_name {
	margin-top: 6px;
}
#reply_name > span {
	font-size:15px;
	margin-left:8px;
}
.sent > div, .replies > div {
	align-items:flex-end;
}
.sent > div {
	justify-content:flex-end;
}
.sent > div > span {
	font-size:11px;
	color:silver;
	margin-right:6px;
}
.sent > div > div {
	border-radius:5px;
	background:#ffe1aa;
	max-width:60%;
}
.sent p {
	margin: 5px 10px 10px 10px;
}
.replies > div > span {
	font-size:11px;
	color:silver;
	margin-left:6px;
}
#msg_left_list {
    width: 100%;
    height: 100%;
}
#chat_room_list {
    width: 100%;
    height: 100%;
    display:flex;
    flex-direction:column;
}
#chat_search_list {
    width: 100%;
    height: 100%;
    display:flex;
    flex-direction:column;
}
#chat_menu {
	background: white;
    position: fixed;
    max-width:0;
    -webkit-transition: max-width .5s;
    display:flex;
    flex-direction: column;
    box-shadow: 1px 1px 4px 1px rgb(0 0 0 / 10%);
    overflow:hidden;
    height:48px;
    z-index:999;
}
#chat_menu.show {
	max-width:100px;
}
#chat_menu > a {
	width: 100%;
    height: 24px;
    font-size: 13px;
    color: #7d7d7d;
    padding: 3px 7px;
    cursor:pointer;
    overflow:hidden;
}
#chat_menu > a:hover {
	background:#e4e4e4;
}
#chat_menu > a:not(:last-child) {
	border-bottom: #e6e6e6 solid 1px;
}
#chat_search_input {
	width: 100%;
    height: 60px;
    display:flex;
    flex-direction:row;
    background: #ffb52c;
    color:#717171;
}
#chat_search_input > input {
	margin: 17px auto;
    height: 25px;
    border: 1px solid orange;
    border-radius: 5px;
}
#chat_search_input > input:focus {
	outline:none;
}
#chat_search_result {
	width: 100%;
    height: 365px;
    display: grid;
    grid-template-rows: 87%;
}
#chat_search_result > div {
	display: flex;
    flex-direction: row;
}
#chat_search_result ul {
	list-style: none;
    padding: 0;
    margin: 0;
    overflow:auto;
}
#chat_search_result li {
	height:50px;
}
#chat_search_result li {
	border-bottom: #ffa50052 1px solid;
}
#chat_search_result li:hover {
	box-shadow: 0px 0px 4px 1px rgb(255 131 0 / 15%) inset;
}
#chat_search_result li img {
	width:30px;
	height:30px;
	margin:10px 15px 10px 10px;
}
#chat_search_result label > div > div span {
	font-size:14px;
	color: #717171;
}
#chat_search_result li > label > div {
	display:flex;
	flex-direction:row;
}
#chat_search_result li > label > div > div {
	display:flex;
	flex-direction:column;
}

#chat_search_result > span {
	font-size: 14px;
    color: #565656;
    display: block;
    text-align: center;
    margin-top: 20px;
}
#chat_search_result input[type="checkbox"] {
	display: none;
}

#chat_search_result input[type="checkbox"]+label {
	display:flex;
	flex-direction:row;
	width: 100%;
	cursor: pointer;
	margin:0;
}

#chat_search_result input[type="checkbox"] + label > span {
	display: inline-block;
	width: 15px;
	height: 15px;
	vertical-align: middle;
	background:
		url(${pageContext.request.contextPath}/resources/image/nhj_unchecked.png)
		no-repeat;
	background-size: 15px 15px;
	cursor: pointer;
	border: none;
	margin-top: 17px;
}

#chat_search_result input[type="checkbox"]:checked + label > span {
	background:
		url(${pageContext.request.contextPath}/resources/image/nhj_checked.png)
		no-repeat;
	border: none;
	background-size: 15px 15px;
}
button.chat_search_btn {
	border: none;
    background: #ffb52c;
    font-size: 15px;
    height: 50px;
    width: 50%;
    color:white;
}
button.chat_search_btn:first-child {
	border-right: white solid 1px;
}
#chat_room_list ul {
	overflow: auto;
    height: 425px;
}
#chat_room_list li {
	border-bottom: #ffa50052 solid 1px;
	cursor:pointer;
	max-height:79px;
}
#chat_room_list li > div {
	display:flex;
	flex-direction:row;
	width:100%;
	height:100%;
	position:relative;
}
#chat_room_list li > div:nth-child(2) {
	z-index:9;
	height:77px;
}
#chat_room_list li > div:nth-child(3) {
	flex-direction:column;
	top:-77px;
	z-index:10;
	display:none;
	background:white;
	padding: 10px;
	box-shadow: 0px 0px 10px 1px rgb(255 152 0 / 15%) inset;
	cursor:auto;
}
#chat_room_list li > div:nth-child(3).show {
	display: flex;
}
#chat_room_list li > div > div:nth-child(1) {
	width: 25%;
}
div.chat_room_img {
	width: 64px;
    height: 64px;
    margin-top: 7px;
}
#chat_room_list li > div > div:nth-child(2) {
	width: 75%;
    height: 100%;
}
#chat_room_list li > div > div:nth-child(2) > div:nth-child(1) {
	width: 184px;
    display: flex;
    height: 22px;
    margin: 5px 5px 0 5px;
    justify-content:space-between;
}
#chat_room_list li > div > div:nth-child(2) > div:nth-child(2) {
	height:40px;
}
#chat_room_list li span:nth-child(1) {
	font-size: 12px;
    color: #4e4e4e;
    max-width: 109px;
    font-weight: 600;
}
#chat_room_list li span:nth-child(2) {
	float: right;
    font-size: 12px;
    color: #9c9c9c;
    width: 60px;
}
#chat_room_list p {
	overflow: hidden;
    font-size: 13px;
    color: #676767;
    height: 20px;
    margin: 10px;
}
div.img_count {
	width:64px;
	height:64px;
}
div.img_count_1 img {
	width:46px;
	height:46px;
	margin:9px;
}
div.img_count_2,
div.img_count_3,
div.img_count_4 {
	padding:6px;
}
div.img_count_2 img {
	width:32px;
	height:32px;
	position:relative;
}
div.img_count_3 img,
div.img_count_4 img {
	width:26px;
	height:26px;
}
div.img_count_2 img:nth-child(1) {
	z-index:1;
}
div.img_count_2 img:nth-child(2) {
	float:right;
	top:-12px;
	z-index:2;
}
div.img_count_3 img:nth-child(1) {
	display:block;
	margin:0 auto;
}

</style>

<script>
var currentRoomNum = 0;
var chat_members = ["${user_info.id}"];
var beforeId = "";

$(function() {
	
	var slider_value = 100;
	
	//세션에 투명도 슬라이더 상태를 저장/가져오기
	if (sessionStorage.getItem("slider_value") != null) {
		slider_value = sessionStorage.getItem("slider_value");
	}
	
	$("#msg_wrap").css("opacity", slider_value/100);
	
	$("#msg_slider").slider({
    	min : 30,
    	max : 100,
    	value : slider_value,
    	slide : function(e,ui){
			$("#msg_wrap").css("opacity", ui.value/100);
       		sessionStorage.setItem("slider_value", ui.value);
       		console.log(ui.value);
        }
	});
	
	//세션에 메신저창의 상태를 가져오기
	if (sessionStorage.getItem("chat_menu_state") != null) {
		if (sessionStorage.getItem("chat_menu_state") == "chat_room") {
			
			if (sessionStorage.getItem("currentRoomNum") != null) {
				currentRoomNum = sessionStorage.getItem("currentRoomNum");
			}
			getChatRoomList();
			
		} else if (sessionStorage.getItem("chat_menu_state") == "chat_search") {
			if (currentRoomNum = sessionStorage.getItem("currentRoomNum") != null) {
				currentRoomNum = sessionStorage.getItem("currentRoomNum");
				getMessageList(currentRoomNum);
			}
			getChatSearchList();
		} 
	} else {
		if (sessionStorage.getItem("currentRoomNum") != null) {
			currentRoomNum = sessionStorage.getItem("currentRoomNum");
		}
		getChatRoomList();
	}
	
	//메신저창에 마우스를 올리고 있을때 바깥부분 스크롤x
	/*
	$("#msg_wrap").mouseenter(function() {
	});
	
	$(document).on("mouseout", "#msg_wrap", function() {
		
	});
	*/
	
	//메신저 좌측 상단에 있는 햄버거 버튼
	$("#chat_menu_btn").click(function() {
		$("#chat_menu").toggleClass("show");
	});
	
	//햄버거버튼을 클릭 했을때 나오는 메뉴들 클릭
	$("#chat_room_btn").click(function() {
		currentRoomNum = 0;
		sessionStorage.setItem("currentRoomNum", 0);
		$(".messages > ul").empty();
		getChatRoomList();
		$("#chat_menu").removeClass("show");
		sessionStorage.setItem("chat_menu_state", "chat_room");
	});
	$("#chat_search_btn").click(function() {
		console.log(currentRoomNum);
		getChatSearchList();
		$("#chat_menu").removeClass("show");
		sessionStorage.setItem("chat_menu_state", "chat_search");
	});
	
	//대화상대 검색에서 체크박스 선택/해제시 배열에 추가/삭제
	$(document).on("change", "#msg_wrap input[type='checkbox']", function() {
		if ($(this).prop("checked")) {
			chat_members.push($(this).prop("id"));
		} else {
			var delete_index = chat_members.indexOf($(this).prop("id"));
			chat_members.splice(delete_index, 1);
		}
		console.log(chat_members);
	});
	
	//대화 시작 버튼
	$(document).on("click", ".chat_btn", function() {
		if (chat_members.length <= 1) {
			alert("대화를 시작할 상대를 고르세요.");
		} else {
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/main/chat",
				data : { "chat_members" : chat_members },
				success : function(rdata) {
					if (rdata.result == 1) {
						alert("채팅방이 이미 존재합니다.");
					}
					
					currentRoomNum = rdata.ChatRoom.num;
					getChatRoomList();
					$("#msg_text_input").focus();
				}
			});
		}
	});
	
	//대화 초대 버튼
	$(document).on("click", ".chat_invite_btn", function() {
		if (chat_members.length <= 1) {
			alert("대화를 초대할 상대를 고르세요.");
		} else if (currentRoomNum == 0) {
			alert("초대할 방을 선택하세요.");
		} else {
			
			$.ajax({
				type : "get",
				url : "${pageContext.request.contextPath}/main/roomMember",
				data : { "room_num" : currentRoomNum },
				success : function(rdata) {
					chat_members = chat_members.concat(rdata);
					console.log(chat_members);
					
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath}/main/chatInvite",
						data : { "room_num" : currentRoomNum, "chat_members" : chat_members },
						success : function(rdata) {
							currentRoomNum = rdata.ChatRoom.num;
							getChatRoomList();
							$("#msg_text_input").focus();
						}
					});
					
				}
			});
			
		}
	});
	
	//채팅방 나가기 버튼
	$(document).on("click", ".room_out_btn", function() {
		if (currentRoomNum == 0) {
			alert("나갈 방을 선택하세요.");
		} else {
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/main/chatOut",
				data : { "room_num" : currentRoomNum, "id" : "${user_info.id}" },
				success : function(rdata) {
					currentRoomNum = 0;
					getChatRoomList();
				}
			});
		}
	});
	
	//채팅 상대 검색창 입력시
	$(document).on("keyup", "#chat_search_input", function() {
		chatSearch();
	});
	
	//채팅 리스트 클릭
	$(document).on("click", "#chat_room_list li", function() {
		getMessageList($(this).find("input[type='hidden']").val());
		
		$(this).find("div:nth-child(3)").addClass("show");
		$("#chat_room_list li > div:nth-child(3)").not($(this).find("div:nth-child(3)")).removeClass("show");
	});
	
	$(document).on("mouseover", "#chat_room_list li div:nth-child(3)", function() {
		$(this).find("p").css("overflow", "auto");
		$(this).find("p").css("height", "auto");
	});
	$(document).on("mouseout", "#chat_room_list li div:nth-child(3)", function() {
		$(this).find("p").css("overflow", "hidden");
		$(this).find("p").css("height", "20px");
	});
	
	//메시지 전송
	$("#msg_text_input").on('keyup', function(e) {
		if (e.which == 13) { //엔터
			var message = newMessage(); //화면에 보이는 메시지 전송
			if (message) { //메시지가 존재하는 경우
				send(message); //소켓에 보내는 메시지 전송
			}
			return false;
		}
	});
	$("#msg_send_btn").on('click', function(e) {
		var message = newMessage(); //화면에 보이는 메시지 전송
		if (message) { //메시지가 존재하는 경우
			send(message); //소켓에 보내는 메시지 전송
		}
		return false;
	});
	
});

//채팅방 목록을 가져와서 출력하는 함수
function getChatRoomList() {
	$.ajax({
		type : "get",
		url : "${pageContext.request.contextPath}/main/roomList",
		data : { "id" : "${user_info.id}" },
		success : function(rdata) {
			var output = "<div id='chat_room_list'><ul style='list-style:none;padding:0;'>";
			if (rdata.length > 0) {
				$(rdata).each(function(index, item) {
				
					var roomImgArr = this.room_img.split(",");
					var roomMemberCount = roomImgArr.length;
					var roomMemberAllArr = this.room_all_member.split(", ");
					var roomMemberAllCount = roomMemberAllArr.length;
					
					output += "<li>"
							+ "    <input type='hidden' value='" + this.room_num + "'>"
							+ "    <div>"
							+ "        <div>"
							+ "		       <div class='chat_room_img'>";
							
					if (roomMemberCount == 1) {
						output += "<div class='img_count img_count_1'>";
						if (roomImgArr[0].substring(0,5) == "https") {
							output += "<img src='" + roomImgArr[0] + "'>";
						} else if (roomImgArr[0] == "undefined") {
							output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
						} else {
							output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + roomImgArr[0] + "'>";
						}
						output += "</div>";
					} else if (roomMemberCount == 2) {
						output += "<div class='img_count img_count_2'>";
						
						$(roomImgArr).each(function(index, item) {
							if (this.substring(0,5) == "https") {
								output += "<img src='" + this + "'>";
							} else if (this == "undefined") {
								output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
							} else {
								output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + this + "'>";
							}
						});
						
						output += "</div>";
					} else if (roomMemberCount == 3) {
						output += "<div class='img_count img_count_3'>";
						
						$(roomImgArr).each(function(index, item) {
							if (this.substring(0,5) == "https") {
								output += "<img src='" + this + "'>";
							} else if (this == "undefined") {
								output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
							} else {
								output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + this + "'>";
							}
						});
						
						output += "</div>";
					} else if (roomMemberCount >= 4) {
						output += "<div class='img_count img_count_4'>";
						
						$(roomImgArr).each(function(index, item) {
							if (this.substring(0,5) == "https") {
								output += "<img src='" + this + "'>";
							} else if (this == "undefined") {
								output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
							} else {
								output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + this + "'>";
							}
						});
						
						output += "</div>";
					}
							
					output += "		       </div>"
							+ "        </div>"
							+ "        <div>"
							+ "            <div>";
					
					if (roomMemberAllCount > 2) {
						output += "                <span>" + this.room_member.substring(0, 9) + " ..." + roomMemberAllCount + "</span>";
					} else {
						output += "                <span>" + this.room_member.substring(0, 9) + "</span>";
					}
							
					if (this.last_message_date != null) {
						output += "                <span>" + timeStamp(true, parseInt(this.last_message_date)) + "</span>";
					}
					output	+= "            </div>";
							
					if (this.last_message != null) {
						output += "            <div>"
								+ "                <p>" + this.last_message + "</p>"	
								+ "            </div>";
					}		
					output += "        </div>"
							+ "    </div>"
							+ "    <div>"
							+ "        <div style='display:flex;flex-direction:row;justify-content:space-between;width:100%;'>"
							+ "            <span>대화 상대</span>"
							+ "            <a style='font-size:12px;color:silver;cursor:pointer;' class='room_out_btn'>나가기</a>"
							+ "        </div>"
							+ "        <p>" + this.room_all_member + "</p>"
							+ "    </div>"
							+ "</li>";
				});
				output += "</ul>";
			} else {
				output += "<span style='margin:20px;display:block;text-align:center;color:dimgrey;'>채팅 목록이 없습니다.</span>";
			}
			output += "</div>";
			
			$("#msg_left_list").html(output);
			$("#msg_left_list").find("input[value='" + currentRoomNum + "']").parent("li").trigger("click");
		}
	});
	
}

//대화상대 검색 목록
function getChatSearchList() {
	chat_members = ["${user_info.id}"];
	var output =  "<div id='chat_search_list'>"
				+ "    <div id='chat_search_input'>"
				+ "        <input type='text' value=''>"
				+ "    </div>"
				+ "    <div id='chat_search_result'>"
				+ "    </div>"
				+ "</div>";
	$("#msg_left_list").html(output);
	chatSearch();
}
function chatSearch() {
	$.ajax({
		type : "get",
		url : "${pageContext.request.contextPath}/main/memberSearch",
		data : { "search" : $("#chat_search_input > input").val(), "sessionId" : "${user_info.id}" },
		success : function(rdata) {
			var output = "<span>검색 결과가 없습니다.</span>";
			
			if (rdata.memberList.length > 0) {
				output = "<ul>";
				$(rdata.memberList).each(function(index, item) {
					output += "<li>"
							+ "    <input type='checkbox' id='" + this.id +"'>"
							+ "    <label for='" + this.id + "'>"
							+ "        <div>";
							
					if (this.login_type == 'normal') {
						output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + this.profile_img + "'>";
					} else if (this.login_type != 'normal' && this.profile_img != 'undefined') {
						output += "<img src='" + this.profile_img + "'>";
					} else if (this.profile_img == 'undefined') {
						output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
					}
							
					output += "            <div style='width:175px;'>"	
							+ "                <span style='margin-top:3px;'>" + this.id + "</span>"
							+ "                <span>" + this.name + "</span>"
							+ "            </div>"
							+ "        </div>"
							+ "        <span></span>"
							+ "    </label>"
							+ "</li>";
				});
				output += "</ul>"
						+ "<div>"
						+ "    <button class='chat_search_btn chat_btn'>대화 시작</button>"
						+ "    <button class='chat_search_btn chat_invite_btn'>대화 초대</button>"
						+ "</div>";
			}
			
			$("#chat_search_result").html(output);
		}
	});
}

//데이터베이스에 저장되어있던 메시지 출력
function getMessageList(roomNum) {
	prevDate = 0;
	$(".messages > ul").empty();
	currentRoomNum = roomNum;
	sessionStorage.setItem("currentRoomNum", currentRoomNum);
	
	$.ajax({
		type : "get",
		url : "${pageContext.request.contextPath}/main/messageList",
		data : { "room_num" : currentRoomNum },
		success : function(rdata) {
			var output = "";
			if (rdata.length > 0) {
				$(rdata).each(function(index, item) {
					var time = parseInt(this.message_info.chat_date);
					
					if (this.message_info.member_id == "${user_info.id}") {
						output = '<li class="sent">';
						
						output += isFirstMessage(time);
						
						output+= '  <div>'
							   + '    <span>' + timeStamp(true, time) + '</span>'
							   + '    <div>'
							   + '      <div>'
							   + '	      <p>' + this.message_info.message + '</p>'
							   + '      </div>'
							   + '    </div>'
							   + '  </div>'
							   + '</li>';
					} else {
						
						
							if (index > 0 && rdata[index - 1].message_info.member_id == this.message_info.member_id) {
								output = "<li class='replies'>";
								
								output += isFirstMessage(time);
								
								output+= "	<div>"
									   + "	  <div id='reply_wrap' style='min-width:0;'>"
									   + "		<p style='margin: 5px 10px 10px 10px;'>" + this.message_info.message + "</p>"
									   + "	  </div>"
									   + "    <span>" + timeStamp(false, time) + "</span>"
									   + "	</div>"
									   + "</li>";
							} else {
								output = "<li class='replies'>";
								
								output += isFirstMessage(time);
								
								output+= "	<div>"
									   + "	  <div id='reply_wrap'>"
									   + "		  <div id='reply_img_wrap'>";
									   
								if (this.member_info.login_type == 'normal') {
									output += "<div><img src='${pageContext.request.contextPath}/resources/upload/member_image" + this.member_info.profile_img + "'></div>";
								} else if (this.member_info.login_type != 'normal' && this.member_info.profile_img != 'undefined') {
									output += "<div><img src='" + this.member_info.profile_img + "'></div>";
								} else if (this.member_info.profile_img == 'undefined') {
									output += "<div><img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'></div>";
								}
							
								output += "		  </div>"
									+ "		  <div id='reply_content_wrap'>"
									+ "		      <div id='reply_name'>"
									+ "			  	  <span>" + this.member_info.name + "</span>"
									+ "		      </div>"
									+ "		      <div id='reply_content'>"
									+ "				  <p>" + this.message_info.message + "</p>"
									+ "		      </div>"
									+ "		  </div>"
									+ "	  </div>"
									+ "    <span>" + timeStamp(false, time) + "</span>"
									+ "	</div>"
									+ "</li>";
							}
					
							
					}
						$(".messages > ul").append(output);
						
				});
			}
			moveScroll();
		}
	});
	
}

//메시지 생성
function newMessage() {
	time = new Date().getTime();
	if (currentRoomNum == 0) {
		$('#msg_text_input').val('');
	} else {
		var message = $("#msg_text_input").val();

		if ($.trim(message) == '') {
			return false;
		}
		
		output = '<li class="sent">';
		
		output += isFirstMessage(time);
		
		output+= '  <div>'
			   + '    <span>' + timeStamp(true, time) + '</span>'
			   + '    <div>'
			   + '      <div>'
			   + '	      <p></p>'
			   + '      </div>'
			   + '    </div>'
			   + '  </div>'
			   + '</li>';
			   
		$(output).appendTo($('.messages ul'));

		//입력한 내용들을 문자열로 변환하기 위해 text()를 이용합니다.
		$('.messages>ul>li').last().find('p').text(message);
		$('#msg_text_input').val('');
		
		message += " " + currentRoomNum;
		moveScroll()

		return message;
	}
};

/*
$('.exit').click(function() {
	if (confirm("정말로 나가시겠습니까?")) {
		send("${name}님이 퇴장하셨습니다.out");
		ws.close;
	}
});
*/
var url = "ws://${url}/boot.do?id=${user_info.id}"
		+	 				  "&name=${user_info.name}"
		+ 					  "&profile_img=${user_info.profile_img}"
		+ 					  "&login_type=${user_info.login_type}";
ws = new WebSocket(url);

//웹 소켓이 연결되었을 때 호출되는 이벤트
ws.onopen = function(event) {

};

//서버에서 전송하는 데이터를 받으려면 message이벤트를 구현하면 됩니다.
//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트입니다.
ws.onmessage = function(event) {
	console.log("받은 데이터" + event.data);
	//java&/2019-7-4/bbs20197499521032.png&님이 퇴장하셨습니다.out
	response(event.data);
	getChatRoomList();
};

//웹 소켓이 닫혔을 때 호출되는 이벤트입니다.
//ws.onclose = function(event) {
//	location.href = "logout";
//}

function send(message) {
	
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/main/insertMessage",
		data : { "id" : "${user_info.id}", "message" : message },
		success : function() {
			ws.send(message);//웹 소켓으로 message를 보냅니다.
			getChatRoomList();
		}
	});
	
}

function response(text) {
	//text의 전달 형식 - //java&/2019-7-4/bbs20197499521032.png&님이 퇴장하셨습니다.out
	arr = text.split('&');
	message = arr[5];
	//var out = "님이 퇴장하셨습니다.out";
	//var inin = "님이 입장하셨습니다.in";

	//입장과 퇴장의 경우 css가 가운데로 위치해야 해서 클래스 inout을 이용합니다.
	//if (message.indexOf(out) > -1 || message.indexOf(inin) > -1) {
	//	index = message.lastIndexOf('.');
	//	output = "<li class='inout'><p></p></li>";
	//	message = message.substring(0, index);
	//} else {
		id = arr[0];
		name = arr[1];
		filename = arr[2];
		login_type = arr[3];
		room_num = arr[4];
		time = new Date().getTime();
		
		if (room_num == currentRoomNum) {
			
			if (id == beforeId) {
				output = "<li class='replies'>";
				
				output += isFirstMessage(time);
				
				output+= "	<div>"
					   + "	  <div id='reply_wrap' style='min-width:0;'>"
					   + "		<p style='margin: 5px 10px 10px 10px;'></p>"
					   + "	  </div>"
					   + "    <span>" + timeStamp(false, time) + "</span>"
					   + "	</div>"
					   + "</li>";
			} else {
				output = "<li class='replies'>";
				
				output += isFirstMessage(time);
				
				output+= "	<div>"
					   + "	  <div id='reply_wrap'>"
					   + "		  <div id='reply_img_wrap'>";
					   
				if (login_type == 'normal') {
					output += "<div><img src='${pageContext.request.contextPath}/resources/upload/member_image" + filename + "'></div>";
				} else if (login_type != 'normal' && filename != 'undefined') {
					output += "<div><img src='" + filename + "'></div>";
				} else if (filename == 'undefined') {
					output += "<div><img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'></div>";
				}
			
				output += "		  </div>"
					+ "		  <div id='reply_content_wrap'>"
					+ "		      <div id='reply_name'>"
					+ "			  	  <span>" + name + "</span>"
					+ "		      </div>"
					+ "		      <div id='reply_content'>"
					+ "				  <p></p>"
					+ "		      </div>"
					+ "		  </div>"
					+ "	  </div>"
					+ "    <span>" + timeStamp(false, time) + "</span>"
					+ "	</div>"
					+ "</li>";
					
				$(".messages > ul").append(output);
				$('.messages>ul>li').last().find('p').text(message);
			}
		}
		
		moveScroll();
		berforeId = id;
}

function moveScroll() {
	$('.messages > ul').scrollTop($('.messages > ul')[0].scrollHeight)
}

var prevDate = 0;
function isFirstMessage(time) {
	var date = new Date(time);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var days = date.getDate();
	
	output = "<div style='width:100%;height:30px;display:flex;justify-content:space-between;margin-bottom:10px;'>"
		   + "    <div style='width:38%;height:1px;background:silver;margin-bottom:14px;'>"
		   + "    </div>"
		   + "    <div style='background:none;margin-bottom:6px;'>"
		   + "        <span style='font-size:13px;color:silver;font-weight:100;'>" + year + "-" + month + "-" + days + "</span>"
		   + "    </div>"
		   + "    <div style='width:38%;height:1px;background:silver;margin-bottom:14px;'>"
		   + "    </div>"
		   + "</div>";
	
	if (prevDate == 0 || prevDate != days) {
		prevDate = days;
		return output
	} else {
		prevDate = days;
		return "";
	}
}

//정수 형태의 시간데이터를 원하는 형태로 변환
function timeStamp(isSent, time) {
	//var UNIX_timestamp = Math.floor(new Date().getTime() / 1000);  //현재시간
	
    var date = new Date(time);
	
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var secends = date.getSeconds();
    var ampm = hours >= 12 ? '오후' : '오전';
    hours = hours % 12;
    hours = hours ? hours : 12;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    secends = secends < 10 ? '0' + secends : secends;
    
    var strTime = "";
    if (isSent) {
    	strTime = ampm + ' ' + hours + ':' + minutes;
    } else {
    	strTime =hours + ':' + minutes + ' ' + ampm;
    }
    return strTime;
}

</script>

<div id="msg_wrap">
	
	<div id="msg_left" style="">
		<div>
			<img src="${pageContext.request.contextPath}/resources/image/nhj_white_hamburger.png" id="chat_menu_btn">
			<div id="msg_slider" style="float:right;width:100px;"></div>
			<div id="chat_menu">
				<a id="chat_room_btn">내 채팅방 보기</a>
				<a id="chat_search_btn">대화상대 검색</a>
			</div>
		</div>
		<div id="msg_left_list"></div>
	</div>
	
	<div id="msg_right" style="display:flex;flex-direction:column">
	
		<div style="width:100%;height:90%;" class="messages">
			<ul>

			</ul>
		</div>
		
		<div id="msg_input_wrap">
			<input type="text" id="msg_text_input">
			<button id="msg_send_btn">
				<img src="${pageContext.request.contextPath}/resources/image/nhj_arrow_up.png">
			</button>
		</div>
		
	</div>
	
</div>
