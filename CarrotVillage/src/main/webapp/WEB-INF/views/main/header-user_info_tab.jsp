<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	#user_info_tab {
	width: 340px;
    height: 150px;
    background:#f5f5f5;
    float: right;
    z-index:99;
    margin-top:22px;
    display:none;
    box-shadow: 1px 2px 7px -3px #656565;
    position:absolute;
}
#user_info_tab.show {
	display:block;
}
#user_profile_img {
	width: 75px;
    height: 75px;
    border-radius: 38px;
    margin: 20px auto;
}
#user_title {
	width: 100%;margin: 15px 0px 0px 0;height: 25px;
}
#user_profile_img img {
	width:75px;
	height:75px;
}
#user_info_tab > div:nth-child(2) {
	display: flex; 
	flex-direction:row;
	width:100%;
	border-top: solid #d6d6d6 1px;
	background:#ececec;
}
#user_info_tab > div:nth-child(2) > a {
	display: block;
	height: 35px;
	text-align:center;
	padding-top:9px;
}
#user_info_tab > div:nth-child(2) > a:hover {
	background:#d4d4d4;
	box-shadow: 0px 0px 3px 1px silver;
	text-decoration:none;
}
</style>

<div id="user_info_tab">

	<div style="display: flex; flex-direction: row;">
	
		<div style="width: 35%; height: 100%;">
		
			<div id="user_profile_img">
				<c:if test="${user_info.login_type == 'normal'}">
					<img src="${pageContext.request.contextPath}/resources/upload/member_image${user_info.profile_img}">
				</c:if>
				<c:if test="${user_info.login_type != 'normal' && user_info.profile_img != 'undefined'}">
					<img src="${user_info.profile_img}">
				</c:if>
				<c:if test="${user_info.profile_img == 'undefined'}">
					<img src="${pageContext.request.contextPath}/resources/image/nhj_profile.png">
				</c:if>
			</div>

		</div>

		<div style="width: 65%; height: 100%; display: flex; flex-direction: column; padding-left: 10px;">

			<div id="user_title">
				<b style="color:orange;letter-spacing: 1px;">${user_info.name}</b>&nbsp;님
				<a onclick="logout()" style="cursor: pointer; float: right; margin-right: 20px;">로그아웃</a>
			</div>

			<div>${user_info.email}</div>
			<div style="margin: 10px 0 0 0;">0 point</div>

		</div>
		
	</div>


	<div>
		<a href="${pageContext.request.contextPath}/main/myPage"
		   style="width:35%;border-right: solid #d6d6d6 1px;">내 정보</a>
		<a href="${pageContext.request.contextPath}/main/sellerPage" style="width: 65%;">판매자 메뉴</a>
	</div>

</div>