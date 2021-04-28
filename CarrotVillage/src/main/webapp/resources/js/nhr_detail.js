

function getList() {
	
	console.log("review_groups_num확인" +  $('#num').val())
	
	$.ajax({
		type : "post",
		url : "../review/reviewList",
		data : {
			page : 1,
			review_groups_num : $('#num').val(), 
			name : $('#name').val()
			},
		dataType : "json",
		success : function(rdata) {
			$('#count').text(rdata.listcount).css('font-family', 'arial,sans-serif');
			var output = "";
			
			if(rdata.list.length > 0) {
				$('.comment_tab_list').html(output);
				
				output = '';
				$(rdata.list).each(function(){
					var lev = this.review_re_lev;
					var comment_reply = '';
					
					if(lev==1){
						comment_reply = ' CommentItem--reply lev1'; //답댓글 들여쓰기때문에 margin-left주려고 나눠놓음
					}
					output += '<li id="' + this.num + '" class="CommentItem' + comment_reply + '">'
                    + '   <div class="comment_area">'
                    + '    <div class="comment_box">'
                    + '      <div class="comment_nick_box">'
                    + '            <div class="comment_nick_info">'
                    + '               <div class="comment_nickname">' + this.name  + '</div>'
                    + '            </div>' //comment_nick_info                  
                    + '       </div>'  // comment_nick_box
                    + '     </div>'   //comment_box
                    + '  <div class="comment_text_box">'
                    + '    <p class="comment_text_view">'
                    + '     <span class="text_comment">' + this.content + '</span>'
                    + '    </p>'
                    + '   </div>' //comment_text_box
				    +  ' <div class="comment_info_box"> '
				    +  '  <span class="comment_info_date">' + this.regi_date + '</span>';
					if(lev<1){
						/*output += ' <a href="javascript:replyform(' + this.num + ',' + lev + ',' + this.review_re_seq + ','
							   +   this.review_re_ref + ')" class="comment_info_button">답글쓰기</a>'*/
					   output += ' <a href="javascript:void(0);" onclick="replyform(' + this.num + ',' + lev + ',' + this.review_re_seq + ','
					   +   this.review_re_ref + ')"  class="comment_info_button">답글쓰기</a>'
					}
				output += '</div>' //	comment_info_box
				
				if($('#name').val() == this.name) {
					output +=  '<div class="comment_tool">'
					  +   '	<div title="더보기" class="comment_tool_button"> '
					  +   ' 	<div>&#46;&#46;&#46;</div>'
					  +   ' </div>'
					  +   ' <div id="commentItem' + this.num + '" class="LayerMore">'
					  +   ' <ul class="layer_list">'
					  +   '		<li class="layer_item">'
					  +   '        <a href="javascript:updateForm(' + this.num + ')"'
					  +   ' 			class="layer_button">수정</a>&nbsp;&nbsp;'
					  +   '        <a href="javascript:del(' + this.num + ')"'
					  +   ' 			class="layer_button">삭제</a></li></ul>'
					  +  ' 		</div>' 
					  +  ' </div>' //comment_tool
				}	
				console.log("더보기 name = " + $('#name').val())
				console.log("더보기 this.name = " + this.name)
				console.log("더보기 this.num = " + this.num)
				console.log("더보기 review_groups_num = " + $('#num').val())
				
				
					output += '</div>' //commmnt area
							+  '</li>'  //CommentItem
				}) //each
				 $('.comment_list').html(output);
			} //if(rdata.boardlist.length >0 )
		} // success end
	}) // ajax end
} //function getList(state) end

	

//더보기 - 수정 클릭한 경우에 수정 폼을 보여줌


function updateForm(num){
	//선택한 내용을 구함
	var content = $('#' + num).find('.text_comment').text();
	
	var selector = '#' + num + ' .comment_area'
	var obj = $(selector).hide(); //selector영역 숨겨요 - 수정에서 취소를 선택하면 보여줌
	
	//$('.comment_list + .CommentWriter').clone() : 기존 글쓰기 영역 복사함
	//글에 있던 영역에 글을 수정할 수 있는 폼으로 바꿈
	$('#' + num).append($('.comment_list + .CommentWriter').clone());
	
	//수정 폼의 textarea에 원래 댓글을 나타내줌
	$('#' + num).find('textarea').val(content);
	
	//btn_register 영역에 수정할 글 번호를 속성 data-id에 나타내고 클래스 update를 추가함
	$('#' + num).find('.btn_register').attr('data-id', num).addClass('update');
	
	//폼에서 취소를 사용할 수 있도록 보이게해줌
	$('#' + num).find('.btn_cancel').css('display', 'block');
	
	var count = content.length;
	$('#' + num).find('.comment_inbox_count').text(count + "/200");
	
}//updateForm() end

function del(num) {
	console.log("del num=" +num )
	if(!confirm('정말 삭제하시겠습니까?')){
		$('#commentItem' + num).hide(); //수정삭제 영역 숨기기
		return;
	}
	
	
	$.ajax({
		url : '../review/reviewDelete',
		data : {num : num},
		success : function(rdata) {
			if(rdata == 1) {
				getList();
			}
		}
	}) //ajax end
}//function del end



function replyform(num, lev, seq, ref) {
	
	var selector = '#' + num
	var output = '<li class="CommentItem CommentItem--reply lev'
			   +  lev	+	' CommentItem-form"></li>'
	
	//선택한 글 뒤에 답글 폼을 추가함.		   
	$(selector).after(output);
	
	//글쓰기 영역 클론으로 복붙함
	output = $('.comment_list + .CommentWriter').clone();
	
	//선택한 글 뒤(next)에 답글 폼 생성함
	$(selector).next().html(output);
	
	//답글폼의 <textarea>의 속성 placeholder를 답글남겨보세요로 바꿔쥼
	$(selector).next().find('textarea').attr('placeholder','답글을 남겨보세요');
	
	//답글폼의 '.bnt_cancel'을 보여주고 클래스 'reply_cancel'을 추가함
	$(selector).next().find('.btn_cancel').css('display', 'block').addClass('reply_cancel');
	
	//답글폼의 ''
	$(selector).next().find('.btn_register').addClass('reply')
					.attr('data-ref', ref).attr('data-lev', lev).attr('data-seq', seq);
	
	$(this).attr('onclick', 'return false')
	
}//function replyform



$(function(){ 
	 
	getList(); 
	
	
	//댓글 글자수 세기
	 $('.CommentBox').on('keyup', '.comment_inbox_text', function(){
		 var length = $(this).val().length;
		 $(this).prev().text(length + '/200');
	 }) 
	 
	 
	 //댓글 등록으르 클릭하면 디비에 저장, 저장 성공후 리스트를 불러옴
	 $('ul+ .CommentWriter .btn_register').click(function(){
		 var content = $('.comment_inbox_text').val();
		 var name = $('.comment_inbox_name').text();
	 	 if(!content) { //내용없이 등록 클릭했을때
	 		 alert("댓글을 입력하세요");
	 		 return;
	 	 } else if (name == '') {
	 		 alert("로그인후 댓글을 작성할 수 있습니다.");
	 		 return false;
	 	 }
	 	 
	 	 $.ajax({
	 		 url : '../review/reviewAdd', //원문등록
	 		 data : {
	 			name : name,
	 		    content : content,
	 		    review_groups_num : $("#num").val(),
	 		    review_re_lev : 0, //원문인경우 re_seq는 0
	 		    review_re_seq : 0, //ref는 댓글의 원문 글번호
	 		    review_re_ref : 0
	 		 },
	 		 type : 'post',
	 		 success : function(rdata) {
	 			 if(rdata == 1 ) {
	 				 getList();
	 			 }
	 		 }
	 	 }) //ajax
	 	 
	 	 $('.comment_inbox_text').val('');
	 	 $('.comment_inbox_count').text('');
	 	 
	 })//btn_register').click(function()
	 	
	 
	 
	//더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라짐 - toggle이용 
	$('.comment_list').on('click', '.comment_tool_button', function(){
		$(this).next().toggle();
	})
	
	
	
	 // 수정후 등록 버튼 클릭한 경우
	$('.CommentBox').on('click', '.update', function(){
		var num = $(this).attr('data-id');
		var content = $(this).parent().parent().find('textarea').val();
		
		$.ajax({
			url : '../review/reviewUpdate',
			data : {
				num : num, 
				content : content
			},
			success : function(rdata) {
				if(rdata == 1) {
					getList();
				}//if
			}//success
		}); //ajax
	}) // 수정후 등록 버튼 클릭한 경우
	

	
	
	//수정하기버튼 누른 후 취소 버튼을 클릭한 경우
	$('.CommentBox').on('click', '.btn_cancel', function(){
		
		//댓글번호 구하기
		var num = $(this).next().attr('data-id');
		var selector = '#' + num;
		
		//.CommentWriter 영역 삭제 
		$(selector + ' .CommentWriter').remove(); //후손이라 한칸띄워줌
		
		//숨겨두었던 .comment_area 영역을 보여줌
		$(selector + '>.comment_area').css('display', 'block');
		console.log($('#commentItem' + num).css('display')) //'block'
		
		$('#commentItem' + num).hide(); //'수정 삭제' 영역 숨기기
		
	})//수정 후 취소 버튼을 클릭한 경우
	
	
	
	//답변 달기 등록 버튼을 클릭한 경우
	$('.CommentBox').on('click','.reply',function(){
		var review_re_ref = $(this).attr('data-ref');
		var content = $(this).parent().parent().find('.comment_inbox_text').val();
		var lev = $(this).attr('data-lev');
		var seq = $(this).attr('data-seq');
		
		/* if(($('#name').val()) != this.name || ($('#name').val()) == '') { 
			 alert("그룹리더만 답글을 작성할 수 있습니다.");
			 return false;
		 } else {
			 return;
		 }*/
		
		$.ajax({
			url : '../review/reviewReplyAdd', 
			data : {
				name : $('#name').val(),
				content : content,
				review_groups_num : $("#num").val(),
				review_re_lev : lev,
				review_re_ref : review_re_ref,
				review_re_seq : seq
			} ,
			type : 'post',
			success : function(rdata) {
				if(rdata == 1) {
					getList();
				}//if
			}//success
		})//ajax
	})//답변 달기 등록 버튼을 클릭한 경우

	
	//답변달기 클릭하고 취소버튼 누를경우
	$('.CommentBox').on('click','.reply_cancel',function(){
		$(this).parent().parent().parent().remove();
	})////답변달기 클릭하고 취소버튼 누를경우
	 

}); //ready