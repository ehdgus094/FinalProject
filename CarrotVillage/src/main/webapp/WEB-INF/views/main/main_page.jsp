<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
html,body {
	margin:0;
	height:100%;
	width:100%;
	background: #f6fcf1; 
}
#content_wrap {
	width:100%;
	position:absolute;
	top:0;
	min-width:1200px;
}
div.cnt01 > div:nth-child(1) {
	position: absolute;
    top: 10%;
    left: 27%;
}
div.cnt01 p {
	margin:0;
}
div.cnt01 p:nth-child(1),
div.cnt01 p:nth-child(2) {
	font-size: 60px;
    font-weight: 700;
}
div.cnt01 p:nth-child(3),
div.cnt01 p:nth-child(4) {
	color: orange;
    margin-left: 10px;
}
div.cnt01 > div:nth-child(2) {
	position: absolute;
    top: 22%;
    width: 100%;
}
div.cnt01 > div:nth-child(2) img {
	width: 55px;
    margin: 0 auto;
    display: block;
    cursor:pointer;
}
</style>
<script>

	//스크롤 기본이벤트를막고 화면 한칸씩 움직이게하는 함수
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
	        
	        $("#arrow_down").click(function() {
	        	moveIndex += 1;
                moving(moveIndex);
	    	});	
	        
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
	
	<div id="content_wrap">
	
		<div class="content">
		
			<div class="cnt01">
				<div>
					<p>당신 근처의</p>
					<p>당근빌리지</p>
					<p style="margin-top:10px;">중고 거래, 소모임, 내 근처 마트 장보기 등</p>
					<p>이웃과 함께 가깝고 따뜻한 당신의 근처를 만드세요.</p>
				</div>
				<div>
					<img src="${pageContext.request.contextPath}/resources/image/nhj_arrow_down.png" id="arrow_down">
				</div>
			</div>
			
    		<div class="cnt02" style="background-color:silver;height:100%;"></div>
    		<div class="cnt03" style="background-color:yellow;height:100%;"></div>
    		<div class="cnt04" style="background-color:green;height:100%;"></div>
    		
		</div>
		
		<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
		
	</div>
	
</div>

</body>
</html>