<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>    
    
<head>
<link rel="stylesheet" href="css/bootstrap.css">

</head>

<style type="text/css">

#btnRegister{
background: -webkit-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: -moz-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: -ms-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: -o-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	color: white;
  	border: none;
margin-bottom: 40px;
}

</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		var now = new Date(); 
		// 자바스크립트에서 현재날짜시각을 얻어온다.
		
		console.log(now.getFullYear());
		// 4자리 년도를 얻어 오는 것. getFullYear() 메소드로 그렇게 해줬음.

		$(".error_passwd").hide();
		$(".error_ph").hide();
		$(".error_post").hide();
		$(".error_addr").hide();
		$(".error").hide();
		$("#btnRegister").attr("disabled",true);
		$(".error_bd").hide();
	
		$(".single-input").each(function(){
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
	
		
		/// ID중복확인하기 위한 팝업창 띄우기 ///
		$("#p_userid").click(function() {
			
			// 팝업창 띄우기
			var url = "idCheckP.we";
			window.open(url, "idcheck",
					    "left=500px, top=100px, width=300px, height=230px"); // method 조건 없으므로, get방식임.			
		});// end of $("#idcheck").click()------------
		
		
		$("#p_pwd").blur(function(){
			var passwd = $(this).val();
			
		//	var regExp_PW = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			// 또는
			var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 객체 생성
			
			var bool = regExp_PW.test(passwd);
			
			if(!bool) {
				$(".error_passwd").show();
				$(":input").attr("disabled",true); 
				$(this).attr("disabled",false);
				$(this).focus();
			}
			else {
				$(".error_passwd").hide();
				$(":input").attr("disabled",false); 
				$("#pwdcheck").focus();
			} 
		}); // end of $("#pwd").blur()---------------
		
	
		$("#pwdcheck").blur(function(){
			var passwd = $("#p_pwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true);
				$(this).attr("disabled",false);
				$("#p_pwd").attr("disabled",false);
				$("#p_pwd").focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false);
			}
			
		});// end of $("#pwdcheck").blur()--------------
		
		
		$("#p_email").blur(function(){
			
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
		
		$("#p_birthday").blur(function(){
			
		
		var format = /^(19[0-9][0-9]|20\d{2}0[0-9]|1[0-2](0[1-9]|[1-2][0-9]|3[0-1])$/;
		 if(!format.test($(this).val())){
			 $(".error_bd").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
		 }else{
			 $(".error_bd").hide();
			$(":input").attr("disabled", false);
		 }
		
		});
		
		$("#p_hp1").blur(function(){
			
			var hp1 = $(this).val();
			
			var regExp_HP1 = /^[0-9][0-9][0-9]$/g;
			// 3글자가 숫자이라면 들어오도록 검사해주는 정규표현식
			var bool1 = regExp_HP1.test(hp1);
			
			if( !bool1 ) {
				$(".error_ph").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
			}
			else {
				$(".error_ph").hide();
				$(":input").attr("disabled", false);
			}
		
		$("#p_hp2").blur(function(){
			var hp2 = $(this).val();
			
			var bool1 = false;
			var regExp_HP2a = /^[0-9][0-9][0-9]$/g;
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
		
		
		$("#p_hp3").blur(function(){
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
				    $("#post1").val(data.postcode1);  // 우편번호의 첫번째 값     예> 151
				    $("#post2").val(data.postcode2);  // 우편번호의 두번째 값     예> 019
				    $("#addr1").val(data.address);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
				    $("#addr2").focus();
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
		
		
		
		$("#btnRegister").attr("disabled",false);
		
		
	}); // end of $(document).ready()-------------------
	
	});
	
	function goPopup(){
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	    var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
	}
	
	function goRegister(event) {

		if( !$("input:radio[name=p_gender]").is(":checked")) {
			  alert("성별을 선택하셔야 합니다.");
			  return;
		}
		

		else if( !$("input:checkbox[id=agree]").is(":checked") ) {
			alert("이용약관에 동의하셔야 합니다.");
			return;
		} 
   	 
		var frm = document.registerFrm;
		frm.method = "POST";
		frm.action = "joinInsertP.we";
		frm.submit();
	} // end of function goRegister(event)----------
	
	function execPostCode() {
        new daum.Postcode({
            oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                   fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               console.log(data.zonecode);
               console.log(fullRoadAddr);
               
               
               $("[name=p_post]").val(data.zonecode);
               $("[name=p_addr1]").val(fullRoadAddr);
               
           }
        }).open();
    }
	
</script>


<!-- ****** 회원가입 Area Start ****** -->
    <div class="container" id="regist_container">
        <div class="row">

            <div class="col-12"> <%-- col-md-6 클래스 붙어 있었는데, 이거 때문에 폼 크기 고정 돼서 일단 빼봄. --%>
                <div class="checkout_details_area mt-50 clearfix">

                    <div class="cart-page-heading" style= "margin-top: 30px auto;">
                     <h2 style="margin: 30px auto; text-align: center;">Register</h2>
                    </div>

                    <form name="registerFrm" style="width: 80%; margin: 0 auto;">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="p_userid">일반회원 아이디 <span>*</span></label>
                                <input type="text" class="single-input" id="p_userid" name="p_userid" style="width: 250px;" required />
                                <span class="error">아이디는 필수입력 사항입니다.</span>
                            </div>
                            <div style="margin: 0 15px 15px 15px;">
                                <label for="p_pwd">비밀번호 <span>*</span></label>
                                <input type="password" class="single-input" id="p_pwd" name="p_pwd" style="width: 250px;" required />
                                <span class="error error_passwd" style="margin: 3px;">암호는 영문자, 숫자, 특수기호가 혼합된<br/>8~15 글자로만 입력가능합니다.</span>
                            </div>
                            <div style="margin: 0 15px 15px 15px;">
                                <label for="pwdcheck">비밀번호 확인 <span>*</span></label>
                                <input type="password"  id="pwdcheck" style="width: 250px;" required class="single-input" />
                            	<span class="error" style="margin: 3px;">암호가 일치하지 않습니다.</span>
                            </div>
                            
                            <div class="col-12 mb-3">
                                <label for="p_email">이메일 <span>*</span></label>
                                <input type="email" class="single-input" id="p_email" name="p_email" placeholder="abcd@google.com" style="width: 344px" />
                            	<span class="error">이메일 형식에 맞지 않습니다.</span>
                            </div>
                            
                            <div class="col-md-12 mb-3">
                                <label for="p_name">성명 <span>*</span></label>
                                <input type="text" class="single-input" id="p_name" name="p_name" style="width: 250px;" />
                                <span class="error">성명은 필수입력 사항입니다.</span>
                            </div>
                          
                          	<div class="col-md-12 mb-3">
                                <label for="p_birthday">생년월일<span>*</span></label>
                                <input type="text" class="single-input" id="p_birthday" name="p_birthday" style="width: 250px;" />
                                <span class="error error_bd">생년월일을 올바르게 입력하세요.</span>
                            </div>
                          
                            <div class="col-md-12 mb-3" style="margin-bottom: 0 !important; ">
                          		<label for="p_number">전화번호 <span>*</span></label>
                            </div>
                            <div style="margin: 0 10px 15px 10px;">
                                <input type="text" class="single-input" name="p_hp1" id="p_hp1" name="p_hp1" maxlength="3" style="width: 75px" />
                            </div>
                            <span style="margin: 15px 3px;">-</span>
                            <div style="margin: 0 10px 15px 10px;">
                                <input type="text" class="single-input" name="p_hp2" id="p_hp2" name="p_hp2" maxlength="4" style="width: 75px" />
                            </div>
                            <span style="margin: 15px 3px;">-</span>
                            <div  style="margin: 0 10px 15px 10px;">
                                <input type="text" class="single-input" name="p_hp3" id="p_hp3" name="p_hp3" maxlength="4" style="width: 75px" />
                            </div>
                            <div class="col-12 mb-3">
                            	<span class="error error_ph">올바른 연락처 형식이 아닙니다.</span>
                            </div>
                            
                            <div class="col-md-12 mb-3" style="margin: 0 !important;">
                          		<label for="gender">성별 <span>*</span></label>
                            </div>                  
                        	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 30px 25px 15px !important;">
                                    <input type="radio" class="custom-control-input" id="male" name="p_gender" value="1">
                                    <label class="custom-control-label" for="male">남자</label>
                            </div>
                        	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 30px 25px 15px !important;">
                                    <input type="radio" class="custom-control-input" id="female" name="p_gender" value="2">
                                    <label class="custom-control-label" for="female">여자</label>
                            </div>
                            
                            <div class="col-md-12 mb-3" style="margin: 0 !important;">
                      		<label>주소</label>
                        	</div> 
                            <div class="col-md-12 mb-3">                   
							<input class="form-control" style="width: 20%; display: inline;" placeholder="우편번호" name="p_post" id="p_post" type="text" readonly="readonly" >
							    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
							<div class="form-group">
							    <input class="form-control" style="margin-top: 15px; width: 50%;" placeholder="도로명 주소" name=p_addr1 id="p_addr1" type="text" readonly="readonly" />
							</div>
							<div class="form-group">
							    <input class="form-control" style="width: 50%;" placeholder="상세주소" name="p_addr2" id="p_addr2" type="text"  />
							</div>
							</div>
                            
                            
                            <iframe src="<%= request.getContextPath()%>/resources/agree/agree.html" width="85%" height="150px" class="box" style="margin: 15px 0px 15px 15px; padding: 15px; border:none; box-shadow: 5px 5px 5px #ddd;"></iframe>
                                                               
                            <div class="custom-control custom-checkbox d-block mb-2" style="margin: 0 10px 50px 15px !important;">
                                    <input type="checkbox" class="custom-control-input" id="agree">
                                    <label class="custom-control-label" for="agree">이용약관에 동의합니다.</label>
                            </div>
                        </div>
                        <div align="center">
                            <button type="button" id="btnRegister" class="btn karl-checkout-btn" onClick="goRegister(event);">가입하기</button>
                    	</div>
                    </form>
                </div>
            </div>

        </div>
    </div>
        <!-- ****** 회원가입 Area End ****** -->