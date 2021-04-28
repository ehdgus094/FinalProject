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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/nhr_meetup_detail.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cfa5659492a3a17b16d834a893be5d78&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/js/nhr_detail.js"></script>
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
.fa-search {color : lightgray;}
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
 #dislike_img , #like_img {
 	width: 25px;
    height: 25px;
    outline: none;
    border: none;
    box-shadow: none;
    margin: -2% 5% -2% 0;
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
.fa-eye {margin-left: 10%;}

.button_control {
	margin-bottom: 20%;
}
#deleteBtn:focus , #modifyBtn:focus, #listBtn:focus {
	outline: none !important;
    border: 1px solid #ff9800;
    box-shadow: 0 0 10px #ff9800;
}

#deleteBtn {
	background-color: #ff5722;
    color: white;
    border: none;
    padding: 1%;
    width: 10%;
    float: right;
    margin-right: 2%;
    border-radius: 10px;
}
#modifyBtn {
	background-color: #ffab00;
    color: white;
    border: none;
    padding: 1%;
    width: 10%;
    float: right;
    margin-right: 2%;
    border-radius: 10px;
}
#listBtn {
	background-color: #fae52b;
    color: white;
    border: none;
    padding: 1%;
    width: 10%;
    float: right;
    margin-right: 2%;
    border-radius: 10px;
}

</style>

<script>
   
$(document).ready(function(){
	  
	var groups_lat = ${groups.latitude};  
	var groups_lon = ${groups.longitude};
	var my_lat     = ${lat};
	var my_lon     = ${lon};
	   
	console.log("groups lat=" + ${groups.latitude}); 
	console.log("groups lon=" + ${groups.longitude});  
	console.log("세션 lat=" + ${lat});  
	console.log("세션 lon=" + ${lon});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(groups_lat, groups_lon), // 지도의 중심좌표
        level: 8 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다  

	// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	var positions = [
	    {   
	        content: '<div>나의 현재위치</div>', 
	        latlng: new kakao.maps.LatLng(my_lat, my_lon)
	    }, 
	    {
	        content: '<div>그룹 위치</div>', 
	        latlng: new kakao.maps.LatLng(groups_lat, groups_lon)
	    },
	];

	for (var i = 0; i < positions.length; i ++) {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng // 마커의 위치
	    });

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: positions[i].content // 인포윈도우에 표시할 내용
	    });

	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다   
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	//검색(공통)
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
	
	
	//가격체크
	  var price = "${groups.price}";
		if(price == ("무료")){
			$(".price").css('color','green');
		} else {
			$(".price").css('color','orange');
		}
   

		
	   $("#listBtn").click(function(){
		   location.href = "${pageContext.request.contextPath}/meetup/list";
	   });
	
	   $("#modifyBtn").click(function(){
		   location.href = "${pageContext.request.contextPath}/meetup/modify?num=${groups.num}";
	   });
	
	   $("#deleteBtn").click(function(){
		   confirm("정말 삭제하시겠습니까?")
		   location.href = "${pageContext.request.contextPath}/meetup/delete?num=${groups.num}";
	   });      
	   
	   
	   //groups_join();
	   //groups_like();
	   
    }); //ready          
  
    
  	//그룹참여하기
	 function groups_join() { 
		  $.ajax({  
			  	type : 'post',
				url : '../meetup/groups_join', 
				data : {
					groups_join_num : ${groups.num},     
					id : "${member.id}",
					birth : "${member.birth}",  
					gender : "${member.gender}",
					phone_num : "${member.phone_num}"
				},
				success : function(data) {  
						if(data.result == 1) {
							alert("그룹에 참여하였습니다.");  
						}else if(data.result == 0){
							alert("그룹에 참여에 실패하였습니다.");
						}else {
					    	alert("이미 참여하셨습니다.");
						}   
					$("#joined_member").text(data.joined_count);
					 },
					 error : function() {     
						 alert("에러");
					 }
				});   
			};    
		
		
		function groups_like() {
													//indexOf = 위치값 찾으면 0이상의숫자, 없으면 -1
			var status = $("#like_img").attr("src").indexOf("dislike"); //dislike = true //contains(js임)
			console.log("status=" + status);
			$.ajax({ 
				type: 'post',
				url : '../meetup/groups_like',
				data : {
					groups_like_num : ${groups.num},      
					id : "${member.id}",
					status : status
				},
				success : function(data) {
					var src = "${pageContext.request.contextPath}/resources/image/";     
					if(data.result == 1){            
						alert("좋아요");    
						src += "nhr_heart_like.png";
					} else if (data.result == 7) { //-1,0,1 아닌 수
						alert("좋아요취소");
						src += "nhr_heart_dislike.png";   
					}     
					$("#like_img").attr("src", src);
					$("#like_count").text(data.like_count); 
				 },
				 error : function() {     
					 alert("에러");
				 }
			 });
		 };    
		  
		 
  
</script>
</head>
<body>
<div id="wrap">

<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	
	<div id="content_wrap"> 
	
	  <input type="hidden" id="num" value="${groups.num}" name="num">
	  <input type="hidden" id="name" value="${member.name}" name="name">
	  <input type="hidden" id="id" value="${member.id}" name="id">
	  <input type=hidden id=g_latitude name=latitude value="${groups.latitude}">
	  <input type=hidden id=g_longitude name=longitude value="${groups.longitude}">
	  <input type=hidden id=lat name=lat value="${lat}">
	  <input type=hidden id=lon name=lon value="${lon}">
	
	  
	  
		 <div class="all-content-top">
		  <div id="title">
			<h3>우리동네 소모임</h3>
		  </div>
		   <div id="search">
				<div id="searchicon"><button class="sBtn"><i class="fas fa-search" aria-hidden="true" ></i></button></div>
				<input type="text" id="searching" value="${search_word}">
		  </div>
	    </div> 
	    
	   <div class = "all-content-center_detail">
	      <div class="info">
	          <table>
	          	<tr>
	          	   <td rowspan=6 >
	          	     <c:if test="${empty groups.img_file }">
	          	        <img src="${pageContext.request.contextPath}/resources/image/nhr_samplecarrot2.jpg" alt="" >
	          	     </c:if>
	          	     <c:if test="${!empty groups.img_file }">
	          	   	   <img src="${pageContext.request.contextPath}/resources/upload/meetup_groupsImg/${groups.img_file}">
	          	     </c:if>
	          	   	</td>
	          	   <td rowspan=6  style = "width: 20%"></td>
	          	  <td>  
	          	   <a href='javascript:groups_like();'>
						    <img src="${pageContext.request.contextPath}/resources/image/nhr_heart_dislike.png" alt="" id="like_img"></a>
		            <%-- <c:choose>
						  <c:when test="${member.name != null && member.name != groups.name}"> <!-- "${mno ne null}" -->
						    <a href='javascript:groups_like();'>
						    <img src="${pageContext.request.contextPath}/resources/image/nhr_heart_dislike.png" alt="" id="like_img"></a>
						  </c:when>
			  			  <c:otherwise>
				  			 <a href='javascript:login_need();'>
				  			 <img src="${pageContext.request.contextPath}/resources/image/nhr_heart_like.png" alt="" id="dislike_img"></a>
			  			  </c:otherwise>
			         </c:choose> --%>
			           <span id="like_count">${like_count}</span>  
		          	   <%-- <strong>${groups.like_count}</strong> --%>
					   <i class="fas fa-eye " aria-hidden="true" >&nbsp;&nbsp;${groups.view_count}</i> 
				  	   <span class="price">&nbsp;&nbsp;${groups.price}</span>
			  	   </td>
	          	</tr>
	          	<tr>
	          		<td colspan=3>${groups.subject}</td>
	          	</tr>
	          	<tr>
	          		<td colspan=3>
		          		<i class="fas fa-clock" aria-hidden="true" ></i>
		          		 ${groups.start_date}&nbsp; - &nbsp;${groups.end_date}
	          		 </td>
	          	</tr>
	          	<tr>
	          		<td colspan=3>
	          			<i class="fas fa-map-marker-alt" aria-hidden="true" ></i>
	          			${groups.location}
	          		<td>
	          	</tr>
	          	<tr>
	          		<td colspan=3 >
	          			 <i class="fas fa-user-friends" aria-hidden="true"></i>
	          			 <span id="joined_member">${joined_count}</span>
	          	   </td>
	          	</tr>
	          	<tr>
	          		<td><i class="fas fa-smile" aria-hidden="true"></i> &nbsp;${groups.name}</td>
	          		<td colspan=2 >
	          		  <c:if test ="${member.name != groups.name}">
	          			<i class="fas fa-hand-holding-heart " aria-hidden="true"></i>
	          		 	<a href='javascript:groups_join();' id="groupsJoin">그룹 참여하기</a>
	          		 </c:if>	
	          	    </td>
	          	</tr>
	          	
	          </table>
         </div>
         
         <hr>
         
		<div id="map" style="width:90%; height:450px; margin: 8% 5%;"></div> <!-- 지도 -->      
         	
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
					<sup id="count"></sup>
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
					<b class="comment_inbox_name" >${member.name}</b> <span
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
         
         <div class="button_control">
         	    <button id="listBtn">목록</button>
            <c:if test = "${member.name ==  groups.name}">
	         	<button id="modifyBtn">수정</button>
	         	<button id="deleteBtn">삭제</button>
         	</c:if>
         </div>
         
      </div>
    </div>
	
   <jsp:include page = "/WEB-INF/views/main/footer.jsp" />

 </div>

</body>
</html>