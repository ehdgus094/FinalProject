<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/main/socialLoginProcess",
			data : {"email" : sessionStorage.getItem("email"),
					"name" : sessionStorage.getItem("name"),
					"profile_image" : sessionStorage.getItem("profile_image"),
					"login_type" : "kakao"
				   },
			success : function(rdata) {
				console.log(rdata.email);
				sessionStorage.removeItem("email");
				sessionStorage.removeItem("name");
				sessionStorage.removeItem("profile_image");
				$("#email").val(rdata.email);
				$("form").submit();
			}
		});
	});
</script>
</head>
<body>
	<form action="loginProcess" method="post">
		<input type="hidden" name="email" id="email">
		<input type="hidden" name="login_type" id="login_type" value="kakao">
	</form>
</body>
</html>