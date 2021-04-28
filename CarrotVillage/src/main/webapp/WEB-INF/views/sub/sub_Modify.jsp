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
	href="${pageContext.request.contextPath}/resources/css/pjh_sub_write.css"
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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<style>
.form-button{
text-align:center;
margin:40px 0px 40px 0px
}

</style>
<body>
	<div id="wrap">

		<jsp:include page="/WEB-INF/views/main/header.jsp" />

		<div id="content_wrap">

			<div id="int_wrap">Carrot Mart</div>
			<hr>
			<div class="write_wrap">
				<form action="subAdd" method="post" enctype="multipart/form-data"
					name=board-form>
					<div class="write_subj">판매 글 작성</div>
					<hr>
					<div class="form-one">
						<p>
							<label for="mart_main"> Main-Category :&nbsp; </label> 
							<input name ="main_category"type="text" readOnly value="${result[0].main_category}">
							 <label for="mart_sub"> Sub-Category :&nbsp; </label> <input type="text" value="${result[0].sub_category}"
								name="sub_category" id="sub_category">
							
						</p>
						<label for="mart_subject">&nbsp; 제 &nbsp;&nbsp;목&nbsp;
							:&emsp; </label><input type="text" name="mart_subject"
							value="${result[0].mart_subject}" id="mart_subject" maxlength="30"
							class="form-input" required>

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
								</c:if> <img src="${src}" width="500px" height="500px" alt="profile" id="bfile">
						</span> <input type="file" id = "thumb" name="uploadfile" accept="image/*"
							style="display: none;">

						</label>




						<div class="form-info">
							<label for="board_name"><input name="board_name" 
								id="board_name" type="hidden" value="${id}"></label>





							<div class="form-group">

								<label for="mart_name">상&emsp;호&emsp;명&ensp; :&emsp; </label> <input
									name="mart_name" id="mart_name" type="text" maxlength="200"
									class="form-input" placeholder="Enter MartName" value="${result[0].mart_subject}" required>&nbsp;

							</div>

							<hr>

							<div class="form-group">
								<label for="mart_addr">주&emsp; &nbsp;&emsp;소
									&emsp;:&emsp; <input name="mart_addr" id="mart_addr" value="${result[0].mart_addr}"
									type="text" maxlength="200" class="form-input"
									placeholder="Enter Address" required>&nbsp; <input
									type="button" value="주소검색" id="postcode">
								</label>


							</div>
							<hr>


							<div class="form-group">

								<label for="mart_ori">원&emsp;산&emsp;지&ensp; :&emsp; </label> <input
									name="mart_ori" id="mart_ori" type="text" maxlength="100"
									class="form-input" placeholder="Enter origin" value="${result[0].mart_ori}" required>

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
											type="text" name="mart_deliverycost" id="mart_deliverycost"
											placeholder="Enter 배송비용" required value="${result[0].mart_deliverycost}">원

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
										<td><input type="text" name="item_name1" id="item_name1"
											style="width: 200px" required value="${result[0].item_name1}"></td>
										<td><input type="text" name="item_price1" 
											id="item_price1" style="width: 200px" required value="${result[0].item_price1}">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name2" id="item_name2"value="${result[0].item_name2}"
											style="width: 200px"></td>
										<td><input type="text" name="item_price2"
											id="item_price2" style="width: 200px" value="${result[0].item_price2}">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name3" id="item_name3"value="${result[0].item_name3}"
											style="width: 200px"></td>
										<td><input type="text" name="item_price3"
											id="item_price3" style="width: 200px" value="${result[0].item_price3}">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name4" id="item_name4"value="${result[0].item_name4}"
											style="width: 200px"></td>
										<td><input type="text" name="item_price4"
											id="item_price4" style="width: 200px" value="${result[0].item_price4}">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name4" id="item_name4"value="${result[0].item_name5}"
											style="width: 200px"></td>
										<td><input type="text" name="item_price4"
											id="item_price4" style="width: 200px" value="${result[0].item_price5}">원</td>
									</tr>
									<tr>
										<td><input type="text" name="item_name4" id="item_name4"value="${result[0].item_name6}"
											style="width: 200px"></td>
										<td><input type="text" name="item_price4"
											id="item_price4" style="width: 200px" value="${result[0].item_price6}">원</td>
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



							<table class="table table-striped">

								<caption>상품 상세정보</caption>
								<tr>
									<th>상 호 명</th>
									<td><input type="text" name="mart_name2" id="mart_name2"
										placeholder="Enter mart_name" value="${result[0].mart_name}"readOnly></td>
								</tr>
								<tr>
									<th>생 산 자</th>
									<td><input type="text" name="mart_prod" id="mart_prod"
										placeholder="Enter producer" required value="${result[0].mart_prod}"></td>
								</tr>
								<tr>
									<th>상 품 명</th>
									<td><input type="text" name="item_name" id="item_name"
										placeholder="Enter Item_Name" required value="${result[0].item_name}"></td>
								</tr>
								<tr>
									<th>원 산 지</th>
									<td><input type="text" name="item_origin" id="item_origin" value="${result[0].item_origin}"
										placeholder="상세한 원산지를 작성해주세요" required></td>
								</tr>
								<tr>
									<th>유 통 기 간</th>
									<td><input type="text" name="item_exp" id="item_exp" value="${result[0].item_exp}"
										placeholder="Enter exp" required></td>
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
						<h2 id="content_suj">Content</h2>
						<div class="form-group">
							<textarea class="form-control" id="board_content"
								name="board_content">${result[0].board_content}</textarea>


						</div>

						<div class="form-file">
							<label for="upfile1" id="picinfo"> <input type="file"
								id="upfile1" name="uploadfile1" accept="image/*"> <span
								id="filevalue1" style="display: none;"></span>
						
								
								 
								 <input type="file" id="uploadfile2" name="uploadfile2" accept="image/*">
								<span id="filevalue2" style="display: none;"></span><br>
								
								<input type='file' id='upfile3' name='uploadfile3' accept='image/*'>
								<span id="filevalue3" style="display: none;"></span> 
								
								<input type='file' id='upfile4' name='uploadfile4' accept='image/*'>
								<span id="filevalue4" style="display: none;"></span>
								
							</label>
							 <img
								src="${pageContext.request.contextPath}/resources/image/pjh_add.JPG"
								width="20px" id="file_add" style="">
						</div>

<hr>
						<div class="form-button">

							<button type=submit class="btn btn-primary">수정</button>

							<button type=reset class="btn btn-danger">리셋</button>

							<input type="button" class="btn btn-warning" value="목록"
								onclick="location.href='submarket'">
						</div>

					</div>

				</form>
			</div>

		</div>

		<jsp:include page="/WEB-INF/views/main/footer.jsp" />

	</div>
</body>
</html>