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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/nhr_meetup_detail.css">
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
input:focus {outline:none;}
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

img {
    width: 450px; 
    height: 450px;
    border-radius: 10px;
    outline: none !important;
    box-shadow: 0 0 10px #ffb01f;;
 }

#content_wrap > div.all-content-center_detail > div.info > table > tbody > tr:nth-child(2) > td {
	font-size: 1.3em;
	font-weight: bolder;
	margin : -3% 0;
}
.hashtag {
	margin : 8% 0;
	font-size: 1em;
	color : gray;
	word-spacing : 0.6em;
}
a {color : black}
a:hover {color : orange;}


#content_wrap > div.all-content-center_detail > div.info > table > tbody > tr:nth-child(3) > td {
	width : 35%; 
}
strong {margin-right: 10%;}
</style>

<script>
$(document).ready(function(){
	
	$('.fa-comment-dots').on('click', function(){
		$('#msg_wrap').open();
	});
	
	//글자수
	 $('.CommentBox').on('keyup', '.comment_inbox_text', function(){
		 var length = $(this).val().length;
		 $(this).prev().text(length + '/200');
	 });
	
	//가격체크
	  var price = "${groups.price}";
		if(price == ("무료")){
			$(".price").css('color','green');
		} else {
			$(".price").css('color','orange');
		}
  });



</script>
</head>
<body>
<div id="wrap">

<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	
	<div id="content_wrap"> 
	
	  <input type="hidden" id="num" value="${groups.num}" name="groups.num">
		
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
	          	   <td rowspan=6 ><img src="${pageContext.request.contextPath}/resources/upload/meetup_groupsImg/${groups.img_file}"></td>
	          	   <td rowspan=6  style = "width: 20%"></td>
	          	   <td>
		          	   <i class="fas fa-heart" aria-hidden="true" style="color:red"></i><strong>${groups.like_count}</strong>
					   <i class="fas fa-eye " aria-hidden="true" >&nbsp;&nbsp;${groups.view_count}</i> 
				  	   <span class="price">&nbsp;&nbsp;${groups.price}</span>
			  	   </td>
	          	</tr>
	          	<tr>
	          		<td colspan=3>${groups.subject}</td>
	          	</tr>
	          	<tr>
	          		<td colspan=3><i class="fas fa-clock" aria-hidden="true" ></i>${groups.start_date}&nbsp; - &nbsp;${groups.end_date}</td>
	          	</tr>
	          	<tr>
	          		<td colspan=3><i class="fas fa-map-marker-alt" aria-hidden="true" ></i>${groups.location}<td>
	          	</tr>
	          	<tr>
	          		<td colspan=3 > <i class="fas fa-user-friends" aria-hidden="true"></i>${groups.joined_member}</td>
	          	</tr>
	          	<tr>
	          		<td><i class="fas fa-smile" aria-hidden="true"></i> &nbsp;${member.name}</td>
	          		<td colspan=2><i class="fas fa-comment-dots" aria-hidden="true"></i><a href="#">채팅하기</a> </td>
	          	</tr>
	          	
	          </table>
         </div>	
         <hr>
         
         <div class="detail_exp">
            <div class="detail_title">
            	우리 모임은 이런 모임이에요! 
            </div>
            <div class="detail_main">
             ${groups.content}
	         	<div class="hashtag">
	         		#원데이플라워클래스 #예약 #일산 #취미 #단기 #좋아요
	         	</div>
         	</div>
         </div>
         <hr>
         
         <div class="detail_notice">
            <div class="detail_title">
            	공지사항 
            </div>
             <div class="detail_main">
	           ${groups.notice}
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
					<textarea placeholder="리뷰를 남겨주세요" rows="1"
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