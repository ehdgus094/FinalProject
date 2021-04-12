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
#msg_left img {
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
	margin:10px 15px 0 0;
	border:none; 
}
#msg_slider span {
	background: #088835;
    border-radius: 50%;
    border:none;
    margin-top: 2px;
    cursor:pointer;
}
#msg_slider span:focus {
	outline:none;
}

.messages ul {
	list-style: none;
	padding:0;
	max-height:390px;
	overflow:auto;
	-ms-overflow-style: none;
	scrollbar-width: none;
}
.messages ul::-webkit-scrollbar {
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
</style>

<script>
$(function() {
	
	var slider_value = 100;
	
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
	
	/*
	$(document).on("mouseover", ".messages", function(e) {
		$("html, body").on("scroll mousewheel", function(e) {
			e.preventDefault();
			e.stopPropagation();
			return false;
		});
	});
	
	$(document).on("mouseout", ".messages", function() {
		$("html, body").off("scroll mousewheel");
	});
	*/
});
</script>

<div id="msg_wrap">
	
	<div id="msg_left" style="">
		<div>
			<img src="${pageContext.request.contextPath}/resources/image/nhj_white_hamburger.png">
			<div id="msg_slider" style="float:right;width:100px;"></div>
		</div>
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

<script>
	var beforeName = "";

	function newMessage() {
		var message = $("#msg_text_input").val();

		if ($.trim(message) == '') {
			return false;
		}

		output = '<li class="sent">'
			   + '  <div>'
			   + '    <span>' + timeStamp(true) + '</span>'
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

		moveScroll()

		return message;
	};
	
	/*
	$('.exit').click(function() {
		if (confirm("정말로 나가시겠습니까?")) {
			send("${name}님이 퇴장하셨습니다.out");
			ws.close;
		}
	});
	*/

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

	var url = "ws://${url}/boot.do?id=${user_info.name}&filename=${user_info.profile_img}&login_type=${user_info.login_type}";
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
	};

	//웹 소켓이 닫혔을 때 호출되는 이벤트입니다.
	//ws.onclose = function(event) {
	//	location.href = "logout";
	//}

	function send(message) {
		ws.send(message);//웹 소켓으로 message를 보냅니다.
	}
	
	function response(text) {
		//text의 전달 형식 - //java&/2019-7-4/bbs20197499521032.png&님이 퇴장하셨습니다.out
		arr = text.split('&');
		message = arr[3];
		//var out = "님이 퇴장하셨습니다.out";
		//var inin = "님이 입장하셨습니다.in";

		//입장과 퇴장의 경우 css가 가운데로 위치해야 해서 클래스 inout을 이용합니다.
		//if (message.indexOf(out) > -1 || message.indexOf(inin) > -1) {
		//	index = message.lastIndexOf('.');
		//	output = "<li class='inout'><p></p></li>";
		//	message = message.substring(0, index);
		//} else {
			name = arr[0];
			filename = arr[1];
			login_type = arr[2];
			/*if (name == beforeName) {
				output = "<li class='replies'>"
					   + "	<div>"
					   + "	  <div id='reply_wrap'>"
					   + "		  <div id='reply_content'>"
					   + "			  <p></p>"
					   + "		  </div>"
					   + "	  </div>"
					   + "    <span>" + timeStamp(false) + "</span>"
					   + "	</div>"
					   + "</li>";
			} else {*/
				output = "<li class='replies'>"
					   + "	<div>"
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
					   + "    <span>" + timeStamp(false) + "</span>"
					   + "	</div>"
					   + "</li>";
			//}
			
		//}
		$(".messages > ul").append(output);
		$('.messages>ul>li').last().find('p').text(message);

		moveScroll();
	}

	function moveScroll() {
		$('.messages > ul').scrollTop($('.messages > ul')[0].scrollHeight)
	}
	
	function timeStamp(isSent) {
		
		var UNIX_timestamp = Math.floor(new Date().getTime() / 1000);
		
        var date = new Date(UNIX_timestamp * 1000);
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