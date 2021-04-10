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
	margin:0;
	height:100%;
}
#wrap {
	height:100%;
	width: 100%;
    display:grid;
    grid-template-rows: 175px auto 150px;
}
#content_wrap {
	width:1200px;
	margin:0 auto;
}

/*------------- 여기까지 고정 css 속성 -------------*/
p {margin:0}

#content_wrap {margin-top:20px}

#content_header {
	display:flex;
	justify-content:center;
}

#content_body {opacity:0}

#content_body>div:first-child {
	display:flex;
	justify-content:space-between;
	align-items:flex-end;
	padding-right:30px
}

#content_body>div:nth-child(3) {display:grid; grid-template-columns:1fr 1fr}

#content_body>div:first-child>b {font-size:30px}

#image_block {display:flex; align-items:center; justify-content:center}

#left, #right {width:40px; margin:0 10px; cursor:pointer}

#image_area {
	display:flex;
	width:500px;
	white-space:nowrap;
	border-radius:15px;
	overflow-y:hidden;
	overflow-x:auto;
	-ms-overflow-style:none;
	scrollbar-width:none;
	box-shadow:0 0 10px silver
}

#image_area::-webkit-scrollbar {display:none}

#image_area img {width:500px; height:500px}

#curr_img {text-align:center}

#curr_img>b {color:silver; cursor:default}
#curr_img>b:first-child {color:grey}

#detail {margin-left:100px; display:grid; margin-top:-20px}

#detail>div {
	font-size:20px;
	display:flex;
	align-items:center;
	justify-content:space-between;
	padding:0 30px
}

#detail>div:not(:last-child) {border-bottom:1px solid rgba(0,0,0,.1);}

.badge {font-size:20px}

#detail>div:last-child {justify-content:space-around}

#detail>div:last-child>button {
	border:0;
	border-radius:10px;
	padding:10px
}
#detail>div:last-child>button:focus {outline:0}
#detail>div:last-child>button:hover {background:orange; color:white}

</style>
<script>
$(document).ready(function() {
	$('#content_body').animate({
		opacity : 1
	}, 300, 'linear');
	
	var img_count = $('#image_area img').length;
	var curr_img = 0;
	var pending = false;
	
	//이미지 스크롤 조작
	$('#left').click(function() {
		if(!pending) {
	 		var curr_scroll = $('#image_area').scrollLeft();
			var scroll_index = (Math.floor(curr_scroll/500));
	 		if(curr_scroll > 0) {
	 			pending = true;
	 			//이미지 넘기기
	 			$('#image_area').animate({
	 				scrollLeft : (scroll_index-1)*500
	 			}, 200, 'linear', function() {
		 			pending = false;
	 			});
	 			curr_img--;
	 		} else {
	 			//이미지 마지막으로
	 			$('#image_area').animate({
	 				scrollLeft : (img_count-1)*500
	 			}, 200, 'linear', function() {
	 				pending = false;
	 			});
				curr_img = img_count-1;
	 		}
 			//현재 이미지 점 표시
 			$('#curr_img>b').css('color', 'silver');
 			$('#curr_img>b').eq(curr_img).css('color', 'grey');
		}
 	});
	$('#right').click(function() {
		if(!pending) {
	 		var curr_scroll = $('#image_area').scrollLeft();
			var scroll_index = (Math.floor(curr_scroll/500));
 			pending = true;
	 		if(curr_scroll < (img_count-1)*500) {
	 			//이미지 넘기기
	 			$('#image_area').animate({
	 				scrollLeft : (scroll_index+1)*500
	 			}, 200, 'linear', function() {
		 			pending = false;
	 			});
	 			curr_img++;
	 		} else {
	 			//이미지 처음으로
	 			$('#image_area').animate({
	 				scrollLeft : 0
	 			}, 200, 'linear', function() {
	 				pending = false;
	 			});
	 			curr_img = 0;
	 		}
 			//현재 이미지 점 표시
 			$('#curr_img>b').css('color', 'silver');
 			$('#curr_img>b').eq(curr_img).css('color', 'grey');
		}
 	});
	
	//이미지 개수 표시 ●
	for(var i=0; i<img_count; i++) {
		$('#curr_img').append('<b> ● </b>');
	}
	
	//가격 , 추가
	var price = '${usedItem.price}'.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	$('#detail>div').eq(3).find('p').html(price+'원');
	
	//날짜 추가
	var register_date = '${usedItem.register_date}'.substring(0,10);
	$('#detail>div').eq(4).find('p').html(register_date);
});
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
		<h2 id=content_header>
			중고 마켓
		</h2>
		<div id=content_body>
			<div>
				<b>${usedItem.subject}</b><p><i class="fas fa-eye " aria-hidden="true"></i> ${usedItem.viewcount}</p>
			</div><hr>
			<div>
				<div id=image_set>
					<div id=image_block>
						<c:if test="${!empty imglist[1]}">
							<span><img id=left src="${pageContext.request.contextPath}/resources/image/kdh_arrow_left.png"></span>
						</c:if>
						<div id=image_area>
							<c:if test="${empty usedItem.imagefolder}">
								<div>
									<img src="${pageContext.request.contextPath}/resources/image/kdh_default_image.png">						
								</div>
							</c:if>
							<c:if test="${!empty usedItem.imagefolder}">
								<c:forEach var="image" items="${imglist}">
									<div>
										<img src="${pageContext.request.contextPath}/resources/upload/market_image/${usedItem.imagefolder}/${image}">
									</div>
								</c:forEach>
							</c:if>
						</div>
						<c:if test="${!empty imglist[1]}">
							<span><img id=right src="${pageContext.request.contextPath}/resources/image/kdh_arrow_right.png"></span>
						</c:if>
					</div>
					<div id=curr_img></div>
				</div>
				<div id=detail>
					<div><b></b><p>No. ${usedItem.num}</p></div>
					<div>
						<b></b>
						<c:if test="${usedItem.sold == 'n'}">
							<span class="badge badge-warning">판매중</span>
						</c:if>
						<c:if test="${usedItem.sold == 'y'}">
							<span class="badge badge-success">판매완료</span>
						</c:if>
					</div>
					<div><b>판매자</b><p>${usedItem.id}</p></div>
					<div><b>가격</b><p></p></div>
					<div><b>등록일</b><p></p></div>
					<div><b>지역</b><p>${usedItem.location}</p></div>
					<div>
						<button><i class="fas fa-comment-dots" aria-hidden="true"></i> 메시지</button>
						<button><i class="fas fa-heart" aria-hidden="true"></i> 찜하기</button>
					</div>
				</div>
			</div><hr>
				내용 : ${usedItem.content}
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>