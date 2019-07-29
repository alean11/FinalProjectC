<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script type="text/javascript">
$(function() {

  $('input[name="startDate"], input[name="endDate"]').daterangepicker({
      autoUpdateInput: false,
      locale: {
          cancelLabel: 'Clear'
      }
  });

  $('input[name="startDate"], input[name="endDate"]').on('apply.daterangepicker', function(ev, picker) {
      $("#startDate").val(picker.startDate.format('YYYY-MM-DD'))
      $("#endDate").val(picker.endDate.format('YYYY-MM-DD'))      
  });

  $('input[name="startDate"], input[name="endDate"]').on('cancel.daterangepicker', function(ev, picker) {
	  $("#startDate").val('');
	  $("#endDate").val('');
  });

});
$(document).ready(function(){
	$(".confirm").hide();
	
	$(".submit").click(function() {
		 var frm = document.hotelFrm;
		 
		 frm.method = "GET";
		 frm.action = "reserveEnd.we";
	     frm.submit();
	});
	$(".myclose").click(function() {
		location.href = <%request.getContextPath();%>"reserve.we";
	});
	$("#email_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_EmailCheck();
	});
	$("#emailConfirm_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_EmailConfirmCheck();
	});
});

function fn_EmailCheck() {
	var email = $("#email").val();
	var userData = {
		"email" : email
	}

	if (email.length < 1) {
		alert("이메일을 입력해주시기 바랍니다.");
	} else {
		$.ajax({
			type : "POST",
			url : "checkEmail.we",

			data : userData,
			dataType : "json",
			success : function(result) {
				if (result == 0) {
					$("#email").attr("disabled", true);
					alert("이메일이 틀렸습니다. \n 다시 입력해 주세요.");
				} else if (result == 1) {
					alert("입력한 이메일로 이메일이 발송되었습니다.");
					$(".confirm").show();
					$(".email").hide();
				}else if (result == -1) {
					alert("메일 발송이 실패했습니다.");
				}
				else {
					alert("에러가 발생하였습니다.");
				}
			},
			error : function(error) {
				alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
			}
		});
	}
};
function fn_EmailConfirmCheck() {
	var emailConfirm = $("#emailConfirm").val();
	var userData = {
		"emailConfirm" : emailConfirm
	}

	if (emailConfirm.length < 1) {
		alert("이메일을 입력해주시기 바랍니다.");
	} else {
		$.ajax({
			type : "POST",
			url : "EmailverifyCertification.we",

			data : userData,
			dataType : "json",
			success : function(result) {
				if (!result) {
					$("#email").attr("disabled", true);
					alert("발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!");
				} else if (result) {
					alert("인증성공 되었습니다.");
				     $(".confirm").attr("disabled", true);
				}
				else {
					alert("에러가 발생하였습니다.");
				}
			},
			error : function(error) {
				alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
			}
		});
	}
};


</script>

<div align="center">
	<form name="hotelFrm">
		<div align="center" style="width: 80%;">
			<div align="left"><h1>hotelname</h1></div>	<!-- {p_name} -->
			<div align="left"><h2>room</h2></div>		<!-- r_name -->
			<div>
				<img src="/wetre/resources/img/hotel_img/한화리조트 대천 파로스_HI510513053.jpg" width="30%;" align="left"/>
			</div>
			<!-- 
			<h1 style="width:100%; font-family: serif;">
				<input style="width:47%;" type="text" name="datefilter" id="startDate" value="" placeholder="체크인"/> -> 
				<input style="width:47%;" type="text" name="datefilter" id="endDate" value="" placeholder="체크아웃"/>
			</h1>
			<h2 style="width:100%; font-family: serif;">10:00 -> 24:00</h2> -->
			<div style="margin-top: 10px;">
			<table style="width: 100%; font-size: 30px;">
			
				<tr style="width: 100%;">
				
					<td align="left">
						<input style="width:90%;" type="text" name="startDate" id="startDate" value="" placeholder="체크인" autocomplete="off"/>
					</td>
					
					<td align="center">
						 -> 
					</td>
					
					<td align="left">
						<input style="width:90%;" type="text" name="endDate" id="endDate" value="" placeholder="체크아웃" autocomplete="off"/>
					</td>
				</tr>
				<tr style="width: 100%;">
					<td align="left">
						10:00
					</td>
				
					<td align="center">
						
					</td>
					
					<td align="left">
						24:00
					</td>					
				</tr>
			</table>
			</div>
			
			<div align="left"><h2>예약정보</h2></div>
			
			<div style="width: 100%">
				<label style="width: 8%">예약약자 이름</label><input type="text" name="p_name" placeholder="체크인 시 필요합니다." style="margin:1%; width: 90%;"/>
			</div>
			
			<div style="width: 100%">
				<label style="width: 8%">예약약자 이메일</label><input type="text" name="email" placeholder="인증번호 발송 시 필요합니다." style="margin:1%; width: 90%;"/>
			</div>
<!-- 			<div style="width: 100%">
				<label style="width: 8%">예약약자 번호</label><input type="text" name="tel" placeholder="예약문자 발송 시 필요합니다." style="margin:1%; width: 90%;"/>
			</div> -->
			<input type="text" name="email" id="email" class="email"  placeholder="인증번호 발송 시 필요합니다."/>
			<a href="#" id="email_checkBtn" class="btn email">인증코드 보내기</a>
			<input type="text" name="emailConfirm" id="emailConfirm" class="confirm"/>
			<a href="#" id="emailConfirm_checkBtn" class="btn confirm">이메일 인증</a>
<!-- 			<div style="width: 100%">
				<button onclick="gmail();" style="width: 8%">인증번호 전송</button><input type="text" placeholder="인증번호 6자리 입력" style="margin:1%; width: 90%;"/>
			</div> -->
			
			<div style="width: 100%; margin-bottom: 10px;">
			
				<button style="width: 100%" class="submit">확인</button>
			</div>
		</div>
	</form>
	
 </div>