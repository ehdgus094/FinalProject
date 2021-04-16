$(document).ready(function(){

var loc = $("#m_addr").val();
var locs = loc.split(" ");
var si = locs[0]
var gu = locs[1]

	if('${result}' == 'addmartsuccess'){
		alert("시장목록추가성공.")
	}
	
	$.ajax({
		
		url		: "/myhome/sub/martlist",
		type	: "post",
		cache : false,
		dataType:"json",
		data	:{
			"martloc":"서울",
			 "si":si,
	         "gu":gu
		},
		success	: function(data) {
			
			var c = data.c;
	
			if(c>0){
				var startnum=data.result[0].num;
				
				
					var output ="";
			for(var i = 0; i<c ; i++){
						output +="<li><a class='marta' href='submarket?num="+data.result[i].num+"'>"+data.result[i].martname+"</a></li>"
		}
				
			
					$(".mart_ul").html(output)
				


				
			}
			else{
				$(".local_mart").html("현재 위치에서는 서비스를 준비중입니다. 불편을 드려 죄송합니다.")
								.css("style='justify-content:center'")
								$("#content_wrap > div.mar_content").remove();
			}
					
		},
		error	: function() {
			// 에러 처리
		}
	})


	
	
	
	
	

	
})