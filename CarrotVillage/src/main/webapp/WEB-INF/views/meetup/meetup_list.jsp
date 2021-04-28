<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
    
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
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
.fa-search {color : lightgray;}
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
#searchicon > button {
	border: none;
    background: white;
}
input:focus , #searchicon > button:focus  {
	outline:none;
}
.fa-fire-alt, .fa-heart {
	font-size: 1.1em;
	margin-top: 5%;
}
.all-content-center_list {
	margin: -2% 0 5% 0;
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
	margin: 10% 4%;
}
.fa-eye {
	margin : 1.5% 0 0 65%;
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
	margin-bottom: 3%;
}
.body_content_m{
	padding : 2%;
}
.watch {
	color : black;
	margin-right: 4%;
}
.group_sub {
	margin : 8% 0;
	font-weight: bold;
	font-size: 1.2em;
}
a {color : black;}
a:hover {
    color: #433f3f;
    text-decoration: none;
 }
img {
	width: 270px;
    height: 270px;
    border-radius: 10px;
    outline: none !important;
    box-shadow: 0 0 10px #ffb01f;;
}

#more{
	text-align: center;
    font-weight: bolder;
    font-size: 1.2em;
    border: 3px solid #f1e8e8;
    padding: 1%;
    width: 20%;
    margin: 0 auto;
}

#more:hover {
   background-color: #f1e8e8;
   color: gray;
   font-weight: bolder;
}
  
.green {
	color : green
} 
.orange {
	color : orange
}

</style>

<script>
	$(function(){
		
		$('#searchicon>button').click(function(){
			var search_word = $('#search input').val();
			if(search_word == '') {
				alert('검색어를 입력하세요');
				$(this).focus();
				return false;
			} else {
				document.location.href="${pageContext.request.contextPath}/meetup/list?search_word=" + search_word;
			}
		});
		
		
	});//ready end
	
	
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

		
		<div id="content_wrap"> 
			
		  <input type="hidden" id="num" value="${num}" name="num">
			
		  <div class="all-content-top">
			  <div id="title">
				<h3>우리동네 소모임</h3>
			  </div>
			 <div><button class="btn btn-danger" onclick="document.location.href='make'">그룹만들기</button></div>
			  <div id="search">
				<div id="searchicon"><button><i class="fas fa-search" aria-hidden="true" ></i></button></div>
				 <input type="text" id="searching" value="${search_word}">
			  </div>
		  </div>
		  			
		  <div class="all-content-center_list">
		  
		   <i class="fas fa-fire-alt" aria-hidden="true" >&nbsp;&nbsp;
		   		현재 회원님들이 가장 관심을 많이 보이는 그룹이에요! </i>
		   		
	  	  <div id="famous">
	  	   
  	  		 <c:forEach items="${list}" var="f">
  	  		
  	  		 <div class="con-m">
		  	 	<div class="head-content-m">&nbsp;
		  	 	<span
		  	 	     <c:if test="${f.price == '무료'}"  >
		  	 	        class='green'
		  	 	     </c:if> 
		  	 	     <c:if test="${f.price == '유료'}"  >
		  	 	        class='orange'
		  	 	     </c:if> 
		  	 	 >
		  	 	${f.price}</span>
		  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
		  	 		 <div class="watch">${f.view_count}</div>
		  	 	</div>
		  	 	
		  	 	
		  	 	 <a href="${pageContext.request.contextPath}/meetup/detail?num=${f.num}">
		  	 	  	 <c:if test="${empty f.img_file }">
	          	        <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg" alt="" >
	          	     </c:if>
	          	     <c:if test="${!empty f.img_file }">
	          	      <img src="${pageContext.request.contextPath}/resources/upload/meetup_groupsImg/${f.img_file}">
			  	 	 <%--  <img src="${pageContext.request.contextPath}/resources/upload/meetup_groupsImg/${f.img_file_ori}"> --%>
	          	     </c:if>
			  	 	  <div class="group_sub">${f.subject }</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		${f.start_date}
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marker-alt" aria-hidden="true" ></i>
			  	 	  		${f.location}
			  	 	  </div>
		  	 	    </a>  
	  	 	    </div>
	  	  		</c:forEach>
		  	  </div>
	  	 		  <c:if test="${page_view *8 < count }">
	  	 		     <c:set var="viewPlus" value="${page_view + 1 }"/>
	  	 			  <div id="more"><a href="${pageContext.request.contextPath}/meetup/list?page_view=${viewPlus}">더보기</a></div>
	  	 		  </c:if> 
		  	 <hr>
		  	 
	  	 	<i class="fas fa-heart" aria-hidden="true" >&nbsp;&nbsp;&nbsp;&nbsp;
	  	 				내가 관심을 보인 그룹이에요!</i>
		  	 	 	
	  	     <div id="interested">
	  	         <c:forEach items="${like}" var="i"> <!-- key값 -->
  	  		
  	  		 <div class="con-m">
		  	 	<div class="head-content-m">&nbsp;
		  	 	<span
		  	 	     <c:if test="${i.price == '무료'}"  >
		  	 	        class='green'
		  	 	     </c:if> 
		  	 	     <c:if test="${i.price == '유료'}"  >
		  	 	        class='orange'
		  	 	     </c:if> 
		  	 	 >
		  	 	${i.price}</span>
		  	 		 <i class="fas fa-eye " aria-hidden="true" ></i>
		  	 		 <div class="watch">${i.view_count}</div>
		  	 	</div>
		  	 	 <a href="${pageContext.request.contextPath}/meetup/detail?num=${i.num}">
			  	 	  <c:if test="${empty i.img_file }">
	          	        <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg" alt="" >
	          	     </c:if>
	          	     <c:if test="${!empty i.img_file }">
			  	 	  <img src="${pageContext.request.contextPath}/resources/upload/meetup_groupsImg/${i.img_file}">
	          	     </c:if>
			  	 	  <div class="group_sub">${i.subject }</div>
			  	 	  <div class="group_time">
			  	 	  		<i class="fas fa-clock" aria-hidden="true" ></i>
			  	 	  		${i.start_date}
			  	 	  </div>
			  	 	  <div class="group_loc">
			  	 	  		<i class="fas fa-map-marker-alt" aria-hidden="true" ></i>
			  	 	  		${i.location}
			  	 	  </div>
		  	 	    </a>  
	  	 	    </div>
	  	  		
	  	  		</c:forEach>
		  	 </div>	
		  	 <c:if test="${page_like *8 < count }">
	  	 		     <c:set var="viewPlus" value="${page_like + 1 }"/>
	  	 			  <div id="more"><a href="${pageContext.request.contextPath}/meetup/list?page_like=${viewPlus}">더보기</a></div>
	  	 		  </c:if> 
		  </div>
			
		</div>
		
	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
	</div>

</body>
</html>