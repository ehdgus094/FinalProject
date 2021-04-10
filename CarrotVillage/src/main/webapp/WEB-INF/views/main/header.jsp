<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon">
<style>
#top_wrap {
	position: fixed;
    z-index: 999;
    height: 24px;
    width: 100%;
    background: rgba(255,255,255,0.9);
}

#top_bar {
    width: 1200px;
    height: 100%;
    margin: 0 auto;
}

#nav_wrap.fixed {
	top:24px;
	position:fixed;
	z-index:10;
}

#top_bar .top_left {
	float:left;
	height:24px;
}

#top_bar .top_left img {
	margin:2px 0;
	width:20px;
	height:20px;
}

#top_bar .top_right {
    float: right;
    height: auto;
    font-size: 13px;
    margin: 3px 0;
    display: flex;
    flex-direction: column;
}

#top_bar .top_right ul {
	list-style:none;
	margin:0;
}

#top_bar .top_right li {
	display: inline-block;
    float: right;
    position: relative;
    margin-left: 10px;
    margin-right: 5px;
}

#top_bar .top_right a {
	color:#6f6f6f;
}

#top_bar a:hover {
	text-decoration:underline;
}
#user_btn {
	cursor:pointer;
}

#logo_wrap {
    z-index: 10;
    width: 100%;
    height: 90px;
    text-align: center;
    position: absolute;
    top: 24px;
    border-bottom: 1px solid #dcdcdc;
    border-top: 1px solid #dcdcdc;
    background: rgba(255,255,255,0.9);
}

#logo_bar {
	height: 100%;
    text-align: center;
    margin: 0 auto;
    width: 1200px;
}

#logo_bar a {
    color: orange;
    letter-spacing: 3px;
    font-size: 25px;
    line-height: 3.5em;
    text-transform: uppercase;
    font-weight: 800;
    text-decoration:none;
}

#top_btn {
	position:fixed;
	z-index:999;
	display:block;
	width:45px;
	height:45px;
	background:rgba(0,0,0,0);
	bottom:20px;
	right:20px;
	border-radius:50%;
	transition: background-color .3s, 
    			opacity .5s, visibility .5s;
    opacity: 0;
    visibility: hidden;
    cursor:pointer;
}

#top_btn.show {
  opacity: .9;
  visibility: visible;
}

#top_btn img {
	width:35px;
	height:35px;
	margin:5px auto;
	display:block;
	opacity:.9;
}

#msg_btn {
	position:fixed;
	z-index:999;
	display:block;
	width:45px;
	height:45px;
	background:rgba(0,0,0,0);
	bottom:20px;
	right:20px;
	border-radius:50%;
    opacity: .9;
    cursor:pointer;
    transition:0.8s;
}

#msg_btn img {
	width:30px;
	height:30px;
	margin:8px auto;
	display:block;
	opacity:.9;
}

#msg_btn:hover, #top_btn:hover {
	box-shadow: 0px 0px 3px 1px #5a5a5a;
	background:orange;
}

#login_btn {
	cursor:pointer;
}
</style>
</head>
<script>

	var loginFn = function(e) {
		e.preventDefault();
		var nWidth = 490;
		var nHeight = 630;			  

		var xPos = (document.body.clientWidth / 2) - (nWidth / 2); 
		xPos += window.screenLeft;	 //듀얼 모니터
		var yPos = (screen.availHeight / 2) - (nHeight / 2);

		window.open("${pageContext.request.contextPath}/main/login",
					"login/join_pop",
					"width=" + nWidth + ", height=" + nHeight + ", left=" + xPos
				  + ", top=" + yPos + ", toolbars=no, resizable=yes, scrollbars=no");
	}

	function logout() {
		$.ajax({
			url : "${pageContext.request.contextPath}/main/logout",
			success : function(rdata) {
				alert("로그아웃 되었습니다.");
				window.location.reload()
			}
		});
		sessionStorage.clear();
	}
	
	var userInfo = "${user_info}";
		
	$(document).ready(function() {
		
		var msg_state = sessionStorage.getItem('msg_state');
		if (msg_state == 1) {
			$("#msg_wrap").addClass("show");
		}

		var keepLoginState = sessionStorage.getItem("keepLoginState");
		
		if ($("#cookie").val().length > 0 && keepLoginState != "1") {
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/main/keepLogin",
				success : function() {
					sessionStorage.setItem("keepLoginState", "1");
					window.location.reload();
				}
			});
		}
		
		
		$('#top_btn').on('click', function(e) {
			e.preventDefault();
			$('html,body').animate({
				scrollTop : 0
			}, 600);
		});

		$(window).scroll(function() {
			var height = $(document).scrollTop();
			if (height > 90) {
				$('#nav_wrap').addClass('fixed');
				$('#top_btn').addClass('show');
				$("#logo_wrap").css("display", "none");
				$("#msg_btn").css("bottom", "75px");
				$("#nav_home").css("visibility", "visible");

			} else if (height < 90) {
				$('#nav_wrap').removeClass('fixed');
				$('#top_btn').removeClass('show');
				$("#logo_wrap").css("display", "block");
				$("#msg_btn").css("bottom", "20px");
				$("#nav_home").css("visibility", "hidden");
			}
		});

		$('#line-wrapper').click(function() {
			$('.line').removeClass('init');
			$('#line-top').toggleClass('line-top').toggleClass('top-reverse');
			$('#line-mid').toggleClass('line-mid').toggleClass('mid-reverse');
			$('#line-bot').toggleClass('line-bot').toggleClass('bot-reverse');

			$("#nav_all").toggleClass("show");
		});
		
		$("#login_btn").click(loginFn);
		

		$("#msg_btn").click(function() {
			$("#msg_wrap").toggleClass("show");
			
			if (msg_state == 0 || msg_state == null) {
				sessionStorage.setItem('msg_state', 1);
			} else if (msg_state == 1) {
				sessionStorage.setItem('msg_state', 0);
			}
		});
		
	
		$("#user_btn").click(function() {
			$("#user_info_tab").toggleClass("show");
		});
		
		$("#sc_btn").click(function(e) {
			if (!userInfo) {
				e.preventDefault();
				loginFn(e);
			} 
		});
		
	});
	
</script>

<input type="hidden" id="cookie" value="${cookie.saveLogin.value}">

<c:if test="${!empty user_info}">
	<a id="msg_btn"> 
		<img src="${pageContext.request.contextPath}/resources/image/nhj_msg.png">
	</a>
	
	<jsp:include page = "/WEB-INF/views/main/header-messenger.jsp" />
</c:if>

<a id="top_btn"> 
	<img src="${pageContext.request.contextPath}/resources/image/nhj_double_up.png">
</a>


<div id="header">
	<div id="top_wrap">
		<div id="top_bar">

			<div class="top_left">
				<img src="${pageContext.request.contextPath}/resources/image/nhj_pin2.png">
				<span></span>
			</div>

			<div class="top_right">
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/main/serviceCenter" id="sc_btn">고객센터</a>
					</li>
					
						<c:if test="${empty user_info}">				
							<li><a id="login_btn">로그인</a></li>
						</c:if>
						<c:if test="${!empty user_info}">			
							<li><a id="user_btn">${user_info.name} 님</a></li>
						</c:if>
				</ul>
		
				<jsp:include page = "/WEB-INF/views/main/header-user_info_tab.jsp" />

			</div><!-- .right end -->
			
		</div>
	</div>


	<div id="logo_wrap">
		<div id="logo_bar">
			<a href="${pageContext.request.contextPath}/main/mainPage">당근빌리지</a>
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/header-navigation.jsp" />
	
</div>