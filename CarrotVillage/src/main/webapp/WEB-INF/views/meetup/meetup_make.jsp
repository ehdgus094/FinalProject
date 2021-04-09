<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	width : 15%;
}
input:focus {outline:none;}

.all-content-center_make{
	margin: 5% ;
}

fieldset {
	margin : 5% 10%;
}
.control-form {
	display: grid;
    grid-template-columns: 20% 1fr;
    margin: 6% 1%;
}
legend {margin-bottom: 5%;}

textarea {
    width: 100%;
    height: 650px;
	resize: none;
	overflow: auto;
	border-color : orange;
	padding: 5%;
}
#content_wrap > div.all-content-center_make > form > fieldset > div:nth-child(8) > textarea {
	width: 100%;
    height: 300px;
	resize: none;
	overflow: auto;
}
input[type="text"] {
	border : none;
	border-bottom: 1px solid orange;
 }
 
select{
	width:120%;
	border :1px solid orange;
	padding: 4%;
}
.time-control {
	display: grid;
	grid-auto-flow: column;
}

.time-word{
	margin: 5% 0 5% 30%;
}

button{
	background-color: orange;
	color : white;
	border: none;
	padding : 1% 7%;
	width: 30%;
}
input[type="text"]:focus, select:focus, textarea:focus, button:focus {
	outline: none !important;
    border: 1px solid #ff9800;
    box-shadow: 0 0 10px #ff9800;
}
#content_wrap > div.all-content-center_make > form > fieldset > div:nth-child(9) > label:nth-child(2){
	background-color: orange;
	color : white;
	border: none;
	padding : 1.5% 8%;
	width: 30%;
}
button, select , textarea, #upfile1 {
	border-radius: 20px;
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
	  
	  <div class="all-content-center_make">
	  	
	  	<form method="post" action="#" enctype="multipart/form-data">
  		  <fieldset>
  			<legend>그룹생성폼</legend>
  			
  			<div class="control-form">
  			<label>그룹리더명</label>
  			<input type="text" id="name"><br>
  			</div>
  			
  			<div class="control-form">
  			<label>제목</label>
  			<input type="text" id="subject"><br>
  			</div>
  			
  			<div class="control-form">
  			<label>날짜</label>
  			<button type="">선택</button>
  			</div>
  			
  			<div class="control-form">
  			<label>시간</label>
  			  <div class="time-control">
	  			<div class="select-box mw30p">
	  	   		  	<select id="startTimeH">
	  	   		  	   <c:forEach var="hour" begin="0" end="23">
	  	   		  			<option value="<c:if test="${hour < 10}">0</c:if>${hour}">
	  	   		  			<c:if test="${hour < 10}">0</c:if>${hour}</option>
	  	   		  		</c:forEach>	
	  	   		  	</select>
	  	   		  	<span class="caret"></span>
	  	   		  </div>
	  	   		  <span class="time-word">시</span>
	  	   		  <div class="select-box mw30p">
	  	   		  <!-- 	<select id="startTimeM" class="form-control w100 ml5"> -->
	  	   		  	<select id="startTimeM" >
	  	   		  	   <c:forEach var="min" begin="0" end="59">
	  	   		  			<option value="<c:if test="${min < 10}">0</c:if>${min}">
	  	   		  			<c:if test="${min < 10}">0</c:if>${min}</option>
	  	   		  		</c:forEach>	
	  	   		  	</select>
	  	   		  	<span class="caret"></span>
	  	   		  </div>
	  	   		  <span class="time-word">분</span>
  	   		   </div>
  	   		  </div>
  	   		  
  	   		  <div class="control-form">
  	   		  <label>장소</label>
  			  <input type="text" id="location">
  			  </div>
  			  
  			  
  			  <div class="control-form">
  			  <label>내용</label>
  			 <textarea >
  			  		Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
		         	Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor 
		         	in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
		         	sunt in culpa qui officia deserunt mollit anim id est laborum.	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
		         	Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor 
		         	in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
		         	sunt in culpa qui officia deserunt mollit anim id est laborum.	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
		         	Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor 
		         	in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
		         	sunt in culpa qui officia deserunt mollit anim id est laborum.
  			</textarea> 
  			  </div>
  			  
  			  <div class="control-form">
  			  <label>공지사항</label>
  			  <textarea>
  			  		Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
		         	Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor 
		         	in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
		         	sunt in culpa qui officia deserunt mollit anim id est laborum.	
  			  </textarea>
  			  </div>
  			
  			<div class="control-form">
  	   		  <label for="board_file">파일첨부</label>
				<label for="upfile" id="upfile1">
					이미지첨부
				</label>
				<input type="file" name="uploadfile" id="upfile" style="display:none">
				<span id="filevalue"></span>
			</div>
  			
		 	
  		   </fieldset>
	   	 </form>
	  </div>
   </div>
		
	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
	</div>

</body>
</html>