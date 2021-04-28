<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지 - 중고마켓</title>
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

#content_wrap {margin-top:20px}

#content_header {
	display:flex;
	justify-content:center;
}

#content_function {
	display:grid;
	grid-template-columns:1fr 1fr 1fr;
	margin:30px 0;
	opacity:0
}

#search {
	display:flex;
	justify-content:center;
	border-radius:20px;
	border:1px solid silver;
	padding:10px
}

#search > input {
	border:0;
	width:100%;
	background:none;
	padding:0
}

#search img {width:30px}

#sell {display:flex; justify-content:flex-end}

#content_body {
	display:grid;
	grid-template-columns:1fr 1fr 1fr 1fr;
	column-gap:3%;
}

#content_wrap button {border:0; background:none; padding:0}

#sell>button {
	background:orange;
	border-radius:20px;
	padding:10px;
	color:white
}

#content_wrap button:focus, #search input:focus {outline:0}

.article {
	opacity:0;
	margin-bottom:10%;
	position:relative;
	top:20px
}
.article:hover {cursor:pointer}

.article>img {
	width:100%;
	height:273px;
	border-radius:20px;
	box-shadow:0 0 10px silver
}

.article>* {margin-bottom:5px}

.article>div:nth-child(2)>b {
	font-size:20px
}

.article>div {
	width:273px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}

.article #item_num {display:none}
</style>
<script>
$(document).ready(function() {
	function show_gradually(index) {
		
		if($('.article:nth-child('+index+')').length > 0) {
			$('.article:nth-child('+index+')').animate(
					{
						opacity : 1,
						top : 0
					}, 150, 'linear', function() {
				show_gradually(index+1);
			});
		}
	}
	
	function load_articles() {
		$.ajax({
			url		: "${pageContext.request.contextPath}/market/loadList?page="+page+"&search="+search+"&region="+region,
			type	: "get",
			async	: false,
			success	: function(data) {
				if(page == 1 && data.length == 0) {
					$('#content_body').html('<p>게시글이 없습니다.</p>');
					moreData = false;
					return;
				}
				if(data.length == 0) {
					moreData = false;
				} else {
					var last_article = 0;
					if($('.article').length > 0) {
						last_article = $('.article').length;
					}
					output = '';
					$(data).each(function(index, item) {
						var price = item.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						output += '<div class=article>';
						if(item.imagefolder) {
							output += '<img src="${pageContext.request.contextPath}/resources/upload/market_image/'+item.imagefolder+'/'+item.thumbnail+'?'+Date.now()+'">'; 								
						} else {
							output += '<img src="${pageContext.request.contextPath}/resources/image/kdh_default_image.png">';
						}
						output += '<div>';
						if(item.price == '0') {
							output += '		<span class="badge badge-info">무료나눔</span>';
						} else if(item.sold == 'y') {
							output += '		<span class="badge badge-success">판매완료</span>';
						}
						output += '		<b>'+item.subject+'</b></div>';
						if(item.price == '0') {
							output += '		<div><i class="fas fa-clock" aria-hidden="true"></i> '+item.deadline.substring(0,16)+' 마감</div>';
						} else {
							output += '		<div><i class="fas fa-won-sign" aria-hidden="true"></i> '+price+'원</div>';
						}
						output += '		<div><i class="fas fa-map-marked-alt" aria-hidden="true" ></i> '+item.location+'</div>'
								+ '		<div id=item_num>'+item.num+'</div>'
								+ '</div>'
					});
					$('#content_body').append(output);
					show_gradually(last_article + 1);
					page++;
				}
			},
			error	: function() {
				//에러 처리
			}
		})
	}
//함수 영역 끝===============================================================================	
	$('#content_function').animate({
		opacity : 1
	}, 300, 'linear');
	
	var page = 1;
	var moreData = true;
	var search = '${search}';
	var region = '${region}';
	
	load_articles();
	
	if('${search}' != '') {
		$('#search>input').val('${search}');
	}
	
	if(region != '') {
		$('#select_region option[value=${region}]').prop('selected', true);
	} else {
		region = 'region';
	}
	
	$('#sell>button').click(function() {
		location.href="${pageContext.request.contextPath}/market/write";
	})
	
	//스크롤 내리면 데이터 ajax 로드
	$(window).scroll(function() {
		if(page>1 && moreData) {
			var scrolltop = $(document).scrollTop();
	        var height = $(document).height();
	        var height_win = $(window).height();
	        var footer = $('#foot_wrap').height();
	        
	        var eventHeight = height - height_win - footer;
	        
	        if(height_win < height && scrolltop > eventHeight) {
	        	load_articles();
	        }
		}
	});
	
	//검색 버튼 클릭 시
	$('#search>button').click(function() {
		var search = $(this).prev().val();
		if(search == '') {
			alert('검색어를 입력해 주세요.');
			$(this).prev().focus();
		} else {
			location.href="${pageContext.request.contextPath}/market/list?search=" + search + '&region=' + region;
		}
	});
	
	//검색창 엔터 클릭 시 이벤트
	$('#search>input').keydown(function(key) {
		if(key.keyCode == 13) {
			$(this).next().trigger('click');
		}
	});
	
	$('#content_body').on('click', '.article', function() {
		var num = $(this).find('#item_num').html();
		location.href="${pageContext.request.contextPath}/market/detail?num="+num;
	});
	
	//보기 옵션 선택 시
	$('#select_region').change(function() {
		region = $(this).val();
		location.href="${pageContext.request.contextPath}/market/list?search=" + search + '&region=' + region;
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
		<div id=content_function>
			<div>
				<select name=region id=select_region>
					<option value=region>지역별 보기</option>
					<option value=all>전체 보기</option>
				</select>
			</div>
			<div id=search>
				<input type=text placeholder="검색어를 입력해주세요.">
				<button><img src="${pageContext.request.contextPath}/resources/image/kdh_search.png"></button>	
			</div>
			<div id=sell><button>판매하기</button></div>
		</div>
		<div id=content_body>
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>