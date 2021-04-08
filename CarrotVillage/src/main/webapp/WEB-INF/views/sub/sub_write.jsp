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
	href="${pageContext.request.contextPath}/resources/css/submain.css"
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

</head>
<style>
.write_subj {
	font-size: 2em;
	text-align: center;
	width: 1200px;
	padding: 25px 0px 25px 0px;
}

.form-group {
	
}

p>label:nth-child(3) {
	margin-left: 20px;
}

#board_subject {
	width: 1000px;
}

.section_view {
	display: flex;
}

.section_view  img {
	margin: 30px;
}

#section_view>div {
	margin: 15px 0px 0px 125px;
	font-size: 1.3em;
}

input#mart_del {
	margin: 0px 5px 0px 15px
}

.mart_item {
	text-align: center;
}

#item_price {
	margin-left: 20px;
}

.section_info {
	text-align: center;
}

caption {
	caption-side: top;
	text-align: center;
	font-size: 1.4em;
}
</style>
<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">

			<div id="int_wrap">Carrot Mart</div>
			<hr>
			<div class="write_wrap">
				<form action="SubAddAction" method="post"
					enctype="multipart/form-data" name=board-form>
					<div class="write_subj">판매 글 작성</div>
					<hr>
					<div class="form-group">
						<p>
							<label for="mart_main"> Main-Category :&nbsp; </label> <select
								name="main_category">
								<option>----</option>
								<option>우리동네장보기</option>
								<option>구독서비스</option>
							</select> <label for="board_title"> Sub-Category :&nbsp; </label> <select
								name="sub_category">
								<option>----</option>
								<option>메인카테고리설정을해주세요</option>
							</select>
						</p>
						<label for="board_subject">&nbsp; 제 &nbsp;&nbsp;목&nbsp;
							:&emsp; </label><input type="text" name="board_subject"
							placeholder="제목을 입력하세요" id="board_subject" maxlength="30"
							class="form-input">

					</div>
					<hr>
					<div class="section_view" id="section_view">
						<label> <span id="showImage"> <c:if
									test='${empty boardbean.board_thumbnail}'>
									<c:set var='src'
										value='${pageContext.request.contextPath}/resources/image/pjh_sum.JPG' />
								</c:if> <c:if test='${!empty boardbean.board_thumbnail}}'>
									<c:set var='src'
										value='${"boardupload/"}${boardbean.board_thumbnail}}' />
								</c:if> <img src="${src}" width="500px" height="500px" alt="profile">
						</span> <input type="file" name="board_thumbnail" accept="image/*"
							style="display: none;">

						</label>




						<div class="form-info">
							<label for="board_name"><input name="board_name"
								id="board_name" type="hidden" value="${id}"></label>





							<div class="form-group">

								<label for="mart_name">상&emsp;호&emsp;명&ensp; :&emsp; </label> <input
									name="mart_name" id="mart_name" type="text" maxlength="200"
									class="form-input" placeholder="Enter MartName">&nbsp;

							</div>

							<hr>

							<div class="form-group">
								<label for="mart_addr">주&emsp; &nbsp;&emsp;소
									&emsp;:&emsp; </label> <input name="mart_addr" id="mart_addr"
									type="text" maxlength="200" class="form-input"
									placeholder="Enter Address">&nbsp;



							</div>
							<hr>


							<div class="form-group">

								<label for="mart_ori">원&emsp;산&emsp;지&ensp; :&emsp; </label> <input
									name="mart_ori" id="mart_ori" type="text" maxlength="100"
									class="form-input" placeholder="Enter origin">

							</div>
							<hr>





							<div class="form-group">
								<div class="form-delivery" id="form-delivery">
									<label for="mart_del">배 송 방 법&emsp; :&emsp;</label> <input
										name="mart_del" id="mart_del" type="checkbox" value="택배">택배
									<input name="mart_del" id="mart_del" type="checkbox" value="포장">포장<input
										name="mart_del" id="mart_del" type="checkbox" value="퀵서비스">당근배송
									<div class="form-group">


										<label for="board_storage">배 송 비 용 &emsp;:&emsp; <input
											type="text" name="board_deliverycost" id="board_deliverycost"
											placeholder="Enter 배송비용">원

										</label>
									</div>



								</div>


							</div>
							<hr>
							<div class="mart_item">

								<table>
									<tr>
										<td>상품이름</td>
										<td>가격</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name" id="item_name"
											style="width: 200px"></td>
										<td><input type="text" name="item_price" id="item_price"
											style="width: 200px">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name" id="item_name"
											style="width: 200px"></td>
										<td><input type="text" name="item_price" id="item_price"
											style="width: 200px">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name" id="item_name"
											style="width: 200px"></td>
										<td><input type="text" name="item_price" id="item_price"
											style="width: 200px">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name" id="item_name"
											style="width: 200px"></td>
										<td><input type="text" name="item_price" id="item_price"
											style="width: 200px">원</td>
									</tr>
									<tr>
										<td><img
								src="${pageContext.request.contextPath}/resources/image/pjh_add.JPG"
								width="20px" id="item_add" style="margin:0px"></td>
										<td>최대 6개까지 등록가능</td>
									</tr>


								</table>

							</div>

							<hr>
							+ 버튼을 눌러 대표사진을 업로드해주세요.
						</div>
					</div>
					<hr>
					<div class="section_content">
						<div class="section_info">


							<span id="board_thumbnailname" style="display: none;"></span>

							<table class="table table-striped">

								<caption>상품 상세정보</caption>
								<tr>
									<th>상 호 명</th>
									<td><input type="text" name="mart_name"
										id="mart_name" placeholder="Enter mart_name"></td>
								</tr>
								<tr>
									<th>생 산 자</th>
									<td><input type="text" name="mart_prod"
										id="mart_prod" placeholder="Enter producer"></td>
								</tr>
								<tr>
									<th>상 품 명</th>
									<td><input type="text" name="itme_name"
										id="item_name" placeholder="Enter Item_Name"></td>
								</tr>
								<tr>
									<th>원 산  지</th>
									<td><input type="text" name="item_origin"
										id="item_origin" placeholder="Enter origin"></td>
								</tr>
								<tr>
									<th>유 통 기 간</th>
									<td><input type="text" name="item_exp"
										id="item_exp" placeholder="Enter exp"></td>
								</tr>
								<tr>

									<th>보 관 방 법</th>
									<td id="item_storage"><input name="item_storage"
										id="item_storage" type="checkbox" value="상온">상온<input
										name="item_storage" id="item_storage" type="checkbox"
										value="냉장">냉장<input name="item_storage"
										id="item_storage" type="checkbox" value="냉동">냉동</td>

								</tr>

							</table>
						</div>
						<hr>
						<h2>Content</h2>
						<div class="form-group">
							<textarea class="form-control" id="board_content"
								name="board_content"></textarea>


						</div>

						<div class="form-file">
							<label for="upfile1" id="picinfo"> <input type="file"
								id="upfile1" name="board_file1" accept="image/*"> <span
								id="filevalue1" style="display: none;"></span> <input
								type="file" id="upfile2" name="board_file2" accept="image/*">
								<span id="filevalue2" style="display: none;"></span><br>

							</label> <img
								src="${pageContext.request.contextPath}/resources/image/pjh_add.JPG"
								width="20px" id="file_add" style="">
						</div>


						<div class="form-button">

							<button type=submit class="btn btn-primary">등록</button>

							<button type=reset class="btn btn-danger">리셋</button>

							<input type="button" class="btn btn-warning" value="목록"
								onclick="location.href='BoardList.bo'">
						</div>

					</div>

				</form>
			</div>

		</div>

		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>