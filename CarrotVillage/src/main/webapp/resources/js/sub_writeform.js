$(document).ready(
      function() {
           $('.section_view > label > input[type=file]').change(function(event){
               var inputfile =$(this).val().split('\\');
               var filename=inputfile[inputfile.length -1];
               var pattern = /(gif|jpg|jpeg|png)$/i;
               if(pattern.test(filename)){
                  $('#board_thumbnailname').text(filename); //inputfile.length - 1 = 2
                  $('#filename').text(filename);
                  
                  var reader =new FileReader();
               reader.readAsDataURL(event.target.files[0])
               reader.onload = function(event){
                     $("#showImage").html('<img width="400px" height="400px" src="' + event.target.result + '">');
               
                     
                  };
               }else{
                             inputfile = "";
                            filename = "";
                           $('#board_thumbnailname').text(filename); //inputfile.length - 1 = 2
                           $("#showImage").html('<img width="400px" height="400px" src="image/mainadd.jpg">');
                  alert('확장자는 gif, jpg, jpeg, png 가능합니다.');
               }
            })
         
         $("#file_add").click(function(){
            var output ="<input type='file' id='upfile3' name='board_file3' accept='image/*'>"
               output += "<span id='filevalue3' style='display:none;'></span>&nbsp;"
               output +="<input type='file' id='upfile4' name='board_file4' accept='image/*'>"
               output += "<span id='filevalue4' style='display:none;'></span><br>"   
               output += "사진 업로드는 최대 4개까지 가능합니다."
            $("#picinfo").append(output+"<br>");
            $("#file_add").attr("style","display:none")
            
         })
      
         if($("#board_bankt").val() == "신한은행" ){
            $("#board_bank").val("신한은행").prop("selected",true);
         }
         if($("#board_bankt").val() == "하나은행" ){
            $("#board_bank").val("하나은행").prop("selected",true);
         }
         if($("#board_bankt").val() == "우리은행" ){
            $("#board_bank").val("우리은행").prop("selected",true);
         }
         if($("#board_bankt").val() == "국민은행" ){
            $("#board_bank").val("국민은행").prop("selected",true);
         }
         if($("#board_bankt").val() == "농협" ){
            $("#board_bank").val("농협").prop("selected",true);
         }
         if($("#board_bankt").val() == "카카오뱅크" ){
            $("#board_bank").val("카카오뱅크").prop("selected",true);
         }
         if($("#board_bankt").val() == "케이뱅크" ){
            $("#board_bank").val("케이뱅크").prop("selected",true);
         }
         
         
            $('#upfile1').change(function(event1) {
      var board_file1 = $(this).val().split('\\');
      var board_filename1 = board_file1[board_file1.length - 1];
      var pattern = /(gif|jpg|jpeg|png)$/i;
      
      if(pattern.test(board_filename1)) {
         $('#filevalue1').text(board_filename1); //inputfile.length - 1 = 2
         var reader1 = new FileReader(); //파일을 읽기 위한 개체 생성
         
         //DataURL 형식으로 파일을 읽어옵니다.
         //읽어온 결과는 reader 개체의 result 속성에 저장됩니다.
         //event1.target.files[0] : 선택한 그림의 파일개체에서 첫번째 개체를 가져옵니다.
         
         reader1.readAsDataURL(event1.target.files[0]);
   
      } else {
         board_file1 = "";
         board_filename1 = "";
         $('#filevalue1').text(board_filename1); //inputfile.length - 1 = 2
         alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
         
      }
         
      });
      
            $('#upfile2').change(function(event2) {
      var board_file2 = $(this).val().split('\\');
      var board_filename2 = board_file2[board_file2.length - 1];
      var pattern = /(gif|jpg|jpeg|png)$/i;
      
      if(pattern.test(board_filename2)) {
         $('#filevalue2').text(board_filename2); //inputfile.length - 1 = 2
         var reader2 = new FileReader(); //파일을 읽기 위한 개체 생성
         
         //DataURL 형식으로 파일을 읽어옵니다.
         //읽어온 결과는 reader 개체의 result 속성에 저장됩니다.
         //event2.target.files[0] : 선택한 그림의 파일개체에서 첫번째 개체를 가져옵니다.
         
         reader2.readAsDataURL(event2.target.files[0]);
   
      } else {
         board_file2 = "";
         board_filename2 = "";
         $('#filevalue2').text(board_filename2); //inputfile.length - 1 = 2
         alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
         
      }
         
      });
         
               $('#upfile3').change(function(event3) {
      var board_file3 = $(this).val().split('\\');
      var board_filename3 = board_file3[board_file3.length - 1];
      var pattern = /(gif|jpg|jpeg|png)$/i;
      
      if(pattern.test(board_filename3)) {
         $('#filevalue3').text(board_filename3); //inputfile.length - 1 = 2
         var reader3 = new FileReader(); //파일을 읽기 위한 개체 생성
         
         //DataURL 형식으로 파일을 읽어옵니다.
         //읽어온 결과는 reader 개체의 result 속성에 저장됩니다.
         //event3.target.files[0] : 선택한 그림의 파일개체에서 첫번째 개체를 가져옵니다.
         
         reader3.readAsDataURL(event3.target.files[0]);
   
      } else {
         board_file3 = "";
         board_filename3 = "";
         $('#filevalue3').text(board_filename3); //inputfile.length - 1 = 2
         alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
         
      }
         
      });
      
            $('#upfile4').change(function(event4) {
      var board_file4 = $(this).val().split('\\');
      var board_filename4 = board_file4[board_file4.length - 1];
      var pattern = /(gif|jpg|jpeg|png)$/i;
      
      if(pattern.test(board_filename4)) {
         $('#filevalue4').text(board_filename4); //inputfile.length - 1 = 2
         var reader4 = new FileReader(); //파일을 읽기 위한 개체 생성
         
         //DataURL 형식으로 파일을 읽어옵니다.
         //읽어온 결과는 reader 개체의 result 속성에 저장됩니다.
         //event4.target.files[0] : 선택한 그림의 파일개체에서 첫번째 개체를 가져옵니다.
         
         reader4.readAsDataURL(event4.target.files[0]);
   
      } else {
         board_file4 = "";
         board_filename4 = "";
         $('#filevalue4').text(board_filename4); //inputfile.length - 1 = 2
         alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
         
      }
         
      });
         
         
            
         
         


         $("#board_price").change(function() {
            if ($.isNumeric($("#board_price").val())) {
               $("#board_bank").focus();

            } else {
               alert("가격 정보는 숫자로 입력해주세요")
               $("#board_price").val('')
               $("#board_price").focus();
            }
         })
         
         $("#board_account").change(function() {
            if ($.isNumeric($("#board_account").val())) {
               $("#board_tel").focus();

            } else {
               alert("계좌 번호는 숫자로 입력해주세요")
               $("#board_account").val('')
               $("#board_account").focus();
            }
         })   
         $("#board_deliverycost").change(function() {
            if ($.isNumeric($("#board_deliverycost").val())) {
               $("#board_bank").focus();

            } else {
               alert("배송비 정보는 숫자로 입력해주세요")
               $("#board_deliverycost").val('')
               $("#board_deliverycost").focus();
            }
         })

         $("#board_tel").change(function() {
            pattern = /^\d{2,3}-\d{3,4}-\d{3,4}$/;
            if (pattern.test($("#board_tel").val())) {
               $("#board_delivery").focus();

            } else {
               alert("전화번호를 확인하세요(000-0000-0000)")
               $("#board_tel").val('')
               $("#board_tel").focus();
            }

         }); 
      


         $("form").submit(
               function() {
      
                 
                        


                  if ($('select').eq(0).val() == "----") {
                     alert("카테고리를 선택해주세요");
                     $('select:eq(0)').focus();
                     return false;
                  }
                  if ($.trim($("#board_subject").val()) == "") {
                     alert("제목을 입력해주세요")
                     $('input:eq(0)').focus();
                     return false;
                  }
               
                  
                  
                  
                  
                  
                  if ($.trim($("#board_price").val()) == "") {
                     alert("가격을 입력해주세요")
                     $("#board_price").focus();
                     return false;

                  }
                  if ($('select').eq(1).val() == "----") {
                     alert("은행명을 선택해주세요");
                     $('select:eq(1)').focus();
                     return false;
                  }

                  if ($.trim($("#board_account").val()) == "") {
                     alert("계좌번호를 입력해주세요")
                     $("#board_account").focus();
                     return false;

                  }

                  if ($.trim($("#board_tel").val()) == "") {
                     alert("연락처를 입력해주세요")
                     $("#board_tel").focus();
                     return false;

                  }

               
                  var cnt =  $("#form-delivery  input:checkbox:checked").length;
                  if (cnt<1) {
                     alert("배송방법을 선택해주세요")
                  
                     return false;
                  }
                  if ($.trim($("#board_deliverycost").val()) == "") {
                     alert("배송비용을 입력해주세요")
                     $("#board_deliverycost").focus();
                     return false;

                  }

                  if ($.trim($("#board_product").val()) == "") {
                     alert("상품명을 입력해주세요")
                     $("#board_product").focus();
                     return false;

                  }
                  if ($.trim($("#board_amount").val()) == "") {
                     alert("수량을 입력해주세요")
                     $("#board_amount").focus();
                     return false;

                  }
                  if ($.trim($("#board_producer").val()) == "") {
                     alert("생산자를 입력해주세요")
                     $("#board_producer").focus();
                     return false;

                  }
                  if ($.trim($("#board_expirydate").val()) == "") {
                     alert("유통기간을 입력해주세요")
                     $("#board_expirydate").focus();
                     return false;

                  }
                  if ($.trim($("#board_origin").val()) == "") {
                     alert("원산지 항목을 입력해주세요")
                     $("#board_origin").focus();
                     return false;

                  }
                  var cnt =  $("#board_storage input:checkbox:checked").length;
                  if (cnt<1) {
                     alert("보관방법을 선택해주세요")
                  
                     return false;

                  }
                  
                        if ($.trim($("#board_content").val()) == "") {
                     alert("내용을 입력해주세요")
                     $("#board_content").focus();
                     return false;

                  }
                  
                 
                  
                  
                  if ($.trim($("#filevalue1").text()) == "") {
                     alert("파일은 최소 2개이상 업로드필수입니다. 1번파일을 업로드해주세요")
                  
                     return false;

                  }
                  if ($.trim($("#filevalue2").text()) == "") {
                     alert("파일은 최소 2개이상 업로드필수입니다. 2번파일을 업로드해주세요")
                  
                     return false;

                  }
                  if ($.trim($("#board_passward").val()) == "") {
                     alert("게시물 비밀번호를 입력해주세요")
                     $("#board_pass").focus();
                     return false;
                  }
                  
                  
               }) //end form.submit


                function show() {
        
         if($('#filevalue').text() == '') {
            $(".remove").css('display', 'none');
         } else {
            $(".remove").css({'display':'inline-block', 'position':'relative', 'top':'-5px'});
         }
      }
      
      show();
      
      $("#upfile").change(function() {
         check++;
         var inputfile = $(this).val().split('\\');
         $('#filevalue').text(inputfile[inputfile.length - 1]);
         show();
         console.log(check);
      });
      
         $(".remove").click(function() {
         $('#filevalue').text('');
         $(this).css('display', 'none')
      })
      });