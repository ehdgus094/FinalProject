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
#content-top {
	display: flex;
}
#title {
	text-align: center;
	font-weight: bold;
	margin-top:30px;
}
.fa-search {
	color : gray;
}
#search {
	display: flex;
	justify-content: flex-end;
}
#searching {
	margin-left : 10px;
	border: 1px solid lightgray;
}
#content_center {
	/* display : grid;
	grid-template-columns: repeat(4, 25%); */
	margin-top : 60px;
}
#famous  {
	display : flex;
	justify-content: space-between;
	margin: 40px 0 50px 0;
}
#interested {
	display : flex;
	justify-content: space-between;
	margin: 30px 0 50px 0;
}
.con_s {

}
.con_m {
	
}
.fa-eye {
	margin : 4px 5px 0 150px;
	color : #676565;
}
.head_content_s {
	display : flex;
	justify-content: space-between;
	color : green;
}
.head_content_m {
	display : flex;
	justify-content: space-between;
	color : orange;
}
.watch {
	color : black;
}
.group_sub {
	margin : 30px 0;
	font-weight: bold;
	font-size: 1.2em;
}

</style>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

		
		<div id="content_wrap"> 
			
		  <div id="content_top">
			  <div id="title">
				<h3>우리동네 소모임</h3>
			  </div>
			  <div id="search">
				 <i class="fas fa-search fa-2x " aria-hidden="true" ></i> 
				 <input type="text" id="searching" >
			  </div>
		  </div>
		  
		  <div id="content_center">
		  
		   <i class="fas fa-fire-alt" aria-hidden="true" >&nbsp;&nbsp;
		   		현재 회원님들이 가장 관심을 많이 보이는 그룹이에요! </i>
		  	 <div id="famous">
		  	 	<div class="con_s">
			  	 	<div class="head_content_s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con_s">
			  	 	<div class="head_content_s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con_s">
			  	 	<div class="head_content_s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 	<div class="con_s">
			  	 	<div class="head_content_s">무료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot.jpg">
		  	 	</div>
		  	 </div>
		  	 <hr>
		  	 
	  	 	 <i class="fas fa-heart" aria-hidden="true" >&nbsp;&nbsp;&nbsp;&nbsp;내가 관심을 보인 그룹이에요!</i>
		  	 	 	
		  	 <div id="interested">
		  	   <div class="con_m">
			  	 	<div class="head_content_m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	</div>
		  	 	 <div class="con_m">
			  	 	<div class="head_content_m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스 </div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	</div>
		  	 	 <div class="con_m">
			  	 	<div class="head_content_m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스 </div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		4월 3일 토 10:00 am
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marked-alt" aria-hidden="true" ></i>
			  	 	  		서울시 강남구 역삼동
			  	 	  </div>
		  	 	</div>
		  	 	<div class="con_m">
			  	 	<div class="head_content_m">유료
			  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
			  	 		 <div class="watch">350</div>
			  	 	</div>
			  	 	  <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg">
			  	 	  <div class="group_sub">플라워 원데이 클래스 </div>
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