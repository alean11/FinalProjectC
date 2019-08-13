<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table {border-collapse: collapse;
	 		width: 900px;
	 		}
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 860px;}
	.long {width: 470px;}
	.short {width: 120px;} 		
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#btnDelete").click(function(){
			
			// 폼을 submit
			var frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/delEndNotice.we";
			frm.submit();
		});
		
	});
</script>

<div style="padding-left: 10%; margin-bottom: -2%; border: solid 0px red;">
	<h1>글삭제</h1>
	
	<form name="delFrm">
		<h5>정말 삭제하시겠습니까?</h5>
		<input type="hidden"   name="n_idx" value="${n_idx}" />
		
		<div style="margin: 20px;">
			<button type="button" id="btnDelete">삭제</button>
			<button type="button" onclick="javascript:history.back();">취소</button>
		</div>
		
	</form>
</div>
    