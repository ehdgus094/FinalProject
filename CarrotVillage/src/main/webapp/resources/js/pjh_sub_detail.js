$(document).ready(
		function() {

			if($("#item_select").val()=="----"){
				$("#addm").disabled='disabled'
			}
			$("#order").click(function() {
				if($("#idcheck").val()==""){
					alert("로그인후에 주문버튼을 눌러주세요")
					return false;
					}
				if($("#poom").val()==""){
					alert("항목을 추가후 주문하기버튼을 눌러주세요")
					return false;
			}
				
				
				

			});

		

			$("#plus").click(
					function() {

						var fi = parseInt($("#pri_input").val());
						if ($("#item_select").val() == "----") {
							alert("품목을 먼저 선택하주세요")
						} else {
							if ($("#mount").val() > 9) {
								alert("최대수량은 9개까지 입니다.")
								$("#mount")
										.val(parseInt($("#mount").val()) - 1);
								$("#pri_input").val(
										parseInt($("#pri_input").val())
												- parseInt($("#pri_input2")
														.val()));

							} else {
								$("#mount")
										.val(parseInt($("#mount").val()) + 1);
								$("#pri_input").val(
										parseInt($("#pri_input").val())
												+ parseInt($("#pri_input2")
														.val()));
							}

						}
					})

			$("#minus").click(
					function() {
						if ($("#item_select").val() == "----") {
							alert("품목을 먼저 선택하주세요")
						} else {
							if ($("#mount").val() > 1) {
								$("#mount")
										.val(parseInt($("#mount").val()) - 1);
								$("#pri_input").val(
										parseInt($("#pri_input").val())
												- parseInt($("#pri_input2")
														.val()));
							}

						}

					})

			$("#addm").click(
					function() {
						$(".order_min11").css("display" ,"block");
						var poom = $("#item_select").val();
						var su = $("#mount").val();
						var ka = $("#pri_input").val();
						
						output = "<td><input type='text' id='poom' name ='poom' value='"+ poom +"'></td>"
						output += "<td><input type='text'  name ='su' value='"+ su +"'>개</td>"
						output += "<td><input type='text'  name ='ka' value='"+ ka +"'>원</td>"
						$("#trr").next().append(output)
						$("#addm").attr("style" ,"display:none")
						$("#addm1").attr("style" ,"display:inline")
						event.preventDefault(); 

					})
					
					$("#addm1").click(
					function() {
						$(".order_min11").css("display" ,"block");
						var poom = $("#item_select").val();
						var su = $("#mount").val();
						var ka = $("#pri_input").val();
						
						output = "<td><input type='text' id='poom' name ='poom1' value='"+ poom +"'></td>"
						output += "<td><input type='text'  name ='su1' value='"+ su +"'>개</td>"
						output += "<td><input type='text'  name ='ka1' value='"+ ka +"'>원</td>"
						$("#order_min > tbody > tr:nth-child(3)").next().append(output)
						$("#addm1").attr("style" ,"display:none")
						$("#addm2").attr("style" ,"display:inline")
						event.preventDefault(); 

					})
					$("#addm2").click(
					function() {
						$(".order_min11").css("display" ,"block");
						var poom = $("#item_select").val();
						var su = $("#mount").val();
						var ka = $("#pri_input").val();
						
						output = "<td><input type='text' id='poom' name ='poom2' value='"+ poom +"'></td>"
						output += "<td><input type='text'  name ='su2' value='"+ su +"'>개</td>"
						output += "<td><input type='text'  name ='ka2' value='"+ ka +"'>원</td>"
						$("#trr").next().append(output)
						$("#addm2").attr("style" ,"display:none")
						$("#addm3").attr("style" ,"display:inline")
						event.preventDefault(); 

					})
					$("#addm3").click(
					function() {
						$(".order_min11").css("display" ,"block");
						var poom = $("#item_select").val();
						var su = $("#mount").val();
						var ka = $("#pri_input").val();
						
						output = "<td><input type='text' id='poom' name ='poom3' value='"+ poom +"'></td>"
						output += "<td><input type='text'  name ='su3' value='"+ su +"'>개</td>"
						output += "<td><input type='text'  name ='ka3' value='"+ ka +"'>원</td>"
						$("#trr").next().append(output)
						$("#addm3").attr("style" ,"display:none")
						
						event.preventDefault(); 

					})

			$("#item_select").change(function() {
				$("#mount").val(1)
			})

		})

function catechange() {

	var output = "";
	var main = $("#item_select option:selected").val();

	var idx = $("#item_select option").index($("#item_select option:selected"));

	$.ajax({

		url : "/myhome/sub/gagy",
		type : "post",
		cache : false,

		data : {
			"num" : $("#numq").val()

		},
		success : function(data) {

			if (idx == 1) {
				output = data.result[0].item_price1

			}
			if (idx == 2) {
				output = data.result[0].item_price2

			}
			if (idx == 3) {
				output = data.result[0].item_price3

			}
			if (idx == 4) {
				output = data.result[0].item_price4

			}
			if (idx == 5) {
				output = data.result[0].item_price5
			}
			if (idx == 6) {
				output = data.result[0].item_price6

			}
			$("#pri_input").val(output);
			$("#pri_input2").val(output);

		},
		error : function() {
			// 에러 처리
		}
	})

}