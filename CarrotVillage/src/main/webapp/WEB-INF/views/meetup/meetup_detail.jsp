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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/meetup_detail.css">
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
.all-content-center_detail {
	/* display: grid;
    grid-template-rows: 45% 25% 10% 15%; */
    margin-top : 7%;
}
.info {
	margin : 5%;    
} 
table {border-spacing: 5%;}

.detail_exp, .detail_notice {
	 width: 85%; 
	 margin-left: 5%;
}
.detail_review{
	width: 90%; 
	margin : 0 0 10% 5%;
}

.detail_title , .comment_title{
	font-size: 1.1em;
	font-weight: bold;
	margin : 4% 0;
}
.detail_main{
	margin : 0 0 3% 7%;
}

i {margin-right : 5%}

img {widht: 400px; height: 400px;}

#content_wrap > div.all-content-center_detail > div.info > table > tbody > tr:nth-child(2) > td {
	font-size: 1.3em;
	font-weight: bolder;
	margin : -3% 0;
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
	    
	   <div class = "all-content-center_detail">
	      <div class="info">
	          <table>
	          	<tr>
	          	   <td rowspan=6 ><img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg"></td>
	          	   <td rowspan=6  style = "width: 20%"></td>
	          	   <td>
		          	   <i class="fas fa-heart" aria-hidden="true" > 580</i> 
					   <i class="fas fa-eye " aria-hidden="true" > 30</i> 
				  	   무료
			  	   </td>
	          	</tr>
	          	<tr>
	          		<td colspan=3>플라워 원데이 클래스플라워 원데이 클래스플라워 원데이 클래스</td>
	          	</tr>
	          	<tr>
	          		<td colspan=3><i class="fas fa-clock" aria-hidden="true" ></i> 4월 3일 토 10:00 am</td>
	          	</tr>
	          	<tr>
	          		<td colspan=3><i class="fas fa-map-marked-alt" aria-hidden="true" ></i>  서울시 강남구 역삼동<td>
	          	</tr>
	          	<tr>
	          		<td colspan=3 > <i class="fas fa-user-friends" aria-hidden="true"></i> 10 명</td>
	          	</tr>
	          	<tr>
	          		<td><i class="fas fa-smile" aria-hidden="true"></i> 플라워선생님123 </td>
	          		<td colspan=2><i class="fab fa-rocketchat" aria-hidden="true"></i> <a href="#">채팅하기</a> </td>
	          	</tr>
	          	
	          </table>
         </div>	
         <hr>
         
         <div class="detail_exp">
            <div class="detail_title">
            	우리 모임은 이런 모임이에요! 
            </div>
            <div class="detail_main">
             <p>
	         	공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기 위하여서 
	         	그리하였는가? 아니다 그들은 커다란 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 
	         	이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 
	         	석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 
	         	천하를그림자는 천고에 사라지지 않는 것이다 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 
	         	할지라도 창공에 반짝이는 뭇 별과 같이 산야에 피어나는 군영과 같이 이상은 실로 인간의 부패를
	         	</p>  <p>
	         	공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기 위하여서 
	         	그리하였는가? 아니다 그들은 커다란 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 
	         	이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 
	         	석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 
	         	천하를그림자는 천고에 사라지지 않는 것이다 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 
	         	할지라도 창공에 반짝이는 뭇 별과 같이 산야에 피어나는 군영과 같이 이상은 실로 인간의 부패를
	         	</p>  <p>
	         	공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기 위하여서 
	         	그리하였는가? 아니다 그들은 커다란 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 
	         	이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 
	         	석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 
	         	천하를그림자는 천고에 사라지지 않는 것이다 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 
	         	할지라도 창공에 반짝이는 뭇 별과 같이 산야에 피어나는 군영과 같이 이상은 실로 인간의 부패를
	           </p>
         	</div>
         </div>
         <hr>
         
         <div class="detail_notice">
            <div class="detail_title">
            	공지사항 
            </div>
             <div class="detail_main">
	            공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기 위하여서 
	            
	         	그리하였는가? 아니다 그들은 커다란 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 
	         	
	         	이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 
         	</div>
         </div>
         <hr>
         
         <div class="detail_review">
         
            <div class="CommentBox">
			<div class="comment_option">
				<div class="comment_title">
					리뷰 
					<sup id="count">10</sup>
				</div>
				
				<div class="comment_tab">
					<ul class="comment_tab_list">
					</ul>
				</div>
			</div><!-- comment option end-->

			<ul class="comment_list"> <!-- 등록된 댓글리스트 -->
			</ul>
			<div class="CommentWriter">
				<div class="comment_inbox">
					<b class="comment_inbox_name" >닉네임</b> <span
						class="comment_inbox_count">0/200</span>
					<textarea placeholder="댓글을 남겨보세요" rows="1"
						class="comment_inbox_text" maxLength="200"></textarea>
				</div>
				<div class="register_box" >
					<div class="button btn_cancel" >취소</div>
					<div class="button btn_register" >등록</div>
				</div>
			</div><!--CommentWriter end-->
		</div><!-- CommentBox end-->
	</div>
         
      </div>
    </div>
	
   <jsp:include page = "/WEB-INF/views/main/footer.jsp" />

 </div>

</body>
</html>