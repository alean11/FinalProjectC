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
		
		// 찾기
		$("#btnFind").click(function(){
			
			var useridVal = $("#userid").val().trim();
			var emailVal = $("#email").val().trim();
			
			if(useridVal != "" && emailVal != "") {
				var frm = document.emailFrm;
				frm.method = "GET";
				frm.action = "<%= ctxPath%>/emailFrm.we";
				frm.submit();
			}
			else {
				alert("아이디와 이메일을 입력하세요!!");
			}
		});
		
		
	});// end of $("#btnFind").$(document).ready(function(){})---------------
	
</script>

<form name="emailFrm">
   <div id="div_userid" align="center">
      <span style="color: blue; font-size: 12pt;">아이디</span><br/> 
      <input type="text" name="userid" id="userid" size="15" placeholder="ID" required />
   </div>
   
   <div id="div_email" align="center">
   	  <span style="color: blue; font-size: 12pt;">이메일</span><br/>
      <input type="text" name="email" id="email" size="15" placeholder="abc@def.com" required />
   </div>
   
   <div id="div_btnFind" align="center">
   	  <button type="button" class="btn btn-success" id="btnFind">인증코드 전송</button>
   </div>
</form>


<form name="verifyCertificationFrm">
	<input type="hidden" name="userid" />
	<input type="hidden" name="userCertificationCode" />
</form>











    