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
			
			// 글암호 유효성 검사
			var pwval = $("#pw").val().trim();
			if(pwval == "") {
				alert("글암호를 입력하세요!!");
				return;
			}
			
			
			// 폼을 submit
			var frm = document.addFrm;
			frm.method = "POST"; // 파일을 첨부할 경우이라면 반드시 POST 이어야만 가능하다. GET이라면 파일첨부가 안되어진다.
			frm.action = "<%= ctxPath%>/qna/qnaAddEnd.we";
			frm.submit();
			
			
		});
		
	});
</script>

<div style="padding-left: 10%; margin-top: 30px; margin-bottom: 30px; border: solid 0px red;">
	<h1>Write Q & A</h1>
	
<form name="addFrm">
 
		<table id="table">
			<tr>
				<th>성명</th>
				<td>	
				    <input type="hidden" name="p_userid" value="${sessionScope.loginuser.p_userid}" readonly />
					<input type="text" name="q_writer" value="${sessionScope.loginuser.p_name}" class="short" readonly />          
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="q_title" id="subject" class="long" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea name="q_context" id="content" rows="10" cols="100" style="width: 95%; height: 412px;"></textarea>	
				</td>
			</tr>
			
			<tr>
				<th>글암호</th>
				<td><input type="password" name="q_pwd" id="pw" class="short" /></td>
			</tr>
		</table>
		
	    <!--  === #125. 답변글쓰기인 경우 
	                                      부모글의 seq값인 fk_seq 값과
	                                      부모글의 groupno 값과
	                                      부모글의 depthno 값을 hidden 타입으로 보내준다. --> 
	    <input type="hidden" name="fk_qna_seq"  value="${fk_qna_seq}"  /> 
	    <input type="hidden" name="groupno" value="${groupno}" />
	    <input type="hidden" name="depthno" value="${depthno}" />
		
		<div style="margin: 20px;">
			<button type="button" class="bbtns" id="btnWrite">쓰기</button>
			<button type="button" class="bbtns" onclick="javascript:history.back();">취소</button>
		</div>
		
	</form>
</div>






    