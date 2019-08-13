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
		
		//수정완료버튼
		$("#btnUpdate").click(function(){
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
			var frm = document.editFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/noticeEditEnd.we";
			frm.submit();
		});
		
	});
</script>

<div style="padding-left: 10%; margin-bottom: -2%; border: solid 0px red;">
	<h1>글수정</h1>
	
	<form name="editFrm">
		<table id="table">
			<tr>
				<th>성명</th>
				<td>	
				    <input type="hidden" name="n_idx" value="${noticevo.n_idx}" />
				    관리자
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="n_title" id="subject" class="long" value="${noticevo.n_title}" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea name="n_context" id="content" rows="10" cols="100" style="width: 95%; height: 412px;">${noticevo.n_context}</textarea>   	
				</td>
			</tr>
		</table>
		
		<div style="margin: 20px;">
			<button type="button" id="btnUpdate">완료</button>
			<button type="button" onclick="javascript:history.back();">취소</button>
		</div>
		
	</form>
</div>






    