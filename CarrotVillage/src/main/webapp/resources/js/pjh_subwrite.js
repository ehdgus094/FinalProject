$(document).ready(function() {
	$('form').submit(function(){
	if($("#main_categoty option:selected").val()=="----"){
		alert("메인카테고리를 설정해주세요")
		return false;
	}
	if($("#sub_category option:selected").val()=="----"){
		alert("서브카테고리를 설정해주세요")
		return false;
	}
	if($("mart_subject").val()==""){
		alert("제목을 입력해주세요")
		$("mart_subject").val().focus();
		return false;
	}
	
	
	})
	

	
	
		
	
	
	

	

})

function catechange(){
	var main = $("#main_categoty option:selected").val();
	alert(main)
	if(main=="구독서비스"){
		 var output ="<option>----</option><option>반찬</option><option>유제품</option>";
			$("#sub_category").html(output);
	}
	if(main=="우리동네장보기"){
		 var output ="<option>----</option><option>가락시장</option><option>경창시장</option>";
			$("#sub_category").html(output);
	}

}



