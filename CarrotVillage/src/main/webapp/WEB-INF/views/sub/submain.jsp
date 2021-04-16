<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>당 근 빌 리 지</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/css/pjh_submain.css"
	rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/pjh_submain.js"></script>
</head>
<style>
#arrow_area {
	display: flex;
	justify-content: space-between;
	width: 1200px;
	position: relative;
	top: 28px;
	z-index: 10
}

#arrow_area>img {
	width: 40px;
}

#arrow_area>img:hover {
	opacity: 1;
	cursor: pointer
}

#image_area::-webkit-scrollbar {
	display: none
}
</style>



<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">
			<input type="hidden" id="m_addr" name="m_addr" value="${address}">
			<div id="int_wrap">Carrot Mart</div>
			<div>
				<button class="btn btn-info"
					onclick="document.location.href='/myhome/sub/subwrite'">Write</button>
				<button class="btn btn-warning" id="addmartb"
					onclick="document.location.href='/myhome/sub/addmart'">Mart+</button>
			</div>

			<hr>
			<div id="mart_list">
				<div id=arrow_area>
					<img
						src="${pageContext.request.contextPath}/resources/image/kdh_arrow_left.png">
					<img
						src="${pageContext.request.contextPath}/resources/image/kdh_arrow_right.png">
				</div>
				<ul class="mart_ul">

				</ul>
			</div>
			<hr>
			<div class="local_mart">
				<div id="pmart"> 
					<c:if test="${not empty result}">
					${result[0].martname}
				</c:if>
					<c:if test="${empty result}">
					&emsp;시장목록을 선택해주세요
				</c:if>

				</div>
				<c:if test="${not empty result}">

					<div id="delinfo">
						<table>


							<tr>
								<th>배달지역 :</th>
								<td id=del_loc>${result[0].mart_delloc}</td>

							</tr>
							<tr>
								<th>배달시간 :</th>
								<td id="del_time">${result[0].mart_deltime}</td>
							</tr>
							<tr>
								<th>배달비용 :</th>
								<td id="del_pr">${result[0].mart_delpri}</td>
							</tr>

						</table>

					</div>
				</c:if>
			</div>
			<hr>
			<c:if test="${not empty de}">
			<div class="mar_content">
				<div class="range">
					<label for="row"> <a href="#">최신순</a> <a href="#">평점순</a> <a
						href="#">인기순</a>
					</label>
				</div>
				<ul>
					<li><a href="/myhome/sub/detail?num=${de[0].item_num}" id="thumbnail"><img
							src="<%=request.getContextPath()%>/resources/upload/sub_image/${de[0].board_thumbnail}">
							${de[0].mart_subject}</a></li>
					
				</ul>
				<ul>
					
				</ul>
				<ul>
					
				</ul>



			</div>

</c:if>










		</div>

		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>