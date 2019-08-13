<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
<script src="/wetre/resources/js/jquery-3.2.1.min.js"></script>
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

function setp_userid(p_userid) {

	//// 팝업창에서 부모창으로 값 넘기는 방법: 제이쿼리 이용 ////
	$("#p_userid", opener.document).val(p_userid);
	// 마찬가지로 부모창인 것을 명시해주어야 함. $("#부모창 input태그 id명", opner.document)

	// 패스워드 자리에 포커스 주기
	$("#p_pwd", opener.document).focus();
	
	// 팝업창 닫기
	self.close();

} // end of setp_userid----------
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
		frm.action = "/wetre/idCheckP.we";
		frm.submit();
	}
	
} // end of goCheck()------


</script>
</head>
<body>


<div align="center">
		 <c:if test="${isUseUserid == 0}">
			<div class="idcheck" >
				<br style="line-height: 200%"/>
				[<span class="idcheck" style='color: skyblue; font-weight: bold;'>${p_userid}</span>]는(은)<br/>아이디로 사용할 수 있습니다.<br/>
				<button type="button" class="idcheck_btn" onclick="setp_userid('${p_userid}')">닫기</button>
			</div>
		</c:if>

		<c:if test="${isUseUserid == 1}">
			<div class="idcheck" >
				<span class="idcheck">입력하신 아이디 [<span class="idcheck" style='color: skyblue; font-weight: bold;'>${p_userid}</span>]는(은)<br/>사용할 수 없습니다.</span>
				<br/><br/>
				<form name="frmIdcheck">
					<span class="idcheck">아이디를 입력하세요.</span><br style="line-height: 200%;"/><!-- line-height는 줄간격 말함. -->
					<input type="text" name="p_userid" id="p_userid" size="20" maxlength="20" class="idcheck_input" /><br style="line-height: 300%;"/>
					<span class="idcheck error">아이디를 입력하세요.</span><br/>
					<button type="button" class="idcheck_btn" onclick="goCheck();">확인</button>
				</form>
			</div>
		</c:if>
</div>
		
</body>
</html>