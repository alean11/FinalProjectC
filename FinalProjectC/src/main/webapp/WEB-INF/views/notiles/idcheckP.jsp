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

<style type="text/css">

.idcheck_btn{
background: -webkit-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: -moz-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: -ms-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: -o-linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	background: linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
  	color: white;
  	border: none;
margin-bottom: 20px;
}

</style>

<script type="text/javascript">

	$(document).ready(function(){

		$(".error").hide();
		$("#p_userid").focus();
		
		$("#p_userid").keydown(function(event){
			if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우에도 아이디 중복검사
				goCheck();
			}
		});
		
	}); // end of ready-------
	
	
	function goCheck() {
		var p_userid = $("#p_userid").val().trim();
		
		if(p_userid == "") {
			$(".error").show();
			$("#p_userid").val("");
			$("#p_userid").focus();
			return;
		}
		else {
			$(".error").hide();
			var frm = document.frmIdcheck;
			frm.method = "POST";
			frm.action = "/wetre/idCheckEndP.we";
			frm.submit();
		}
		
	} // end of goCheck()------

	
	
	
	

</script>
</head>
<body>

	<%-- 전송방식이 get이면, id 중복 검사를 하기 위한 폼을 띄워줌. --%>
	<div align="center" style="margin-top: 40px;">
		<form name="frmIdcheck">
			<div class="idcheck" >
				<span class="idcheck">아이디를 입력하세요.</span><br style="line-height: 200%;"/><!-- line-height는 줄간격 말함. -->
				<input type="text" name="p_userid" id="p_userid" class="idcheck_input" size="20" maxlength="20" /><br style="line-height: 300%;"/>
				<span class="idcheck error">아이디를 입력하세요.</span><br/>
				<button type="button" class="idcheck_btn" onclick="goCheck();">확인</button>
			</div>
		</form>
	</div>
	<%-- 전송방식이 post이면, DB로 값을 보내서 중복검사를 함. --%>
	

	
</body>
</html>