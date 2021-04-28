<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



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
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<style>
.m_su {
	text-align: center;
	font-size: 1.5em
}

.order_detail {
	display: flex;
}

.order_de {
	float: left;
	text-align: center;
	padding-left: 100px;
	padding-top: 10px;
}

.order_de>table {
	border-collapse: separate;
	border-spacing: 0 10px;
}

}
#non1 {
	width: 600px
}

#picinfo {
	width: 300px;
	height: 300px;
	margin-top: 20px;
}

#p_su {
	text-align: center;
	font-size: 1.5em
}

.del_info {
	text-align: center;
	font-size: 1.5em
}

#del_ta {
	width: 1200px
}

#del_ta>tbody>tr>td>input[type=text] {
	width: 500px
}

.order-info {
	width: 800px
}

caption {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
}

.form-button {
	text-align: center;
	margin: 40px 0px 40px 0px
}
</style>
<body>
	<form action="orderPro" method="post">
		<div id="wrap">

			<jsp:include page="/WEB-INF/views/main/header.jsp" />

			<div id="content_wrap">
				<div id="int_wrap">Carrot Mart</div>
				<hr>
				<div class="m_su">주문하기</div>
				<hr>
				<div class="order_detail">
					<img
						src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].board_thumbnail}" id="picinfo">
					
					<div class="order_de">
						<table class="order-info">
							<tr>
								<th>주문번호</th>
								<td>00001</td>


								<th>주문날짜</th>
								<td>날짜</td>
							</tr>
							<tr>
								<th>주문내역</th>

								<td id="non1"></td>
								<th></th>
								<th>주문가격</th>

							</tr>
							<tr>
								<td>${poom}</td>
								<td id="non1"></td>
								<th></th>
								<td>${ka}</td>

							</tr>
							


							<caption>
								총 가격 : <input type="text" value="${ka}" name="totalPrice">원
							</caption>
						</table>
					</div>


				</div>
				<hr>
				<div class="user_detail">
					<div class="del_info">배송정보</div>
					<hr>
					<table id="del_ta">
						<tr>
							<td>이름 :</td>
							<td><input type="text" name="buyer_name" value="${user_info.name}" required></td>
						</tr>
						<tr>
							<td>연락처:</td>
							<td><input type="text" name="buyer_tel"  value="${user_info.phone_num}"required></td>
						</tr>
						<tr>
							<td>주소 :</td>
							<td><input type="text" name="buyer_addr" value="${user_info.address}" required></td>
						</tr>
						
						<tr>

							<td>이메일:</td>
							<td><input type="text" name="buyer_email" required value="${user_info.email}"></td>
						</tr>
						<tr>
							<td>요청사항:</td>
							<td><input type="text" name="request" required></td>
						</tr>


					</table>
				</div>
				<hr>
				<div class="payment">
					<p id="p_su">결제</p>
					<hr>
					<input name="order_method" id="order_method" type="checkbox"
						value="카카오페이"> <img
						src='${pageContext.request.contextPath}/resources/image/pjh_kkpay.png'>

				</div>
				<hr>

				<div class="form-button">
					<button type="submit" class="btn btn-warning" id="Modify">결제하기</button>
					<button type="button" class="btn btn-danger" onclick="#'"
						id="Delete">취소</button>

				</div>







			</div>

			<jsp:include page="/WEB-INF/views/main/footer.jsp" />

		</div>
	</form>
</body>
</html>