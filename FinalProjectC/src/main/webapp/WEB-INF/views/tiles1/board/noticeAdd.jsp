<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	#table {
	margin-top: 30px;
	}
	table, th, td, input, textarea {border: none;}
    #table {width: 970px; border-collapse: collapse; border: none;}
    #table th, #table td {padding: 5px; border-right: 1px dotted #9035f9; border-bottom: 1px dotted #9035f9;}
    #table td:last-child {border-right: none;}
    #table th:last-child {border-bottom: none;}
    #table th {background-color: transparent; border-right: 1px dotted #9035f9; border-bottom: 1px dotted #9035f9; height: 40px; width: 10%;}
	
	.long {width: 470px;}
	.short {width: 120px;} 			
</style>
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/ahm_style.css">
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style.css">
<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		//쓰기버튼
		$("#btnWrite").click(function(){
			
			// 글제목 유효성 검사
			var subjectval = $("#subject").val().trim();
			if(subjectval == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			// 글내용 유효성 검사
			var contentval = $("#content").val().trim();
			if(contentval == "") {
				alert("글내용을 입력하세요!!");
				return;
			}
			
			
			// 폼을 submit
			var frm = document.addFrm;
			frm.method = "POST"; // 파일을 첨부할 경우이라면 반드시 POST 이어야만 가능하다. GET이라면 파일첨부가 안되어진다.
			frm.action = "<%= ctxPath%>/notice/noticeAddEnd.we";
			frm.submit();
			
			
		});
		
	});
</script>

<div style="padding-left: 10%; margin-top: 30px; margin-bottom: 60px; border: solid 0px red;">
	<h1>Write Notice</h1>
	
<form name="addFrm">
 
		<table id="table">
			<tr>
				<th>성명</th>
				<td>관리자</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="n_title" id="subject" class="long" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea name="n_context" id="content" rows="10" cols="100" style="width: 95%; height: 412px;"></textarea>	
				</td>
			</tr>
			
		</table>
		
		<div style="margin: 20px;">
			<button type="button" class="bbtns" id="btnWrite">쓰기</button>
			<button type="button" class="bbtns" onclick="javascript:history.back();">취소</button>
		</div>
		
	</form>
</div>






    