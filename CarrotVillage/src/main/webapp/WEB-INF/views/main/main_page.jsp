<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
html, body {
	margin:0;
}

#cnt_wrap {
	position:absolute;
	width:100%;
}
</style>
<script>
	$(document).ready(function() {
		
		console.log("${email}");
		
		$("#header").mouseenter(function() {
			var height = $(document).scrollTop();
			if (height < 80) {
				$('#nav_bar').addClass('fixed');
			}
		});
		$("#header").mouseleave(function() {
			var height = $(document).scrollTop();
			if (height < 80) {
				$('#nav_bar').removeClass('fixed');
			}
		});
		
	});
	
	
	var scroll = function(){
	    
	    var $nav = null,
	        $cnt = null,
	        moveCnt = null,
	        moveIndex = 0,
	        moveCntTop = 0,
	        winH = 0,
	        time = false;

	    $(document).ready(function(){
	        init();
	        initEvent();
	    });
	    
	    var init = function(){
	        $cnt = $(".content");
	    };
	    
	    var initEvent = function(){
	        $("html ,body").scrollTop(0);
	        winResize();
	        $(window).resize(function(){
	            winResize();
	        });
	       
	        $cnt.on("mousewheel", function(e){
	        	if (moveIndex != 3) {
		        	e.preventDefault();
	        	}
	            if(time === false){
	              wheel(e);
	            }
	        });
	    };
	        
	    var winResize = function(){
	        winH = $(window).height();
	        $cnt.children("div").height(winH);
	        $("html ,body").scrollTop(moveIndex.scrollTop);
	    };
	    
	    var wheel = function(e){
	        if(e.originalEvent.wheelDelta < 0){
	            if(moveIndex < 3){
	                moveIndex += 1;
	                moving(moveIndex);
	            };
	        }else{
	            if(moveIndex > 0){
	                moveIndex -= 1;
	                moving(moveIndex);
	            };
	        };
	    };
	    
	    var moving = function(index){
	        time = true
	        moveCnt = $cnt.children("div").eq(index);
	        moveCntTop = moveCnt.offset().top;
	        $("html ,body").stop().animate({
	            scrollTop: moveCntTop
	        }, 600, function(){
	          time = false;
	        });
	    };
	    
	};

	scroll();
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />
	
	<div id="cnt_wrap">
	
		<div class="content">
			<div class="cnt01" style="background-color:skyblue;height:100%;background:url(https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdAQdT9%2FbtqA6pSGU0J%2FyQXubF3i4kkiStb0zfM580%2Fimg.jpg) no-repeat"></div>
    		<div class="cnt02" style="background-color:silver;height:100%;"></div>
    		<div class="cnt03" style="background-color:yellow;height:100%;"></div>
    		<div class="cnt04" style="background-color:green;height:100%;"></div>
		</div>
		
		<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
		
	</div>
	
</div>

</body>
</html>