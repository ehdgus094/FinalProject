<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#foot_wrap {
	height: 150px;
	background: #f3f3f3;
	box-shadow: 0 -4px 10px 0px rgb(0 0 0 / 15%);
	width:100%;
}

#foot_wrap > div > div:nth-child(1) {
	font-size: 25px;
	padding: 57px 0;
}

#foot_wrap > div > div:nth-child(2) {
	font-size: 12px;
	padding: 25.5px;
	margin-left: 50px;
}

#foot_wrap > div > div:nth-child(1) span {
	color: orange;
}

#foot_wrap p {
	font-weight: 100;
}
#foot_wrap > div {
	display:flex;
	flex-direction:row;
	width:1200px;
	margin:0 auto;
}
</style>

<div id="foot_wrap">
	<div>
		<div>
			<span>당근빌리지</span>
		</div>
		<div>
			<p>사업자등록번호 : 123-45-67891&nbsp;&nbsp;&nbsp;&nbsp;통신판매업신고번호 :
				제2021-서울-0123호</p>
			<p>대표이사 : 홍길동&nbsp;&nbsp;&nbsp;&nbsp;주소 : 서울시 종로구 율곡로10길 105</p>
			<p>ⓒ Carrot Village Corp. All Rights Reserved.</p>
		</div>
	</div>
</div>