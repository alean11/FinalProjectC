<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String cnpt = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="resources/js/bootstrap-input-spinner.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>  

<style>
.container{
	margin-bottom: 30px;
}
.spinner {
   width: 300px;
}

.spinner input {
   text-align: right;
}

.input-group-btn-vertical {
   position: relative;
   white-space: nowrap;
   width: 1%;
   vertical-align: middle;
   display: table-cell;
   
}

.input-group-btn-vertical>.btn {
   display: block;
   float: none;
   width: 100%;
   max-width: 100%;
   padding: 8px;
   margin-left: -1px;
   position: relative;
   border-radius: 0;
}

.input-group-btn-vertical>.btn:first-child {
   border-top-right-radius: 4px;
}

.input-group-btn-vertical>.btn:last-child {
   margin-top: -2px;
   border-bottom-right-radius: 4px;
}

.input-group-btn-vertical i {
   position: absolute;
   top: 0;
   left: 4px;
}


ul.subMenu {
    margin: 0;
    padding: 0;
}

ul.subMenu li{ 
	padding-right: 10px;
 	list-style : none;  
 	display : inline;
    border-right: 1px solid gray;
 	width : 100%;
 	font-size: 30px;
    margin-right: 10px;
}
ul.subMenu li:last-child{
	margin-right: 0;
}

</style>




<script type="text/javascript">
	
	$(document).ready(function(){
		var now = new Date(); 
		// 자바스크립트에서 현재날짜시각을 얻어온다.
		
		console.log(now.getFullYear());
		// 4자리 년도를 얻어 오는 것. getFullYear() 메소드로 그렇게 해줬음.
		
		$('#lee').blur(function() {
         var regexp = /^[0-9]*$/

         var input = $('#lee').val();

         if (!regexp.test(input)) {

            alert("숫자만 입력하세요");

            $('#lee').val("");
         }
         console.log(input);
         if (parseInt(input) > 999) {
            $('#lee').val(999);
         } else if (parseInt(input) < 0) {
            $('#lee').val(0);

         }
      });
		
     $('.spinner .btn:first-of-type').on(
            'click',
            function() {
               var btn = $(this);
               var input = btn.closest('.spinner').find('input');
               if (input.attr('max') == undefined
                     || parseInt(input.val()) < parseInt(input
                           .attr('max'))) {
                  input.val(parseInt(input.val(), 10) + 1);
               } else {
                  btn.next("disabled", true);
               }
            });
      $('.spinner .btn:last-of-type').on(
            'click',
            function() {
               var btn = $(this);
               var input = btn.closest('.spinner').find('input');
               if (input.attr('min') == undefined
                     || parseInt(input.val()) > parseInt(input
                           .attr('min'))) {
                  input.val(parseInt(input.val(), 10) - 1);
               } else {
                  btn.prev("disabled", true);
               }
            }); 
      
      
      /* $("#lee").bind("change", function(){ */
    	  $("input[type='number']").on("change", function (event) {
			//==== 스피너는 이벤트가 "change" 가 아니라 "spinstop" 이다. ====//
			
			var html = "";
			var spinnerRtypeVal = $("input[type='number']").val();
			var rtype_Name = [];
			var rtype_cnt = [];
			var r_text = [];
			var ay_fee = [];
			var k_fee = [];
			var bm_br_addfee = [];
			var bm_amenity = [];
			var bm_device = [];
			
			
				console.log(spinnerRtypeVal);
				for (var i = 0; i < parseInt(spinnerRtypeVal); i++) {
					rtype_Name[i] = $("input[name='rtype_Name"+i+"']").val();
					rtype_cnt[i] = $("input[name='rtype_cnt"+i+"']").val();
					r_text[i] = $("#t"+i).val();
					ay_fee[i] = $("input[name='ay_fee"+i+"']").val();
					k_fee[i] = $("input[name='k_fee"+i+"']").val();
					bm_br_addfee[i] = $("input[name='bm_br_addfee"+i+"']").val();
					bm_amenity[i] = $("input[name='bm_amenity"+i+"']").val();
					bm_device[i] = $("input[name='bm_device"+i+"']").val();
				}
			
			if(spinnerRtypeVal == 0) {
							
				$("#divfileattach").empty();
				$("#rtypeCount").val("");
				console.log("놉");
				return;
			}
			else {
				console.log("얍");
				for(var i=0; i<parseInt(spinnerRtypeVal); i++) {
					html += "<br/><div style='width: 300px; margin-bottom: 30px;'  >"
						+"<h2> === " + (i+1) + "번째방 === </h2></br>"
						+"<span>방이름</span><input type='text' class='form-control' name='rtype_Name"+i+"'' />"
						+"<span>방개수</span><input type='text'  class='form-control cntCnt rtype_cnt' name='rtype_cnt"+i+"'' />"
						+"<span>방설명</span><textarea type='text' id='t"+i+"' class='form-control' name='r_text"+i+"' style=' width: 500px; height: 300px;' />"
						+"<span>성인&청소년 요금</span><input type='text' class='form-control' name='ay_fee"+i+"'' />"
						+"<span>어린이 요금</span><input type='text' class='form-control' name='k_fee"+i+"'' />"
						+"<span>조식 추가 요금</span><input type='text' class='form-control' name='bm_br_addfee"+i+"'' placeholder= '조식 없을시 - 0' />"
						+"<span>구비 물품</span><input type='text' class='form-control' name='bm_amenity"+i+"'' placeholder= '예) 무료주차 및 무료 와이파이'/>"
						+"<span>구비 설비</span><input type='text' class='form-control' name='bm_device"+i+"'' placeholder= '예) 플레이스테이션 ' />"
						+"</div>";
					$("#divfileattach").empty();
					$("#divfileattach").append(html);				
				}// end of for------------- 
				$("#rtypeCount").val(spinnerRtypeVal);
			}
			
			for (var i = 0; i < parseInt(spinnerRtypeVal); i++) {
				$("input[name='rtype_Name"+i+"']").val(rtype_Name[i]);
				
				$("input[name='rtype_cnt"+i+"']").val(rtype_cnt[i]);
				$("#t"+i).val(r_text[i]);
				$("input[name='ay_fee"+i+"']").val(ay_fee[i]);
				$("input[name='k_fee"+i+"']").val(k_fee[i]);
				$("input[name='bm_br_addfee"+i+"']").val(bm_br_addfee[i]);
				$("input[name='bm_amenity"+i+"']").val(bm_amenity[i]);
				$("input[name='bm_device"+i+"']").val(bm_device[i]);
			}
			
		});
      
      
	
		
		$(".error_ph").hide();
		$(".error_post").hide();
		$(".error_addr").hide();
		$(".error").hide();
	
		$(".requiredInfo").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data == "") {
					// 입력하지 않거나 공백만 입력했을 경우
					$(this).parent().find(".error").show();
					$(":input").attr("disabled",true); 
					$(this).attr("disabled",false);
					$(this).focus();
				}
				else {
					// 공백이 아닌 글자를 입력했을 경우
					$(this).parent().find(".error").hide();
					$(":input").attr("disabled",false); 
				}
			});
		}); // end of $(".requiredInfo").each()-------
	
		
		
		$("#email").blur(function(){
			
			var email = $(this).val();
			
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			
			var bool = regExp_EMAIL.test(email);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true);
				$(this).attr("disabled",false); 
				$(this).focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false);
			}
			
		});// end of $("#email").blur()--------------
		
		
		$("#hp2").blur(function(){
			var hp2 = $(this).val();
			
			var bool1 = false;
			var regExp_HP2a = /^[1-9][0-9][0-9]$/g;
			// 3글자가 숫자이라면 들어오도록 검사해주는 정규표현식
			var bool1 = regExp_HP2a.test(hp2);
			
			var bool2 = false;
			var regExp_HP2b = /^[0-9][0-9][0-9][0-9]$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			var bool2 = regExp_HP2b.test(hp2);
			
			if( !(bool1 || bool2) ) {
				$(".error_ph").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
			}
			else {
				$(".error_ph").hide();
				$(":input").attr("disabled", false);
			}
			
		});// end of $("#hp2").blur()-------------
		
		
		$("#hp3").blur(function(){
			var hp3 = $(this).val();
			
			var regExp_HP3 = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			var bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				$(".error_ph").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
			}
			else {
				$(".error_ph").hide();
				$(":input").attr("disabled", false);
			}			
		});// end of $("#hp3").blur()-------------
		
		
		$(".zipcodeSearch").click(function(){
			new daum.Postcode({
				oncomplete: function(data) {
				    $("#acc_post1").val(data.postcode1);  // 우편번호의 첫번째 값     예> 151
				    $("#acc_post2").val(data.postcode2);  // 우편번호의 두번째 값     예> 019
				    $("#acc_addr1").val(data.address);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
				    $("#acc_addr2").focus();
				}
			}).open();
		});
		
		
		$(".address").blur(function(){
			var address = $(this).val().trim();
			if(address == "") {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
				$(this).focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false);
			}
		});
		

		$(".cntCnt").blur(function(){
			var total = $("input[name='acc_Rcnt']").val();
			console.log("total : " + total);
			var spinnerRtypeVal = $("input[type='number']").val();
			var rcnt = 0
			console.log($("input[class='rtype_cnt']").val());
			/* for (var i = 0; i < parseInt(spinnerRtypeVal); i++) {
				rcnt += + $("input[class='rtype_cnt"+i+"']").val();
				console.log("rcnt : " + rcnt);
			} */
			if(total < rcnt){
				aleat("등록하려는 방이 총 방의 개수를 초과하였습니다.")
				$(".rtype_cnt").val("");
			}
			
		});
		
		
	}); // end of $(document).ready()-------------------
	
	
	function goRegister(event) {

	
		var frm = document.registerFrm;
		frm.method = "POST";
		frm.action = "hrInsert.we"; // 동일한 경로에 있으니까, 파일 이름만 쓰고 앞에 아무것도 안 써준 것.
		frm.submit();
	} // end of function goRegister(event)----------
	
	  $("input[type='number']").inputSpinner()
	
	
</script>


 
 <!-- ****** 호텔 등록 Area Start ****** -->
 
 
 
     <div class="container" id="regist_container">
         <div class="row">

			<div style="display: inline-block; margin: 40px auto;" >
				<ul class="subMenu">
					<li> <a href="companymp.we" >기업정보수정</a></li>		
					<li> <a href="hrmp.we"> 호텔,객실 수정</a></li>
					<!-- <li><a href="hrregister.we" >호텔 등록</a></li> -->
				</ul>
			</div>

             <div class="col-12"> <%-- col-md-6 클래스 붙어 있었는데, 이거 때문에 폼 크기 고정 돼서 일단 빼봄. --%>
                 <div class="checkout_details_area mt-50 clearfix">

                     <div class="cart-page-heading">
                         <h5>호텔 등록</h5>
                         <p>Hotel Registration</p>
                     </div>

                     <form name="registerFrm" enctype="multipart/form-data" method="POST" action="<%=cnpt %>/hrInsert.we" >
                         <div class="row">
                            
                            
                            
                             <div class="col-md-12 mb-3">
                                 <label for="company">호텔명 <span>*</span></label>
                                 <input type="text" class="requiredInfo form-control" id="acc_name" name="acc_name" style="width: 250px;" />
                                 <span class="error">호텔명은 필수입력 사항입니다.</span>
                             </div>
                             
                             
                             <div class="col-md-12 mb-3" style="margin-bottom: 0 !important; ">
                           		<label for="phone_number">호텔 전화번호 <span>*</span></label>
                             </div>
                             <div style="margin: 0 10px 15px 10px;">
                                 <input type="text" class="form-control" name="acc_tel1" id="acc_tel1" maxlength="4" style="width: 75px" />
                             </div>
                             <span style="margin: 15px 3px;">-</span>
                             <div style="margin: 0 10px 15px 10px;">
                                 <input type="text" class="form-control" name="acc_tel2" id="acc_tel2" maxlength="4" style="width: 75px" />
                             </div>
                             <span style="margin: 15px 3px;">-</span>
                             <div  style="margin: 0 10px 15px 10px;">
                                 <input type="text" class="form-control" name="acc_tel3" id="acc_tel3" maxlength="4" style="width: 75px" />
                             </div>
                             <div class="col-12 mb-3">
                             	<span class="error error_ph">올바른 연락처 형식이 아닙니다.</span>
                             </div>
                             
                             <div class="col-md-12 mb-3" style="margin: 0 !important; ">
                           		<label for="postcode1" class="zipcodeSearch" style="cursor: pointer;">우편번호 찾기 <span>*</span></label>
                             </div>
                             <div style="margin: 0 15px 15px 15px;">
                                 <input type="text" class="form-control zipcodeSearch" id="acc_post1" name="acc_post1" style="width: 100px" />
                             </div>
                             <span style="margin: 15px 0px;">-</span>
                             <div style="margin: 0 15px 15px 15px;">
                                 <input type="text" class="form-control zipcodeSearch" id="acc_post2" name="acc_post2" style="width: 100px" />
                             </div>
                             <div class="col-12 mb-3">
                                 <label for="street_address">주소 <span>*</span></label>
                                 <input type="text" class="address form-control mb-3" id="acc_addr1" name="acc_addr1" style="width: 344px;" />
                                 <input type="text" class="address form-control mb-3" id="acc_addr2" name="acc_addr2" style="width: 344px; margin-bottom: 1px !important;" />
                                 <span class="error">주소를 입력하세요</span>
                             </div>
                            
                                                        
                           	<div class="col-12 mb-3" >
								<label >호텔 이미지 <span>*</span></label><br/>							
								<input type="file" name="attach" />
							</div>
                                                        
                             <div class="col-12 mb-3">
                                 <label >호텔 설명 <span>*</span></label>                                     
                                 <textarea name="acc_text" rows="5" cols="60" class="requiredInfo form-control" style="height:200px;"></textarea>
                             	 <span class="error">호텔 설명을 입력하세요.</span>
                             </div>
                                       
	                       	<div class="input-group spinner" align="left" style="margin-bottom: 20px;"> 
					            <span style="text-align: left;">방개수</span> <br/>
					             <input type="text" name="acc_Rcnt" class="form-control cntCnt"max="999" min="0" value="0" ><br/>
					              <!-- <input type="text"	id="lee" name="acc_Rcnt" class="form-control" max="999"	min="0"><br /> -->
					           <div class="input-group-btn-vertical">
					               <button class="btn btn-default" type="button">
					                  <i class="fa fa-caret-up"></i>
					               </button>
					               <button class="btn btn-default" type="button">
					                  <i class="fa fa-caret-down"></i>
					               </button>
					            </div>
					         </div>
					         
					         <div class="col-md-12 mb-3" style="margin: 0 !important;">
                            		<label >호텔종류 <span>*</span></label>
                             </div>                  
                          	 
                          	 <div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 30px 25px 15px !important;">
                                      <input type="radio" class="custom-control-input" id="hotel" name="acc_type" value="호텔">
                                      <label class="custom-control-label" for="hotel">호텔</label>
                             </div>
	                         
	                         <div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 30px 25px 15px !important;">
                                    <input type="radio" class="custom-control-input" id="resort" name="acc_type" value="리조트">
                                    <label class="custom-control-label" for="resort">리조트</label>
                             </div>
					         
					         <div class="col-md-12 mb-3" style="margin: 0 !important;">
                                  		<label>호텔 등급</label>
                                    </div>
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 10px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="one" name="acc_grade" value="1">
                                            <label class="custom-control-label" for="one">1★</label>
                                    </div>
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 10px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="two" name="acc_grade" value="2">
                                            <label class="custom-control-label" for="two">2★</label>
                                    </div>
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 10px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="three" name="acc_grade" value="3">
                                            <label class="custom-control-label" for="three">3★</label>
                                    </div>
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 10px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="four" name="acc_grade" value="4">
                                            <label class="custom-control-label" for="four">4★</label>
                                    </div>
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 10px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="five" name="acc_grade" value="5">
                                            <label class="custom-control-label" for="five">5★</label>
                                    </div>                                	
					         <br/><br/>
					   		</div>
						
						
						<div class="input-group spinner" align="left"
							style="margin-bottom: 20px;">
							<label for="last_name">방종류(선택) <span>*</span></label> <label
								for="spinnerRtype">방종류 수 : </label>
							 <input type="number"	id="lee" name="rtype_cnt" class="form-control" max="999"
								min="0"><br />
							<input type=hidden name="rtypeCount" id="rtypeCount" />
						</div>

	
							<div id="divfileattach">
							
							</div>
						





				
                             <button type="submit" id="btnRegister" class="">등록하기</button>
                             
                             
                             <input type="hidden" name="cp_id" value="${sessionScope.companyuser.cp_id}"/>                             	
                     </form>
                 </div>
             </div>

         </div>
     </div>
 <!-- ****** 호텔등록 Area End ****** -->
