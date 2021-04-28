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
<link
	href="${pageContext.request.contextPath}/resources/css/pjh_sub_detail.css"
	rel="stylesheet" type="text/css">

<script
	src="${pageContext.request.contextPath}/resources/js/pjh_sub_detail.js"></script>
</head>
<style>
#item_select {
	width: 400px;
}

#order_min {
	margin: 20px;
	text-align: center;
	font-size: 1em;
}

select {
	text-align-last: center;
	text-align: center;
	-ms-text-align-last: center;
	-moz-text-align-last: center;
}

#order_min>tr>td:nth-child(2) {
	width: 300px
}

#mount {
	width: 100px;
	text-align: center;
	margin: 0px 20px 0px 20px
}

#pri_input {
	border: 0px;
	text-align: center;
}

#orderlist1 {
	width: 30px;
	border: none;
}

#order_min>tbody>tr>td:nth-child(1)>input[type=text] {
	width: 200px;
	text-align: center;
	border: none
}

#order_min>tbody>tr>td:nth-child(2)>input[type=text] {
	width: 50px;
	text-align: center;
	border: none
}

#order_min>tbody>tr>td:nth-child(3)>input[type=text] {
	width: 100px;
	text-align: center;
	border: none
}
</style>
<script>
	
</script>

<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">

			<div id="int_wrap">Carrot Mart</div>
			<hr>


			<div class="item_info">
				<p id="thumbnail">
					<img
						src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].board_thumbnail}">

				</p>
				<div class="item_detail">
					<div class="main_subj">${result[0].mart_subject}</div>
					<input type="hidden" id="numq" name="numq"
						value="${result[0].item_num}">
					<table class="table">
						<tr>
							<th>주 소 :</th>
							<td>${result[0].mart_addr}</td>
						</tr>
						<tr>
							<th>원 산 지 :</th>
							<td>${result[0].mart_ori}</td>
						</tr>
						<tr>
							<th>배 송 정 보 :</th>
							<td>${result[0].mart_del}</td>
						</tr>
						<tr>
							<th>품 목 :</th>
							<td><select id="item_select" onchange="catechange()">
									<option>----</option>
									<option>${result[0].item_name1}</option>
									<c:if test="${not empty result[0].item_name2}">
										<option>${result[0].item_name2}</option>
										<option>${result[0].item_name3}</option>
										<option>${result[0].item_name4}</option>
										<option>${result[0].item_name5}</option>
										<option>${result[0].item_name6}</option>
									</c:if>
							</select></td>
						</tr>
						<tr>
							<th>수 량 :</th>
							<td><input type="button" id="minus" value="-"><input
								type="text" value="1" readOnly id="mount"><input
								type="button" id="plus" value="+"></td>

						</tr>

						<tr>
							<th>가 격 :</th>
							<td id="priceca"><input type="text" id="pri_input" readOnly>
								원 <input type="hidden" id="pri_input2" readOnly> <input
								type="button" value="추가" id="addm"><input type="button"
								value="추가" id="addm1" style="display: none"> <input
								type="button" value="추가" id="addm2" style="display: none">
								<input type="button" value="추가" id="addm3" style="display: none">
								<input type="button" value="추가" id="addm4" style="display: none"></td>


						</tr>

					</table>





					<form action="my-order" method="post">
						<div class="order_min11" style="display: none">
							<table id="order_min">
								<tr>
									<th></th>
									<th>주문목록</th>
									<th></th>
								</tr>
								<tr id="trr">
									<th>품목</th>
									<th>수량</th>
									<th>가격</th>
								</tr>
								<tr>
								</tr>

							</table>

						</div>




						<div class="ord">
							<button type="submit" class="btn btn-primary" id="order">주문하기</button>
							<button type="button" class="btn btn-warning" id="wishlist"
								value="장바구니">장바구니</button>
						</div>
						<input type="hidden" name="num" value="${result[0].item_num}">
					</form>
				</div>

				<div class="rev_view">리뷰미리보기 들어갈 영역</div>



			</div>






			<div class="detail_menu">
				<ul>
					<li><a href="#">상세정보</a></li>
					<li><a href="#">리뷰</a></li>
					<li><a href="#">Q&A</a></li>
					<li><a href="#">반품/교환정보</a></li>
				</ul>

			</div>
			<div class="item_content">
				<div class="detail_info">
					<table class="table table-striped">

						<caption>상품 상세정보</caption>
						<tr>
							<th>상 호 명</th>
							<td>${result[0].mart_subject}</td>
						</tr>
						<tr>
							<th>수 량</th>
							<td>품목별 상이</td>
						</tr>
						<tr>
							<th>대 표</th>
							<td>${result[0].mart_prod}</td>
						</tr>
						<tr>
							<th>유 통 기 한</th>
							<td>${result[0].item_exp}</td>
						</tr>
						<tr>
							<th>원 산 지</th>
							<td>${result[0].item_origin}</td>
						</tr>
						<tr>

							<th>보 관 방 법</th>
							<td>${result[0].item_storage}</td>

						</tr>

					</table>
					<input type="hidden" value="${user_info.id}" id="idcheck">
				</div>
				<hr>
				<img
					src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile1}">
				<img
					src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile2}">
				<img
					src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile3}">
				<img
					src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile4}">
				${result[0].board_content}
			</div>
			<hr>
			<c:if test="${user_info.id=='admin'}">
				<div class="form-button">
					<button type="button" class="btn btn-warning"
						onclick="location.href='submod?num=${result[0].item_num}'"
						id="Modify">Modify</button>
					<button type="button" class="btn btn-danger"
						onclick="location.href='subdel?num=${result[0].item_num}'"
						id="Delete">Delete</button>
				</div>
			</c:if>
		</div>

		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>

</html>