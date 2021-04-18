<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
/*------------------------- hbg_btn ----------------------*/
#hbg_btn {
	width:30px;
	height:30px;
	background:rgba(0,0,0,0);
  	margin: 16px 0 14px 0;
}

#hbg_btn #line-wrapper {
  cursor:pointer;
  width:30px;
  height:30px;
  position:relative;
}

#hbg_btn .init {
	animation:none !important;
}

#hbg_btn .line {
  background:black;
  margin:5px 2.5px;
  width:25px;
  height:3px; 
  box-shadow:0 0.5px 1.5px rgba(0,0,0,.5);
  position:relative;
}

#hbg_btn .line-top {
  animation:line-top .2s forwards ease-out,
  			line-top-rotate .2s .2s forwards ease-out;
}

#hbg_btn .top-reverse {
	animation:line-top-rotate-reverse .2s forwards ease-out,
  			  line-top-reverse .2s .2s forwards ease-out;
}

#hbg_btn .line-mid {
  animation:line-mid .2s forwards ease-out;
}

#hbg_btn .mid-reverse {
  animation:line-mid-invisible .2s forwards ease-out, 
            line-mid-reverse .2s .2s forwards ease-out;
}

#hbg_btn .line-bot {
  animation:line-bot .2s forwards ease-out,
  			line-bot-rotate .2s .2s forwards ease-out;
}

#hbg_btn .bot-reverse {
  animation:line-bot-rotate-reverse .2s forwards ease-out,
            line-bot-reverse .2s .2s forwards ease-out;
}

@keyframes line-top {
  0% {transform:translateY(0px)}
  100% {transform:translateY(7.8px)}
}

@keyframes line-top-reverse {
  0% {transform:translateY(7.8px)}
  100% {transform:translateY(0px)}
}

@keyframes line-top-rotate {
  0% {transform:translateY(7.8px) rotateZ(0deg)}
  100% {transform:translateY(7.8px) rotateZ(45deg)}
}

@keyframes line-top-rotate-reverse {
  0% {transform:translateY(7.8px) rotateZ(45deg)}
  100% {transform:translateY(7.8px) rotateZ(0deg)}
}

@keyframes line-mid {
  0% {transform:scale(1)}
  100% {transform:scale(0)}
}

@keyframes line-mid-reverse {
  0% {transform:scale(0)}
  100% {transform:scale(1)}
}

@keyframes line-bot {
  0% {transform:translateY(0px)}
  100% {transform:translateY(-7.8px)}
}

@keyframes line-mid-invisible {
  0% {transform:scale(0)}
  100% {transform:scale(0)}
}

@keyframes line-bot-reverse {
  0% {transform:translateY(-7.8px)}
  100% {transform:translateY(0px)}
}


@keyframes line-bot-rotate {
  0% {transform:translateY(-7.8px) rotateZ(0deg)}
  100% {transform:translateY(-7.8px) rotateZ(135deg)}
}

@keyframes line-bot-rotate-reverse {
  0% {transform:translateY(-7.8px) rotateZ(135deg)}
  100% {transform:translateY(-7.8px) rotateZ(0deg)}
}
/*------------------------- hbg_btn ----------------------*/


#nav_wrap {
    position: absolute;
    z-index: 10;
    width: 100%;
    box-shadow: 0 6px 10px -6px rgb(0 0 0 / 20%);
    background: rgba(255,255,255,0.9);
    top: 114px;
}

#nav_bar {
    text-align: center;
    width: 1200px;
    height: 60px;
    margin: 0 auto;
    display: flex;
    flex-direction: row;
}
#nav_lst {
	width:1134px;
}

#nav_bar #nav_lst ul {
	list-style: none;
    display: flex;
    justify-content: space-around;
    font-size: 18px;
    margin: 17px 0;
    padding: 0;
    width: 100%;
}

#nav_bar #nav_lst li {
	float:left;
	width:150px;
}

#nav_bar li a {
	color:#6f6f6f;
	font-weight:100;
	text-decoration:none;
}

#nav_bar li a:hover {
	cursor:pointer;
	border-bottom: 2px solid orange;
	color:black;
}

#nav_all {
	width: 1200px;
	margin:0 auto;
    max-height: 0;
    overflow: hidden;
    -webkit-transition: max-height .6s;
}

#nav_all.show {
	max-height:500px;
}

#nav_all a {
	color:#6f6f6f;
	font-size:13px;
	font-weight:100;
	cursor:pointer;
}

#nav_all a:hover {
	color:black;
	border-bottom:1px solid orange;
}

#nav_all > div {
	display: flex;
    justify-content: space-around;
    width: 1134px;
    float: right;
    margin-right:35px;
}

#nav_all ul {
	float:left;
	list-style:none;
	padding:0;
}

#nav_all li {
	margin-bottom: 5px;
	text-align:center;
	width:150px;
}
#nav_home {
	width:30px;
	height:30px;
	background:rgba(0,0,0,0);
  	margin:16px 6px 0 0;
  	visibility:hidden;
}
#nav_home img {
	width:25px;
	height:25px;
}
</style>

<script>
$(function() {
	$("#nav_home").mouseover(function() {
		$("#nav_home img").prop("src", "${pageContext.request.contextPath}/resources/image/nhj_home.png");
	});
	$("#nav_home").mouseout(function() {
		$("#nav_home img").prop("src", "${pageContext.request.contextPath}/resources/image/kdh_carrot.png");
	});
});
</script>

<div id="nav_wrap">

	<div id="nav_bar">

		<div id="hbg_btn">
			<div id="line-wrapper">
				<div id="line-top" class="line init top-reverse"></div>
				<div id="line-mid" class="line init mid-reverse"></div>
				<div id="line-bot" class="line init bot-reverse"></div>
			</div>
		</div>

		<div id="nav_lst">
			<ul>
				<li><a href="${pageContext.request.contextPath}/market/list">FLEA MARKET</a></li>
				<li><a href="${pageContext.request.contextPath}/meetup/list">MEETUP</a></li>
				<li><a href="${pageContext.request.contextPath}/sub/submarket">CARROT MART</a></li>
				<li><a href="#">navi4</a></li>
			</ul>
		</div>
		
		<div id="nav_home">
			<a href="${pageContext.request.contextPath}/main/mainPage">
				<img src="${pageContext.request.contextPath}/resources/image/kdh_carrot.png">
			</a>
		</div>

	</div>
	<!-- #nav_bar end -->

	<div id="nav_all">
		<div>
			<ul>
				<li><a>nav1-1</a></li>
				<li><a>nav1-2</a></li>
				<li><a>nav1-3</a></li>
				<li><a>nav1-4</a></li>
				<li><a>nav1-5</a></li>
			</ul>
			<ul>
				<li><a>nav2-1</a></li>
				<li><a>nav2-2</a></li>
				<li><a>nav2-3</a></li>
				<li><a>nav2-4</a></li>
				<li><a>nav2-5</a></li>
				<li><a>nav2-6</a></li>
				<li><a>nav2-7</a></li>
			</ul>
			<ul>
				<li><a>nav3-1</a></li>
				<li><a>nav3-2</a></li>
				<li><a>nav3-3</a></li>
				<li><a>nav3-4</a></li>
			</ul>
			<ul>
				<li><a>nav4-1</a></li>
				<li><a>nav4-2</a></li>
				<li><a>nav4-3</a></li>
				<li><a>nav4-4</a></li>
				<li><a>nav4-5</a></li>
				<li><a>nav4-6</a></li>
			</ul>
		</div>
	</div>

</div>
<!-- #nav_wrap end -->