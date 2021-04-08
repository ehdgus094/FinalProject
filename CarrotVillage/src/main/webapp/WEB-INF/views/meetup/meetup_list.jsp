<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet"> <!--CDN 링크 -->
<style>

html, body {
	margin: 0;
	height: 100%;
}

#wrap {
	height: 100%;
	width: 100%;
	display: grid;
	grid-template-rows: 175px auto 150px;
}

#content_wrap {
	width: 1200px;
	margin: 0 auto;
}

/*------------- 여기까지 고정 css 속성 -------------*/
.all-content-top {
}
#title {
	text-align: center;
	font-weight: bold;
	margin-top:4%;
}
#search {
	display: flex;
	justify-content: flex-end;
}
#searchicon {
	color : gray;
	font-size : 1.4em;
}
#searching {
	margin-left : 10px;
	border : none;
	border-bottom: 2px solid lightgray;
}
input:focus {outline:none;
}
.fa-fire-alt, .fa-heart {
	font-size: 1.1em;
	margin-top: 5%;
}
.all-content-center_list {
	margin-top: -2%;
}
#famous, #interested  {
	display : grid;
	grid-template-columns:repeat(4, 1fr);
	margin: 4% 0 5% 0;
}
 
.con-s {
	margin : 10%;

}
.con-m {
	width: 82%;
	margin : 10%;
}
.fa-eye {
	margin : 1.5% 0 0 60%;
	color : #676565;
}
.head-content-s {
	display : flex;
	justify-content: space-between;
	color : green;
}
.head-content-m {
	display : flex;
	justify-content: space-between;
	color : orange;
}
.body_content_m{
	padding : 2%;
}
.watch {
	color : black;
	margin-right: 3%;
}
.group_sub {
	margin : 8% 0;
	font-weight: bold;
	font-size: 1.2em;
}
</style>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

		
		<div id="content_wrap"> 
			
		  <div class="all-content-top">
			  <div id="title">
				<h3>우리동네 소모임</h3>
			  </div>
			  <div id="search">
				 <div id="searchicon"><i class="fas fa-search" aria-hidden="true" ></i></div>
				 <input type="text" id="searching" >
			  </div>
		  </div>
		  
		  <div class="all-content-center_list">
		  
		   <i class="fas fa-fire-alt" aria-hidden="true" >&nbsp;&nbsp;
		   		현재 회원님들이 가장 관심을 많이 보이는 그룹이에요! </i>
		  	 <div id="famous">
		  	 	<div class="con-s">
			  	 	<div class="head-content-s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con-s">
			  	 	<div class="head-content-s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con-s">
			  	 	<div class="head-content-s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con-s">
			  	 	<div class="head-content-s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con-s">
			  	 	<div class="head-content-s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con-s">
			  	 	<div class="head-content-s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 </div>
		  	 <hr>
		  	 
	  	 	 <i class="fas fa-heart" aria-hidden="true" >&nbsp;&nbsp;&nbsp;&nbsp;내가 관심을 보인 그룹이에요!</i>
		  	 	 	
		  	 <div id="interested">
		  	   <div class="con-m">
			  	 	<div class="head-content-m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	 </div>
		  	 	  <div class="con-m">
			  	 	<div class="head-content-m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	 </div>
		  	 	  <div class="con-m">
			  	 	<div class="head-content-m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	 </div>
		  	 	  <div class="con-m">
			  	 	<div class="head-content-m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	 </div>
		  	 	 <div class="con-m">
			  	 	<div class="head-content-m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	 </div>
		  	 	 <div class="con-m">
			  	 	<div class="head-content-m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	 </div>
		  	 	 
		  	 </div>	
		  </div>
			
		</div>
		
	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
	</div>

</body>
</html>