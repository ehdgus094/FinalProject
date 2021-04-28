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

ul {
	list-style-type: none;
}
#board_view_wrap {
	margin: 36px auto;
    width: 1000px;
}
#board_view_wrap > div:nth-child(1) {
	height: 128px;
    border-bottom: silver 1px solid;
    padding: 0px 2px;
}
#board_view_title {
	height:70px;
	font-size:20px;
	display:flex;
}
#board_view_title span:nth-child(1) {
	margin: 10px 0 0 15px;
}
#board_view_title span:nth-child(2) {
	line-height: 25px;
    margin-left: 3px;
    margin-top: 10px;
    color:orange;
}
#board_view_title + div {
	display:flex;
	justify-content: space-between;
	padding:10px;
}
#board_view_title + div > div:nth-child(1) {
	display:flex;
	width: fit-content;
}
#board_view_title + div > a {
	display: block;
    color: #777777;
    font-size: 14px;
    height: 20px;
    margin-top: 8px;
}
#board_view_title + div > div:nth-child(2) a:hover {
	text-decoration:underline;
}
#board_view_name {
	display:flex;
}
#board_view_name img {
	width:36px;
	height:36px;
}
#board_view_name span {
	display: block;
    margin: 5px 0px 5px 10px;
    border-right: solid silver 1px;
    padding-right: 20px;
    height: 26px;
    color: #5f5f5f;
    font-weight: 600;
}
#board_view_date span {
	display: block;
    margin: 5px 0px 5px 20px;
    border-right: solid silver 1px;
    padding-right: 20px;
    height: 26px;
    color: #5f5f5f;
}
#board_view_date + div {
	display:flex;
}
#board_view_date + div img {
	width:20px;
	height:20px;
	display: block;
    margin: 8px 8px 5px 20px;
}
#board_view_date + div span {
	display: block;
    margin: 5px 0px 5px 0px;
    padding-right: 20px;
    height: 26px;
    color: #5f5f5f;
}
#board_view_content {
	padding: 20px 12px 40px 12px;
    border-bottom: solid 1px #e8e8e8;
}
#board_view_content > div:nth-child(1) {
	min-height: 150px;
    margin-bottom: 60px;
}
#board_view_content > div:nth-child(1) p {
	margin:0;
	white-space:pre;
}
#board_like {
	width: fit-content;
    border: silver 1px solid;
    display: flex;
    height: 40px;
    border-radius: 20px;
    margin: 0 auto;
    padding: 8px;
    justify-content: space-between;
    cursor:pointer;
}
#board_like img {
	display: block;
    width: 24px;
    height: 24px;
    margin-left: 12px;
    margin-right:10px;
}
#board_like span {
	display: block;
    font-weight: 600;
    width: fit-content;
    height: 24px;
    margin-right: 12px;
    line-height: 22px;
}
#comment_wrap {
	margin-top: 50px;
}
#comment_title {
	display: flex;
    justify-content: space-between;
    padding: 10px 12px 12px 12px;
    border-bottom: silver solid 1px;
}
#comment_title > div:nth-child(1) {
	display:flex;
}
#comment_title > div:nth-child(1) span {
	font-weight: 600;
    font-size: 18px;
    display: block;
    height: 24px;
    margin-top: 3px;
    margin-right: 5px;
}
#comment_title > div:nth-child(1) span:nth-child(2) {
	color:orange;
}
#order_by_wrap {
	height: fit-content;
}
#order_by {
	border: 1px solid silver;
    border-radius: 5px;
    width: 96px;
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
    width:96px;
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
#comment_write {
	padding: 0 12px;
	margin-top: 35px;
}
#comment_write > div {
	border:solid silver 1px;
}
#comment_write textarea {
	resize: none;
    width: 100%;
    padding: 10px;
    border:none;
    overflow: hidden;
}
#comment_write textarea:focus {
	outline:none;
}
#comment_write textarea + div {
	display:flex;
	justify-content:space-between;
	border-top: #ececec solid 1px;
}
#comment_write input[type="button"] {
	border: none;
    background: orange;
    height: 40px;
    width: 100px;
    color: white;
}
textarea.autosize + div > div:nth-child(1) span {
	display: block;
    font-size: 14px;
    color: #848484;
    margin: 10px 15px;
    height: 20px;
}
#comment_list {
	padding: 0px 12px;
}
#comment_list ul {
	padding:0;
	margin:0;
}
div.comment_title {
	display: flex;
    padding: 15px 0;
    justify-content:space-between;
}
div.comment_title > div {
	display: flex;
}
div.comment_title > div img {
    width: 30px;
    height: 30px;
}
div.comment_title > div span {
    display: block;
    height: 20px;
    margin-top: 5px;
    margin-left: 8px;
}
div.comment_title > div span:nth-child(2) {
	font-weight: 600;
    color: #4c4c4c;
    font-size: 15px;
}
span.writer_span {
	background: orange;
    font-size: 12px;
    border-radius: 5px;
    color: white;
    width: 44px;
    padding: 1px 4px;
    margin-top: 6px;
    margin-left: 5px;
}
.comment_date {
	margin-left: 15px;
    color: #5f5f5f;
    font-size: 14px;
    line-height: 24px;
}
div.comment_content {
	padding: 0 38px;
}
div.comment_content p {
	margin: 0;
    font-size: 14px;
    white-space:pre;
}
div.comment_btn_list {
	display: flex;
    padding: 15px 38px 20px 38px;
    border-bottom: #e8e8e8 1px solid;
}
div.comment_btn_list > div {
    border: silver 1px solid;
    width: fit-content;
    margin-right: 8px;
    display: flex;
    justify-content: space-between;
    cursor:pointer;
}
div.comment_btn_list img {
    width: 16px;
    height: 16px;
    margin: 5px 10px;
}
div.comment_btn_list span {
	margin-right: 10px;
}
#comment_list_more {
	display: block;
    width: fit-content;
    margin: 12px auto;
    color: #909090;
    font-size: 15px;
    cursor: pointer;
}
.comment_list_more:hover {
	text-decoration:underline;
}
.board_reply_wrap {
	background: #f7f7f7;
}
.reply_write {
	padding: 20px 38px;
}
.reply_write > div {
	border:solid silver 1px;
	background: white;
}
.reply_write textarea {
	resize: none;
    width: 100%;
    padding: 10px;
    border:none;
    overflow: hidden;
}
.reply_write textarea:focus {
	outline:none;
}
.reply_write textarea + div {
	display:flex;
	justify-content:space-between;
	border-top: #ececec solid 1px;
}
.reply_write input[type="button"] {
	border: none;
    background: orange;
    height: 40px;
    width: 100px;
    color: white;
}
div.reply_title {
	display: flex;
    padding: 15px 38px;
    justify-content:space-between;
}
div.reply_title > div {
	display: flex;
}
div.reply_title > div img {
    width: 30px;
    height: 30px;
}
div.reply_title > div span {
    display: block;
    height: 20px;
    margin-top: 5px;
    margin-left: 8px;
}
div.reply_title > div span:nth-child(2) {
	font-weight: 600;
    color: #4c4c4c;
    font-size: 15px;
}
span.writer_span {
	background: orange;
    font-size: 12px;
    border-radius: 5px;
    color: white;
    width: 44px;
    padding: 1px 4px;
    margin-top: 6px;
    margin-left: 5px;
}
.reply_date {
	margin-left: 15px;
    color: #5f5f5f;
    font-size: 14px;
    line-height: 24px;
}
div.reply_content {
	padding: 0 76px;
}
div.reply_content p {
	margin: 0;
    font-size: 14px;
    white-space:pre;
}
div.reply_btn_list {
	display: flex;
    padding: 15px 76px 20px 76px;
    border-bottom: #e8e8e8 1px solid;
}
div.reply_btn_list > div {
    border: silver 1px solid;
    width: fit-content;
    margin-right: 8px;
    display: flex;
    justify-content: space-between;
    cursor:pointer;
    background:white;
}
div.reply_btn_list img {
    width: 16px;
    height: 16px;
    margin: 5px 10px;
}
div.reply_btn_list span {
	margin-right: 10px;
}
#delete_report_wrap {
	display: flex;
    flex-direction: row-reverse;
}
#delete_report_wrap a {
	
}
.comment_delete_btn,
.reply_delete_btn {
	height: 20px;
    font-size: 13px;
    color: #868686;
    cursor: pointer;
    display: block;
    margin-top: 5px;
}

</style>
<script>

	$(function() {
		
		boardNum = $("#board_num").val();
		currentPage = 1;
		currentSort = "comment_date desc";
		currentCommentCount = 5;
		commentListData = null;
		
		commentListData = { "board_num" : boardNum, "id" : "${user_info.id}" };
		getCommentList(commentListData);
		
		$("#order_by").click(function() {
			$("#order_by_list").toggleClass("show");
		});
		
		$(document).on("keyup", "textarea.autosize", function() {
			$(this).height(1).height($(this).prop("scrollHeight") + 4);
			
			var length = $(this).val().length;
			if (length > 1000) {
				length = 1000;
				$(this).val($(this).val().substring(0, length));
			}
			
			if (length == 1000) {
				$(this).next().find("div").first().find("span").css("color", "red");
			} else {
				$(this).next().find("div").first().find("span").css("color", "#848484");
			}
			
			$(this).next().find("div").first().find("span").text(length + "/1000");
		});
		
		$("#comment_write_btn").click(function() {
			
			if (!"${user_info}") {
				alert("로그인후 이용해주세요.");
			} else {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/board/commentInsert",
					data : { "id" : "${user_info.id}",
							 "board_num" : $("#board_num").val(),
							 "content" : $("#comment_write textarea").val() },
					success : function() {
						alert("댓글이 등록되었습니다.");
						window.location.reload();
					}
				});
				
				$("#comment_write textarea").val("");
				$("#comment_count").text("0/1000");
				
			}
			
		});
		
		$(document).on("click", "#comment_list_more", function() {
			commentListData = {
				"board_num" : boardNum,
				"page" : currentPage,
				"sort" : currentSort,
				"id" : "${user_info.id}"
			};
			
			getCommentList(commentListData);
		});
		
		$("li.sort").click(function() {
			$("#order_by_list").removeClass("show");
			$("#order_by span:nth-child(1)").text($(this).find("a").text());
			
			currentSort = $(this).find("input[type='hidden']").val();
			currentPage = 1;
			currentCommentCount = 5;
			
			commentListData = {
				"board_num" : boardNum,
				"sort" : currentSort,
				"id" : "${user_info.id}"
			};
			
			$("#comment_list ul").empty();
			$("#comment_list ul").next().empty();
			getCommentList(commentListData);
		});
		
		$(document).on("click", ".reply_list_btn", function() {
			state = $(this).find("input.state").val();
			listWrap = $(this).parent().next("div.board_reply_wrap");
			commentNum = $(this).parent().parent().next().val();
			if (state == 0) {
				
				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/board/replyList",
					data : { "comment_num" : $(this).find("input[type='hidden']").val(), "id" : "${user_info.id}" },
					success : function(rdata) {
						var output = "";
						output += "<div class='reply_write'>"
								+ "    <div>"
								+ "        <textarea class='autosize' placeholder='댓글을 입력해 주세요.'></textarea>"
								+ "        <div>"
								+ "            <div>"
								+ "                <span>0/1000</span>"
								+ "            </div>"
								+ "            <div>"
								+ "                <input type='button' value='등록' class='reply_write_btn'>"
								+ "                <input type='hidden' value='" + commentNum + "'>"
								+ "            </div>"
								+ "        </div>"
								+ "    </div>"
								+ "</div>";
						if (rdata.listCount > 0) {
							output += "<ul>";
							$(rdata.board_reply_list).each(function() {
								
								output += "<li>"
										+ "    <div>"
										+ "        <div class='reply_title'>"
										+ "            <div>";
										
								if (this.login_type == "normal") {
									output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + this.profile_img + "'>";
								} else if (this.login_type != "normal" && this.profile_img != "undefined") {
									output += "<img src='" + this.profile_img + "'>";
								} else if (this.profile_img == "undefined") {
									output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
								}
										
								output += "                <span>" + this.name + "</span>";
								
								if ($("#board_writer").val() == this.member_id) {
									output += "            <span class='writer_span'>작성자</span>";
								}
								
								output += "                <span class='reply_date'>" + this.reply_date + "</span>"
										+ "            </div>";
								
								if (this.member_id == "${user_info.id}") {
									output += "            <a class='reply_delete_btn'>삭제</a>";
									
								}
								
								output += "        </div>"  //#reply_title end
										+ "        <div class='reply_content'>"
										+ "            <p>" + this.content + "</p>"
										+ "        </div>"  //#reply_content end
										+ "        <div class='reply_btn_list'>"
										+ "            <div class='reply_like'>"
										+ "                <img src='${pageContext.request.contextPath}/resources/image/nhj_heart_" + this.likeOnOff + ".png'>"
										+ "                <span>" + this.reply_like + "</span>"
										+ "            </div>"
										+ "        </div>"  //#reply_btn_list end
										+ "	   </div>"
										+ "    <input type='hidden' value='" + this.num + "' class='reply_num'>"
										+ "</li>";
										
							});
							output += "</ul>";
						}
						
						listWrap.html(output);
					}
				
				});
				
				state = 1;
			} else {
				listWrap.empty();
				state = 0
			}
			
			$(this).find("input.state").val(state);
			
		});
		
		$(document).on("click", ".reply_write_btn", function() {
			list_btn = $(this).parent().parent().parent().parent().parent().prev().find(".reply_list_btn");
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/board/replyInsert",
				data : { "id" : "${user_info.id}",
						 "comment_num" : $(this).next().val(),
						 "content" : $(this).parent().parent().prev().val() },
				success : function() {
					alert("댓글이 등록되었습니다.");
					window.location.reload();
				}
			});
		});
		
		if ($("#board_writer").val() == "${user_info.id}") {
			$("#delete_report_wrap").append("<a href='${pageContext.request.contextPath}/board/delete?num=" + $("#board_num").val() + "'>삭제</a>");
		}
		
		$(document).on("click", ".comment_delete_btn", function() {
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/board/commentDelete",
				data : { "num" : $(this).parent().parent().next().val() },
				success : function() {
					alert("댓글이 삭제되었습니다.");
					window.location.reload();
				}
			});
		});
		
		$(document).on("click", ".reply_delete_btn", function() {
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/board/replyDelete",
				data : { "num" : $(this).parent().parent().next().val() },
				success : function() {
					alert("댓글이 삭제되었습니다.");
					window.location.reload();
				}
			});
		});
		
		$("#board_like").click(function() {
			
			if (!"${user_info}") {
				alert("로그인후 이용해주세요.");
			} else {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/board/like",
					data : { "id" : "${user_info.id}", "num" : $("#board_num").val(), "table_name" : "board" },
					success : function(rdata) {
						$("#board_like").find("img").prop("src", "${pageContext.request.contextPath}/resources/image/nhj_heart_" + rdata.onOff + ".png");
						$("#board_like").find("span").text(rdata.like);
					}
				});
			}
			
		});
		
		$(document).on("click", ".comment_like", function() {
			
			img = $(this).find("img");
			span = $(this).find("span");
			
			if (!"${user_info}") {
				alert("로그인후 이용해주세요.");
			} else {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/board/like",
					data : { "id" : "${user_info.id}", "num" : $(this).parent().parent().next().val(), "table_name" : "board_comment" },
					success : function(rdata) {
						img.prop("src", "${pageContext.request.contextPath}/resources/image/nhj_heart_" + rdata.onOff + ".png");
						span.text(rdata.like);
					}
				});
			}
			
		});
		
		$(document).on("click", ".reply_like", function() {
			
			img = $(this).find("img");
			span = $(this).find("span");
			
			if (!"${user_info}") {
				alert("로그인후 이용해주세요.");
			} else {
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/board/like",
					data : { "id" : "${user_info.id}", "num" : $(this).parent().parent().next().val(), "table_name" : "board_reply" },
					success : function(rdata) {
						img.prop("src", "${pageContext.request.contextPath}/resources/image/nhj_heart_" + rdata.onOff + ".png");
						span.text(rdata.like);
					}
				});
			}
			
		});
		
	});
	
	function getCommentList(data) {
		$.ajax({
			type : "get",
			url : "${pageContext.request.contextPath}/board/commentList",
			data : data,
			dataType : "json",
			success : function(rdata) {
				var output = "";
				
				if (rdata.listCount > 0) {
					$("#comment_list_count").text("[" + rdata.listCount + "]");
					$("span.comment_list_count").text(rdata.listCount);
					$(rdata.board_comment_list).each(function() {
						output += "<li>"
								+ "    <div>"
								+ "        <div class='comment_title'>"
								+ "            <div>";
								
						if (this.login_type == "normal") {
							output += "<img src='${pageContext.request.contextPath}/resources/upload/member_image" + this.profile_img + "'>";
						} else if (this.login_type != "normal" && this.profile_img != "undefined") {
							output += "<img src='" + this.profile_img + "'>";
						} else if (this.profile_img == "undefined") {
							output += "<img src='${pageContext.request.contextPath}/resources/image/nhj_profile.png'>";
						}
								
						output += "                <span>" + this.name + "</span>";
						
						if ($("#board_writer").val() == this.member_id) {
							output += "            <span class='writer_span'>작성자</span>";
						}
						
						output += "                <span class='comment_date'>" + this.comment_date + "</span>"
								+ "            </div>";
						
						if (this.member_id == "${user_info.id}") {
							output += "            <a class='comment_delete_btn'>삭제</a>";
							
						}
						
						output += "        </div>"  //#comment_title end
								+ "        <div class='comment_content'>"
								+ "            <p>" + this.content + "</p>"
								+ "        </div>"  //#comment_content end
								+ "        <div class='comment_btn_list'>"
								+ "            <div class='comment_like'>"
								+ "                <img src='${pageContext.request.contextPath}/resources/image/nhj_heart_" + this.likeOnOff + ".png'>"
								+ "                <span>" + this.comment_like + "</span>"
								+ "            </div>"
								+ "            <div class='reply_list_btn'>"
								+ "                <img src='${pageContext.request.contextPath}/resources/image/nhj_msg.png'>"
								+ "                <span>" + this.replyListCount + "</span>"
								+ "                <input type='hidden' value='" + this.num + "'>"
								+ "                <input type='hidden' value='0' class='state'>"
								+ "            </div>"
								+ "        </div>"  //#comment_btn_list end
								+ "        <div class='board_reply_wrap'>"
								+ "        </div>"
								+ "	   </div>"
								+ "    <input type='hidden' value='" + this.num + "' class='comment_num'>"
								+ "</li>";
								
					});
					
				}
				
				$("#comment_list ul").append(output);
				
				if (rdata.listCount > currentCommentCount) {
					output = "    <a id='comment_list_more'>더보기</a>";
						   
					$("#comment_list ul").next().html(output);
				} else {
					$("#comment_list ul").next().empty();
				}
				
				currentCommentCount += 5;
				currentPage += 1;
			}
		
		});
		
	}

</script>
</head>
<body>
<div id="wrap">

	<jsp:include page = "/WEB-INF/views/main/header.jsp" />

	<div id="content_wrap">
		<div id="content_title"><span>자유 게시판</span></div>
		
		<div id="board_view_wrap">
			
			<div>
			
				<div id="board_view_title">
					<span>${board.subject}</span>
					<span id="comment_list_count"></span>
				</div>
				
				<div>
					<div>
					
						<div id="board_view_name">
							<c:if test="${board.login_type == 'normal'}">
								<img src="${pageContext.request.contextPath}/resources/upload/member_image${board.profile_img}">
							</c:if>
							<c:if test="${board.login_type != 'normal' && board.profile_img != 'undefined'}">
								<img src="${board.profile_img}">
							</c:if>
							<c:if test="${board.profile_img == 'undefined'}">
								<img src="${pageContext.request.contextPath}/resources/image/nhj_profile.png">
							</c:if>
							<span>${board.name}</span>
						</div>
						
						<div id="board_view_date">
							<span>${board.board_date}</span>
						</div>
						
						<div>
							<img src="${pageContext.request.contextPath}/resources/image/nhj_eye.png">
							<span>${board.readcount}</span>
						</div>
						
					</div>
					
					<c:set var="id">${user_info.id}</c:set>
					<c:if test="${board.member_id == id}">
						<a href="${pageContext.request.contextPath}/board/delete?num=${board.num}">삭제</a>
					</c:if>
					
				</div>
				
			</div>
			
			<div id="board_view_content">
				<div>
					<p>${board.content}</p>
				</div>
				<div>
					<div id="board_like">
						<c:if test="${existLike == 1}">
							<img src="${pageContext.request.contextPath}/resources/image/nhj_heart_on.png">
						</c:if>
						<c:if test="${existLike == 0}">
							<img src="${pageContext.request.contextPath}/resources/image/nhj_heart_off.png">
						</c:if>
						
						<span>${board.board_like}</span>
					</div>
				</div>
			</div>
			
			<div id="comment_wrap">
				<div id="comment_title">
				
					<div>
						<span>댓글</span>
						<span class="comment_list_count"></span>
					</div>
					
					<div id="order_by_wrap">
						<div id="order_by">
							<span>최신순</span>
							<span></span>
						</div>
					
						<div id="order_by_list">
							<ul>
								<li class="sort">
									<input type="hidden" value="comment_date desc">
									<a>최신순</a>
								</li>
								<li class="sort">
									<input type="hidden" value="comment_date asc">
									<a>등록순</a>
								</li>
								<li class="sort">
									<input type="hidden" value="comment_like desc">
									<a>추천순</a>
								</li>
							</ul>
						</div>
					
					</div> <!-- #order_by_wrap end -->
					
				</div>
				<div id="comment_list">
					<ul>
					
					</ul>
					<div></div>
				</div>
				<div id="comment_write">
					<div>
						<textarea class="autosize" placeholder="댓글을 입력해 주세요."></textarea>
						<div>
							<div>
								<span>0/1000</span>
							</div>
							<div>
								<input type="button" value="등록" id="comment_write_btn">
							</div>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" value="${board.member_id}" id="board_writer">
			<input type="hidden" value="${board.num}" id="board_num">
		</div>
	</div>

	<jsp:include page = "/WEB-INF/views/main/footer.jsp" />
	
</div>
</body>
</html>