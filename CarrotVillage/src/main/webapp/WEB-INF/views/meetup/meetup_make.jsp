<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet"> <!--CDN 링크 -->
<link href='http://bevacqua.github.io/rome/dist/rome.css' rel='stylesheet' type='text/css' />
<script src='http://bevacqua.github.io/rome/dist/rome.js'></script>
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
.fa-search {color : lightgray;}
#searching {
	margin-left : 10px;
	border : none;
	border-bottom: 2px solid lightgray;
	width : 15%;
}
.sBtn {
    background : white;
	color : gray;
}
.sBtn:focus {
    background : white;
	color : gray;
	font-size : 1.4em;
	outline: none !important;
    border: none;
    box-shadow: none;
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
.control-form1 {
	margin: 6% 0 10%;
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
#notice {
	width: 100%;
    height: 300px;
	resize: none;
	overflow: auto;
}
input[type="text"] {
	border : none;
	border-bottom: 1px solid orange;
 }
.input {
	border : 1px solid orange;
	border-radius: 20px;
	padding: 3% 5%;
    text-align: center;
}
select  {
	width:120%;
	border :1px solid orange;
	padding: 4%;
}
.date-control , .price-control , .file-control{
	display: grid;
	grid-auto-flow: column;
}
.price-control{
	margin-left: 25%;
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
input[type="text"]:focus, select:focus, textarea:focus, button:focus, date-control:focus {
	outline: none !important;
    border: 1px solid #ff9800;
    box-shadow: 0 0 10px #ff9800;
}
#upfile1 {
	background-color: orange;
	color : white;
	border: none;
	padding : 1.5% 8%;
	margin: 0 3% 0 12%;
}
button, select , textarea, #upfile1, .clearfix  {
	border-radius: 20px;
} 
.submitbtn {
	background-color: #ff5924;
	color : white;
	border: none;
	padding : 1.5% 4%;
	width: 15%;
	float : right;
}
.resetbtn{
	background-color: #fdd355;
	color : white;
	border: none;
	padding : 1.5% 4%;
	width: 15%;
	float : right;
	margin-right: 2%;
}

#date_gap {
	margin : 10% 10%;
	text-align: -webkit-center;
}


</style>

<script>
	$(document).ready(function(){
		/*
		//var a = ${member.name} 어떤값을 문자열 변수에 저장하려면 무조건 "" 필요 문법임(반환이 아니라 치환....)
		var b = "${member.name}"
		var c = "abc"
		//console.log(a)
		console.log(b)
		console.log(c)
		*/
		
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
		
		if("${member.name}" == '' ) {
			alert("로그인 후 게시글을 작성할 수 있습니다.");
			history.back(-1);
		}
		
		//뜸
		$('form').submit(function(){
			
			if($.trim($('#subject').val()) == ''){
				alert('제목을 입력하세요.');
		        $('#subject').focus();
		        return false;
			}
			 if($.trim($('#start').val()) == ''){
		        alert('시작일을 선택해주세요.');
		        $('#start').focus();
		        return false;
			 }
		     if($.trim($('#end').val()) == ''){
		           alert('종료일을 선택해주세요.');
		           $('#end').focus();
		           return false;
		      }; 
		      if($.trim($('#content').val()) == ''){
		           alert('내용을 입력하세요.');
		           $('#content').focus();
		           return false;
		      };
		});
		    
		    //datepicker - 오늘 날짜 이전으로 선택못하게 수정!!
		    rome(start, {
		    	  dateValidator: rome.val.beforeEq(end) 
		    	});

	    	rome(end, {
	    	      dateValidator: rome.val.afterEq(start)
	    	   });
		    
		    
	        var formData = new FormData($('#makeForm')[0]); 
	        
	        $.ajax({ 
	        	type: "POST", 
	        	enctype: 'multipart/form-data', 
	        	url: '/addFile',
	        	data: formData, 
	        	processData: false,
	        	contentType: false,
	        	cache: false, 
	        	success: function (result) {
	        	}, error: function (e) { 
	        	} 
	        });//ajax 
	        
	        $("#upfile").change(function(){
				console.log($(this).val())  // c:\fakepath\upload.png  -> 이렇게 내부적으로 관리함.
				var inputfile = $(this).val().split('\\');
				$('#filevalue').text(inputfile[inputfile.length -1]);
			})
	 	
	 }); //ready 
	 
</script>

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
				<div id="searchicon"><button class="sBtn"><i class="fas fa-search" aria-hidden="true" ></i></button></div>
				<input type="text" id="searching" value="${search_word}">
		  </div>
	  </div>
	  
	  <div class="all-content-center_make">
	  	
	  	<form  method="post" action="makeProcess" enctype="multipart/form-data" id="makeForm"><%--  action="makeProcess" --%>
  		  <fieldset>
  			<legend>그룹생성폼</legend>
  			
  			<input type=hidden id=latitude name=latitude value="${latitude}">
			<input type=hidden id=longitude name=longitude value="${longitude}">
  			
  			<div class="control-form">
  			<label>그룹리더명</label>
	  			<input 
	  			    type="text" 
	  			    id="name" 
	  			    name="name" 
	  			    value="${member.name}"
	  			    readonly
	  			 ><br>
  			</div>
  			
  			<div class="control-form">
  			<label>제목</label>
  				   <input 
  				      type="text" 
  				      id="subject" 
  				      name="subject" 
  				      placeholder="제목을 입력해주세요."
  				    ><br>
  			</div>
  			
  			<div class="control-form">
  			<label>가격</label>
	  		  <div class="price-control">
	  			<label>
	  				<input 
	  					type="radio" 
	  					class="price" 
	  					name="price"  
	  					value="무료" 
	  					checked
	  				  >&nbsp;무료
	  				</label>
	  			 <label>
  				     <input 
  			            type="radio" 
  			            class="price" 
  			            name="price"  
  			            value="유료"
  			          >&nbsp;유료
	  			   </label>
	  		   </div>
  			</div>
  			
  			<div class="control-form">
	  		  <label> 날짜, 시간 </label>
	  		    <div class="date-control">
	  			  <input 
		  			class= "input"
		  			id="start" 
		  			name = "start_date"
		  			placeholder="연도-월-일 시간:분"  
		  			value= ""
		  			required
	  		      />
	  		    <div id="date_gap">ㅡ</div>
	  			  <input 
		  			class="input"
		  			id="end" 
		  			name = "end_date"
		  			placeholder="연도-월-일 시간:분"  
		  			value= ""
		  			required
	  			  />
	  		   </div>	
		     </div>
  			  
  			  <div class="control-form">
  			  	 <label>위치</label>
  				   <input 
  				      type="text" 
  				      id="location" 
  				      name="location" 
  				      value="${address}"
  				    />
  			  </div>
  			  
  			  <div class="control-form">
  			  <label>내용</label>
  			  <textarea id="content" name="content" placeholder="최대 1500자까지 작성가능합니다."></textarea> 
  			  </div>
  			  
  			  <div class="control-form">
  			  <label>공지사항</label>
  			  <textarea id="notice" name="notice" placeholder="최대 800자까지 작성가능합니다."></textarea>
  			  </div>
  			  
  			  
  			
  			<div class="control-form1">
  	   		  <label for="board_file">파일첨부</label>
				<label for="upfile" id="upfile1">
					이미지첨부
				</label> <span id="filevalue" ></span>
				  <div class="file-control">
				    <input 
				        type="file" 
				        name="uploadfile" 
				        id="upfile" 
				        accept="image/*" 
				        style="display:none"
				     > 
			   </div>	 
			</div>
  			
  			<div class="clearfix">
				<button type="submit" class="submitbtn">등록</button>
				<button type="reset" class="resetbtn">취소</button>
		    </div>
		 	
  		   </fieldset>
	   	 </form>
		 
	  </div>
   </div>
		
	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
	</div>

</body>
</html>