<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
#content_title {
	width:100%;
	height:70px;
	padding:10px 0 0 5px;
	border-bottom:1px solid #545454;
}
#content_title > span {
	font-size:25px;
	color:#545454;
	display: block;
    margin: 5px 0 0 5px;
}

/*------------- 여기까지 고정 css 속성 -------------*/

#content_wrap ul {
	list-style-type:none;
}
#board_wrap {
	width: 1000px;
    margin: 35px auto;
}
#board_wrap > div:nth-child(1) {
	display: flex;
    flex-direction: row-reverse;
}
#search_title {
    display: flex;
    margin: 12px 30px 0 0;
    height: 30px;
}
#search_title span {
    font-size: 13px;
    margin: 5px 15px;
    display: block;
    height: 20px;
}
#search_title a {
	margin: 4px 0;
    color: orange;
    font-size: 15px;
    height: 22px;
}
#order_by_wrap {
	height: fit-content;
    margin-top: 12px;
    margin-right: 15px;
}
#order_by {
	border: 1px solid silver;
    border-radius: 5px;
    width: 156px;
    height: 30px;
    display: flex;
    justify-content: space-between;
    cursor:pointer;
}
#order_by span:nth-child(1) {
	margin: 4px 10px;
    font-size: 12px;
}
#order_by span:nth-child(2) {
	width: 10px;
    height: 10px;
    background: url(${pageContext.request.contextPath}/resources/image/nhj_triangle_down.png) no-repeat;
    background-size: 10px 10px;
    display: block;
    margin: 9px 12px;
}

#order_by_list {
    display:none;
    background: white;
    border: silver solid 1px;
    border-radius: 5px;
    margin-top: 3px;
    position:absolute;
    width:156px;
}
#order_by_list.show {
	display:block;
}
#order_by_list ul {
	margin:0;
	padding:0;
	font-size:13px;
}
#order_by_list li {
	cursor:pointer;
	padding: 10px;
}
#order_by_list a {
	color: black;
    text-decoration: none;
    width: 100%;
    display: block;
}
#board_list {
	border-top: solid 1px #6b6b6b;
    margin-top: 20px;
}
#board_list ul {
	padding:0;
	margin:0;
}
#board_list li {
	padding:10px 15px;
	border-bottom: #dedede 1px solid;
}
#board_list li:hover {
	background:#f3f3f3;
}
#board_list li > div {
	display:flex;
	flex-direction:row;
}
#board_list li > div > div:nth-child(1) {
	width:60%;
	font-size:15px;
	margin:5px 0;
	display:flex;
}
#board_list li > div > div:nth-child(1) > a {
	overflow:hidden;
	max-width:540px;
	text-decoration:none;
	color:black;
}
#board_list li > div > div:nth-child(1) > span {
	color: orange;
    font-size: 16px;
    display: block;
    line-height: 18px;
    margin-left: 3px;
	font-weight:500;
}
#board_list li > div > div:nth-child(2) {
	width:18%;
	font-size: 14px;
	display:flex;
}
#board_list li > div > div:nth-child(2) img {
	width:30px;
	margin: 3px 0;
}
#board_list li > div > div:nth-child(2) > span {
	margin: 7px;
    display: block;
	overflow:hidden;
	max-width:120px;
}
#board_list li > div > div:nth-child(3) {
	width:12%;
}
#board_list li > div > div:nth-child(3) span {
	font-size: 14px;
    margin: 7px auto;
    display: block;
    width: fit-content;
}
#board_list li > div > div:nth-child(4) {
	width:10%;
}
#board_list li > div > div:nth-child(4) > div {
	display:flex;
	margin:0 auto;
	width:fit-content;
}
#board_list li > div > div:nth-child(4) img {
	width:16px;
	height:16px;
	font-size: 14px;
	display:block;
	margin:10px;
}
#board_list li > div > div:nth-child(4) span {
	display: block;
    margin-top: 7px;
    font-size: 14px;
}
#board_list + div {
	height:78px;
}
#board_list + div > a {
	float: right;
    margin: 20px 10px;
    height: 38px;
    width: 70px;
    border-radius: 5px;
    background: orange;
    border: none;
    color: white;
    font-size: 14px;
    padding: 8px 14px;
    display: block;
}
#board_list + div > a:hover {
	text-decoration:none;
}
#board_page ul {
	margin: 0 auto;
    padding: 0;
    display: flex;
    width: fit-content;
}
#board_page li {
	border-radius: 50%;
    width: 24px;
    height: 24px;
    display: flex;
}
#board_page li.back:hover {
	background:#f1f1f1;
}
#board_page ul a {
	width: 100%;
    height: 100%;
    display: flex;
    text-decoration:none;
    font-weight: 600;
}
#board_page ul img {
	width: 14px;
    height: 14px;
    display: block;
    margin: 5px;
}
#board_page span {
	font-size: 14px;
    margin: 5px auto;
    line-height: 14px;
}
#board_search_wrap {
	height:100px;
	display:flex;
}
#board_search_wrap > div {
	height: 34px;
    margin: 32px auto;
    width: fit-content;
    display: flex;
    padding: 4px;
    border: solid silver 1px;
}
#board_search_wrap img {
	width: 25px;
    height: 25px;
    cursor:pointer
}
#board_search_wrap input {
	border:none;
	width: 250px;
}
</style>
<script>
	
	if ("${write_result}") {
		alert("${write_result}");
	}
	
	if ("${delete_result}") {
		alert("${delete_result}");
	}

	$(function() {
		
		$("#write_btn").click(function(e) {
			
			if (!"${user_info}") {
				alert("로그인후 이용해주세요.");
				e.preventDefault();
				loginFn(e);
			}
			
		});
		
		$("#order_by").click(function() {
			$("#order_by_list").toggleClass("show");
		});
		
		$("#board_search_wrap img").click(function() {
			location.href = "${pageContext.request.contextPath}/board/list?search=" + $("#board_search").val();
		});
		
		$("#board_search").on('keyup', function(e) {
			if (e.which == 13) {
				location.href = "${pageContext.request.contextPath}/board/list?search=" + $(this).val();
			}
		});
		
		$("a.subject").click(function() {
			$.ajax({
				type : "post", 
				url : "${pageContext.request.contextPath}/board/readCount",
				data : { "num" : $(this).next().val() }
			});
		});
		
	});
	
</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
		<div id="content_title">
			<span>자유 게시판</span>
		</div>
		
		<div id="board_wrap">
		
			<div>
				
				<div id="order_by_wrap">
					<div id="order_by">
				
						<c:if test="${empty order_by}">
							<span>최신순</span>
						</c:if>
						<c:if test="${order_by == 'board_date'}">
							<span>최신순</span>
						</c:if>
						<c:if test="${order_by == 'readcount'}">
							<span>조회순</span>
						</c:if>
						<c:if test="${order_by == 'board_like'}">
							<span>추천순</span>
						</c:if>
					
						<span></span>
					</div>
					
					<div id="order_by_list">
						<ul>
							<li>
								<a href="${pageContext.request.contextPath}/board/list?search=${search}&order_by=board_date">
								최신순</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/board/list?search=${search}&order_by=readcount">
								조회순</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/board/list?search=${search}&order_by=board_like">
								추천순</a>
							</li>
						</ul>
					</div>
					
				</div> <!-- #order_by_wrap end -->
				
				<c:if test="${!empty search}">
					<div id="search_title">
						<span>현재 검색어 : ${search}</span>
						<a href="${pageContext.request.contextPath}/board/list">전체보기</a>
					</div>
				</c:if>
				
			</div>
		
			<div id="board_list">
			
				<ul>
					<c:if test="${listCount > 0}">
						<c:forEach var="list" items="${list}">
					
							<li>
								<div>
									<div>
										<a class="subject" href="${pageContext.request.contextPath}/board/view?num=${list.num}&id=${user_info.id}">${list.subject}</a>
										<input type="hidden" value="${list.num}">
										<span>[${list.commentListCount}]</span>
									</div>
									<div>
										<c:if test="${list.login_type == 'normal'}">
											<img src="${pageContext.request.contextPath}/resources/upload/member_image${list.profile_img}">
										</c:if>
										<c:if test="${list.login_type != 'normal' && list.profile_img != 'undefined'}">
											<img src="${list.profile_img}">
										</c:if>
										<c:if test="${list.profile_img == 'undefined'}">
											<img src="${pageContext.request.contextPath}/resources/image/nhj_profile.png">
										</c:if>
										
										<span>${list.name}</span>
									</div>
									<div>
										<span>${list.board_date}</span>
									</div>
									<div>
										<div>
											<img src="${pageContext.request.contextPath}/resources/image/nhj_eye.png">
											<span>${list.readcount}</span>
										</div>
									</div>
								</div>
							</li>
					
						</c:forEach>
					</c:if>
				</ul>
			
			</div>
			
			
			<div>
				<a href="${pageContext.request.contextPath}/board/write" id="write_btn">글쓰기</a> 
			</div>

			<div id="board_page">
				<ul>
					<c:if test="${page <= 1}">
						<li>
							<a>
								<img src="${pageContext.request.contextPath}/resources/image/nhj_arrow_left.png">
							</a>
						</li>
					</c:if>
					<c:if test="${page > 1}">
						<li class="back">
							<a href="${pageContext.request.contextPath}/board/list?page=${page - 1}&search=${search}&order_by=${order_by}">
								<img src="${pageContext.request.contextPath}/resources/image/nhj_arrow_left.png">
							</a>
						</li>
					</c:if>

					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a == page}">
							<li><a><span style="color:orange;cursor:default;">${a}</span></a></li>
						</c:if>
						<c:if test="${a != page}">
							<li class="back">
								<a href="${pageContext.request.contextPath}/board/list?page=${a}&search=${search}&order_by=${order_by}">
									<span style="color:black;">${a}</span>
								</a>
							</li>
						</c:if>
					</c:forEach>

					<c:if test="${page >= maxPage}">
						<li>
							<a>
								<img src="${pageContext.request.contextPath}/resources/image/nhj_arrow_right.png">
							</a>
						</li>
					</c:if>
					<c:if test="${page < maxPage}">
						<li class="back">
							<a href="${pageContext.request.contextPath}/board/list?page=${page + 1}&search=${search}&order_by=${order_by}">
								<img src="${pageContext.request.contextPath}/resources/image/nhj_arrow_right.png">
							</a>
						</li>
					</c:if>
				</ul>
			</div>

			<div id="board_search_wrap">
				<div>
					<input type="text" id="board_search">
					<img src="${pageContext.request.contextPath}/resources/image/kdh_search.png">
				</div>
			</div>
			
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
</div>
</body>
</html>