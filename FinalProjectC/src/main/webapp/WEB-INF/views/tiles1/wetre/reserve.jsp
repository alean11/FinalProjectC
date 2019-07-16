<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script type="text/javascript">
$(function() {

  $('input[name="datefilter"]').daterangepicker({
      autoUpdateInput: false,
      locale: {
          cancelLabel: 'Clear'
      }
  });

  $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
      $("#startDate").val(picker.startDate.format('YYYY-MM-DD'))
      $("#endDate").val(picker.endDate.format('YYYY-MM-DD'))      
  });

  $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
	  $("#startDate").val('');
	  $("#endDate").val('');
  });

});
</script>
<div align="center">
	<form name="hotel">
		<div align="center" style="width: 80%;">
			<div align="left"><h1>hotelname</h1></div>
			<div align="left"><h2>room</h2></div>
			<!-- 
			<h1 style="width:100%; font-family: serif;">
				<input style="width:47%;" type="text" name="datefilter" id="startDate" value="" placeholder="체크인"/> -> 
				<input style="width:47%;" type="text" name="datefilter" id="endDate" value="" placeholder="체크아웃"/>
			</h1>
			<h2 style="width:100%; font-family: serif;">10:00 -> 24:00</h2> -->
			<table style="width: 100%; font-size: 30px;">
			
				<tr style="width: 100%;">
					<td align="left">
						<input style="width:90%;" type="text" name="datefilter" id="startDate" value="" placeholder="체크인"/>
					</td>
					
					<td align="center">
						 -> 
					</td>
					
					<td align="left">
						<input style="width:90%;" type="text" name="datefilter" id="endDate" value="" placeholder="체크아웃"/>
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
			
			<div align="left"><h2>예약정보</h2></div>
			
			<div style="width: 100%">
				<label style="width: 8%">예약약자 이름</label><input type="text" placeholder="체크인 시 필요합니다." style="margin:1%; width: 90%;"/>
			</div>
			
			<div style="width: 100%">
				<label style="width: 8%">예약약자 번호</label><input type="text" placeholder="예약문자 발송 시 필요합니다." style="margin:1%; width: 90%;"/>
			</div>
			
			<div style="width: 100%">
				<button style="width: 8%">인증번호 전송</button><input type="text" placeholder="인증번호 6자리 입력" style="margin:1%; width: 90%;"/>
			</div>
			
			<div style="width: 100%; margin-bottom: 10px;">
			
				<button style="width: 100%">확인</button>
			</div>
		</div>
	</form>
 </div>