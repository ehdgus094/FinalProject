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
<link
	href="${pageContext.request.contextPath}/resources/css/pjh_sub_detail.css"
	rel="stylesheet" type="text/css">
</head>

<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">

			<div id="int_wrap">Carrot Mart</div>
			<hr>
		<div class="user_loc">
			위치:
		</div>
			<hr>
			<div class="item_info">
				<p id="thumbnail">
					<img
						src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].board_thumbnail}">
					<!-- 썸내일 여러장올리고 다음버튼으로 볼수있도록 -->
				</p>
				<div class="item_detail">
					<div class="main_subj">${result[0].mart_subject}</div>
					<table>
						<tr>
							<th>가게주소 :</th>
							<td>${result[0].mart_addr}</td>
						</tr>
						<tr>
							<th>원산지 :</th>
							<td>${result[0].mart_ori}</td>
						</tr>
						<tr>
							<th>배송정보 :</th>
							<td>${result[0].mart_del}</td>
						</tr>
						<tr>
							<th>품목 :</th>
							<td>
							<select id="item_select">
							<option>----</option>
							<option>${result[0].item_name1}</option>
							</select>
							
							</td>
						</tr>
						<tr>
							<th>수량 :</th>
							<td><input type="button" id="plus" value="+">1개<input
								type="button" id="minus" value="-"></td>

						</tr>

						<tr>
							<th>가격 :</th>
							<td>${result[0].item_price1}원</td>
						</tr>
						<tr>
							<td colspan="2"><strong>평점 </strong>
								<p id="res" style="text-align:;"></p> <input type="hidden"
								id="board_writer" value="${boardBean.board_name}"> <input
								type="hidden" id="loginsession" value="${id}"> <input
								type="hidden" value="${boardBean.board_num}">
								<div class="star_result">
									<label for="1">★</label><label for="2">★</label><label for="3">★</label><label
										for="4">★</label> <label for="5">★</label><label for="6"
										style="display: none">★</label>

								</div>
						</tr>
					</table>

					<div class="ord">
						<input type="button" id="order" value="주문하기"> <input
							type="button" id="wishlist" value="장바구니">
					</div>

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
				<div class="notice">공지사항</div>
				<div class="detail_info">
					<table class="table table-borderd">

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
				</div>
				<img src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile1}">
				<img src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile2}">
				<img src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile3}">
				<img src="<%=request.getContextPath()%>/resources/upload/sub_image/${result[0].upfile4}">
				${result[0].board_content}
			</div>



		</div>

		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>