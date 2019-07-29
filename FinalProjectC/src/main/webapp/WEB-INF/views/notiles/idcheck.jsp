<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String ctxPath = request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 검사 팝업창</title>

<link rel="stylesheet" href="<%= ctxPath%>/resources/css/core-style.css">
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style.css">
<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){

		$(".error").hide();
		$("#cp_id").focus();
		
		$("#cp_id").keydown(function(event){
			if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우에도 아이디 중복검사
				goCheck();
			}
		});
		
	}); // end of ready-------
	
	
	function goCheck() {
		var cp_id = $("#cp_id").val().trim();
		
		if(cp_id == "") {
			$(".error").show();
			$("#cp_id").val("");
			$("#cp_id").focus();
			return;
		}
		else {
			$(".error").hide();
			var frm = document.frmIdcheck;
			frm.method = "POST";
			frm.action = "/wetre/idCheckB.we";
			frm.submit();
		}
		
	} // end of goCheck()------

	
	
	
	

</script>
</head>
<body>

	<%-- 전송방식이 get이면, id 중복 검사를 하기 위한 폼을 띄워줌. --%>
	
		<form name="frmIdcheck">
			<div class="idcheck" >
				<span class="idcheck">아이디를 입력하세요.</span><br style="line-height: 200%;"/><!-- line-height는 줄간격 말함. -->
				<input type="text" name="cp_id" id="cp_id" class="idcheck_input" size="20" maxlength="20" /><br style="line-height: 300%;"/>
				<span class="idcheck error">아이디를 입력하세요.</span><br/>
				<button type="button" class="idcheck_btn" onclick="goCheck();">확인</button>
			</div>
		</form>
	
	<%-- 전송방식이 post이면, DB로 값을 보내서 중복검사를 함. --%>
	

	
</body>
</html>