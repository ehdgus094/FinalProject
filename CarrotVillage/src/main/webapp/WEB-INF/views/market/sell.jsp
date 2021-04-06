<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

#content_body>b {font-size:30px}

form>input[type=text] {margin:20px 0}

label {width:50px}

.uploadfile {display:none}

#image_area {display:flex}

.card {width:200px}

.card-img-top {width:200px; height:200px}

.cancel {width:30px; position:relative; top:-13px; left:145px; opacity:0}

.cancel:hover {cursor:pointer}

</style>
<script>
$(document).ready(function() {
	var img_count = 0;
	var file_input_count = 0;
	
	//이미지 미리보기
	function show_img(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		if(filesArr.length + img_count <= 10) {
			index = 0;
			filesArr.forEach(function(f) {
				if(f.type.match('image.*')) {
					let num = index;
					var reader = new FileReader();
					reader.onload = function(e) {
						output = 
							  '<div class=card>'
							+	'<img class="card-img-top" src=' + e.target.result + ' alt=' + file_input_count+'-'+ num + '>'
							+	'<div class="card-img-overlay">'
							+		'<img class=cancel src="${pageContext.request.contextPath}/resources/image/kdh_cancel.png"'
							+	'</div>'
							+ '</div>';
						$('#image_area').append(output);
					}
					reader.readAsDataURL(f);
					img_count++;
					index++;
					$('#img_count').html(img_count + ' / 10');
				}
			});
			console.log($('.uploadfile')[1]);
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
		$(this).parent().parent().remove();
	});
	
	$('#add_img').click(function(event) {
		event.preventDefault();
		if(img_count < 10) {
			if($('.uploadfile').last().val() != '') {
				$('#image_area').before('<input type=file class=uploadfile name=uploadfile multiple>');				
				file_input_count++;
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
		this.submit();
	}); 
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
			<b>판매글 등록</b><hr>
			<form method=post action=sellProcess enctype="multipart/form-data">
				<label for=id>작성자</label>
				<input type=text id=id name=id value=작성자 readonly><br>
				
				<label for=subject>제목</label>
				<input type=text id=subject name=subject><br>
				
				<label for=price>가격</label>
				<input type=text id=price name=price>
				<label for=location>위치</label>
				<input type=text id=location name=location value=위치 readonly>
				<button>변경</button><br>
				<label for=content>내용</label>
				<textarea id=content name=content></textarea><br>
				<button id=add_img>이미지 추가</button><span id=img_count>0 / 10</span>
				<div id=image_area></div>
				<div>
					<input type=submit value=등록>
					<input type=reset value=취소>				
				</div>
			</form>
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>