<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지 - 중고마켓</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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

#content_wrap {margin-top:20px}

#content_header {
	display:flex;
	justify-content:center;
}

#grid_area {display:grid; grid-template:1fr 1fr / 310px 340px 50px; margin-bottom:20px}

#grid_area>label {display:flex; align-items:flex-end}

#grid_area>span:nth-child(4) {
	background:#f6f6f6;
	border-radius:15px;
	margin-right:30px
}
#grid_area>span:nth-child(4)>input {width:85%}

#grid_area>input {margin-right:30px}
#grid_area input:hover {background:#eaeaea}
#grid_area input:focus {outline:0}

#content_body>b {font-size:30px}

form {padding:0 20px}

form input[type=text], textarea {
	border:0;
	background:#f6f6f6;
	border-radius:15px;
	padding:10px 15px
}

label {font-weight:bold; margin-bottom:10px; font-size:20px}

form>input, form>textarea {width:700px; margin-bottom:20px}
form>input:hover, form>textarea:hover {background:#eaeaea}
form>input:focus, form>textarea:focus {outline:0}

textarea {
	height:300px;
	resize:none
}

.uploadfile {display:none}

#arrow_area {
	display:flex;
	justify-content:space-between;
	width:700px;
	position:relative;
	top:95px;
	z-index:10
}

#arrow_area>img {width:40px; opacity:0}
#arrow_area>img:hover {opacity:1; cursor:pointer}

#image_area {
	white-space:nowrap;
	width:702px;
	height:202px;
	background:#f6f6f6;
	margin:-25px 0 20px 0;
	border:1px solid #f6f6f6;
	overflow-y:hidden;
	overflow-x:auto;
	-ms-overflow-style:none;
	scrollbar-width:none;
}

#image_area::-webkit-scrollbar {display:none}

.card_container {width:200px; display:inline-block}

.card {width:200px; border:0; height:200px}

.card-img-top {height:200px}

.card-img-overlay {padding:0; text-align:right}

.cancel {width:30px; opacity:0; margin:7px}

.cancel:hover {cursor:pointer}

form button {background:orange; border:0; border-radius:10px; color:white}
form button:hover {background:#FFBB00}
form button:focus {outline:0}

#add_img {margin-right:20px}

form>div:last-child {display:flex; justify-content:center; width:700px}

form>div:last-child>input {
	margin:0 10px 30px 10px;
	border:0;
	width:100px;
	height:50px;
	border-radius:15px;
	font-size:18px
}
form>div:last-child>input:focus {outline:0}
form input[type=reset]:hover {background:#FFA7A7; color:white}
form input[type=submit]:hover {background:#B7F0B1; color:white}

</style>
<script>
$(document).ready(function() {
  	if('${member}' == '') {
		alert('로그인 후 이용해주시기 바랍니다.');
		history.back();
	}
	var img_count = 0;
	var file_input_count = 0;
	var delete_num = '';
	
	//이미지 미리보기
	function show_img(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		if(filesArr.length + img_count <= 10) {
			filesArr.forEach(function(f) {
				if(f.type.match('image.*')) {
					let num = file_input_count;
					var reader = new FileReader();
					reader.onload = function(e) {
						output = 
							  '<div class=card_container><div class=card>'
							+	'<img class="card-img-top" src=' + e.target.result + ' alt=' + num + '>'
							+	'<div class="card-img-overlay">'
							+		'<img class=cancel src="${pageContext.request.contextPath}/resources/image/kdh_cancel.png"'
							+	'</div>'
							+ '</div></div>';
						$('#image_area').append(output);
					}
					reader.readAsDataURL(f);
					img_count++;
					file_input_count++;
					$('#img_count').html(img_count + ' / 10');
				}
			});
		} else {
			alert('이미지 업로드 최대 개수는 10개 입니다.');
		}
	}
	
	$('form').on('change', '.uploadfile', show_img);
	
	$('#image_area').on('mouseenter', '.card-img-overlay', function() {
		$(this).children().css('opacity', '1');
	});
	$('#image_area').on('mouseleave', '.card-img-overlay', function() {
		$(this).children().css('opacity', '0');
	});
	
 	$('#image_area').on('click', '.cancel', function() {
		var index = $(this).parent().prev().attr('alt').split('-');
		$(this).parent().parent().parent().remove();
		img_count--;
		$('#img_count').html(img_count + ' / 10');
		delete_num += $(this).parent().prev().attr('alt') + ';';
		$('#image_area').scrollLeft(0);
	});
	
	$('#add_img').click(function(event) {
		event.preventDefault();
		if(img_count < 10) {
			if($('.uploadfile').last().val() != '') {
				$('#image_area').before('<input type=file class=uploadfile name=uploadfile multiple>');
			}
			$('.uploadfile').last().trigger('click');			
		} else {
			alert('이미지 업로드 최대 개수는 10개 입니다.');
		}
	});
	
 	$('form').submit(function(event) {
		event.preventDefault();
		if($('.uploadfile').last().val() == '') {
			$('.uploadfile').last().remove();
		}
		if(delete_num != '') {
			$('#delete_num').val(delete_num);
		}
		this.submit();
	});
 	$('#price').keyup(function() {
 		if(isNaN($(this).val())) {
 			alert('숫자를 입력해 주세요.');
 			$(this).val('').focus();
 		}
 	});
 	
 	//이미지 스크롤 조작
 	$('#arrow_area>img').first().click(function() {
 		var total_width = img_count * 200;
 		var curr_scroll = $('#image_area').scrollLeft();
 		if(total_width>700 && curr_scroll > 0) {
 			var scroll_index = Math.floor(curr_scroll/100);
 			if(scroll_index == 0 || scroll_index % 2 == 1) {
 				$('#image_area').animate({
 					scrollLeft : scroll_index*100-100
 				}, 100, 'linear');
 			} else {
 				$('#image_area').animate({
 					scrollLeft : scroll_index*100-200
 				}, 100, 'linear');
 			}		
 		}
 	});
 	$('#arrow_area>img').last().click(function() {
 		var total_width = img_count * 200;
 		var curr_scroll = $('#image_area').scrollLeft();
 		if(total_width>700 && total_width-700 > curr_scroll) {
 			var scroll_index = Math.floor(curr_scroll/100);
 			if(scroll_index == 0 || scroll_index % 2 == 0) {
 				$('#image_area').animate({
 					scrollLeft : scroll_index*100+100
 				}, 100, 'linear');
 			} else {
 				$('#image_area').animate({
 					scrollLeft : scroll_index*100+200
 				}, 100, 'linear');
 			}
 		}
 	});
 	
 	$('#location+button').click(function(event) {
 		event.preventDefault();
 		//위치 변경 기능 추가
 	});
});
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
	 	<c:if test="${!empty member.name}">
			<h2 id=content_header>
				중고 마켓
			</h2>
			<div id=content_body>
				<b>판매글 등록</b><hr>
				<form method=post action=sellProcess enctype="multipart/form-data">
					<label for=subject>제목</label><br>
					<input type=text id=subject name=subject required><br>
					
					<label for=id>작성자</label><br>
					<input type=text id=id name=id value="${member.name}" readonly><br>
					
					<span id=grid_area>
						<label for=price>가격</label>
						<label for=location>위치</label>
						<span></span>
						<span>
							<input type=text id=price name=price required>
							원
						</span>
						<input type=text id=location name=location value=위치 readonly>
						<button>변경</button>	
					</span>
					
					<label for=content>내용</label><br>
					<textarea id=content name=content required></textarea><br>
					
					<input type=hidden id=delete_num name=delete_num>
					
					<button id=add_img>이미지 추가</button><span id=img_count>0 / 10</span>
					<div id=arrow_area>
						<img src="${pageContext.request.contextPath}/resources/image/kdh_arrow_left.png">
						<img src="${pageContext.request.contextPath}/resources/image/kdh_arrow_right.png">					
					</div>
					<div id=image_area></div>
					<div>
						<input type=submit value=등록>
						<input type=reset value=취소>				
					</div>
				</form>
			</div>
		</c:if>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>