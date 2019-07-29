<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
	#div_userid {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_email {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_findResult {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;		
		position: relative;
	}
	
	#div_btnFind {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var userid = "${userid}";
		var email = "${email}";
		var n = "${n}";
		
		// 인증하기
		$("#btnConfirmCode").click(function(){
			var frm = document.verifyCertificationFrm;
			frm.userid.value = $("#userid").val(); 
			frm.userCertificationCode.value = $("#input_confirmCode").val();
			
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/verifyCertification.we"; 
			frm.submit();
		});
		
	});// end of $("#btnFind").$(document).ready(function(){})---------------
	
</script>

<form name="emailFrm">

   
   <div id="div_findResult" align="center">
   	   <c:if test="${n == 1}">
   	      <div id="pwdConfirmCodeDiv">
   	      	  <span style="font-size: 10pt;">인증코드가 ${email}로 발송되었습니다.</span><br/>
   	      	  <span style="font-size: 10pt;">인증코드를 입력해주세요</span><br/>
   	      	 <input type="text" name="input_confirmCode" id="input_confirmCode" required />
   	      	 <br/><br/>
   	      	 <button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>    
   	      </div>
   	   </c:if>
   	   
   	   <c:if test="${n == 0}">
   	   	  <span style="color: red;">사용자 정보가 없습니다.</span>
   	   </c:if>
   	   
   	   <c:if test="${n == -1}">
   	   	  <span style="color: red;">${sendMailFailMsg}</span>
   	   </c:if>
   </div>   
   
</form>


<form name="verifyCertificationFrm">
	<input type="hidden" name="userid" />
	<input type="hidden" name="userCertificationCode" />
</form>











    