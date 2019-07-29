<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/wetre/resources/js/jquery-3.2.1.min.js"></script>
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

function setcp_id(cp_id) {

	//// 팝업창에서 부모창으로 값 넘기는 방법: 제이쿼리 이용 ////
	$("#cp_id", opener.document).val(cp_id);
	// 마찬가지로 부모창인 것을 명시해주어야 함. $("#부모창 input태그 id명", opner.document)

	// 패스워드 자리에 포커스 주기
	$("#cp_pwd", opener.document).focus();
	
	// 팝업창 닫기
	self.close();

} // end of setcp_id----------
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

		 <c:if test="${isUseUserid == 0}">
			<div class="idcheck" >
				<br style="line-height: 200%"/>
				[<span class="idcheck" style='color: skyblue; font-weight: bold;'>${cp_id}</span>]는(은)<br/>아이디로 사용할 수 있습니다.<br/>
				<button type="button" class="idcheck_btn" onclick="setcp_id('${cp_id}')">닫기</button>
			</div>
		</c:if>

		<c:if test="${isUseUserid == 1}">
			<div class="idcheck" >
				<span class="idcheck">입력하신 아이디 [<span class="idcheck" style='color: skyblue; font-weight: bold;'>${cp_id}</span>]는(은)<br/>사용할 수 없습니다.</span>
				<br/><br/>
				<form name="frmIdcheck">
					<span class="idcheck">아이디를 입력하세요.</span><br style="line-height: 200%;"/><!-- line-height는 줄간격 말함. -->
					<input type="text" name="cp_id" id="cp_id" size="20" maxlength="20" class="idcheck_input" /><br style="line-height: 300%;"/>
					<span class="idcheck error">아이디를 입력하세요.</span><br/>
					<button type="button" class="idcheck_btn" onclick="goCheck();">확인</button>
				</form>
			</div>
		</c:if>
		
</body>
</html>