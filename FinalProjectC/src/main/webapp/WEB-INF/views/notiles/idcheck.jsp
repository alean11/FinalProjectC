<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%	String ctxPath = request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 검사 팝업창</title>

<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
var cp_id = "";
	$(document).ready(function(){
		$(".idcheckB").hide();
		$("#cp_id").focus();
		
		$("#cp_id").keydown(function(event){
			if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우에도 아이디 중복검사
				goCheck();
			}
		});
		
	}); // end of ready-------
	
	
	function goCheck() {
		cp_id = $("#cp_id").val().trim();
		var userData = { "cp_id" : cp_id}
		if(cp_id == ""){
			alert("아이디를 입력해주세요.");
		}
		else{
			$.ajax({
				type : "GET",
				url : "idCheckEnd.we",
				data : userData,
				success : function (result) {
					if(result){
						$(".idcheckA").hide();
						$(".idcheckB").show();
						var cp_id = $("#cp_id").val();
						$(".cp_id").text(cp_id);
					}
					else{
						alert("이미 사용중인 아이디입니다. \n 다시 입력해 주세요.")
					}
					
				}
			});
		}
		
	} // end of goCheck()------

	
	function setcp_id() {

		//// 팝업창에서 부모창으로 값 넘기는 방법: 제이쿼리 이용 ////
		$("#cp_id", opener.document).val(cp_id);
		// 마찬가지로 부모창인 것을 명시해주어야 함. $("#부모창 input태그 id명", opner.document)

		// 패스워드 자리에 포커스 주기
		$("#cp_pwd", opener.document).focus();
		
		// 팝업창 닫기
		self.close();

	} // end of setcp_id----------
	
	

</script>
</head>
<body>
<div align="center" style="margin-top: 50px;">


	<div class="idcheckA">
		<span class="idcheck">아이디를 입력하세요.</span><br style="line-height: 200%;" />
		<!-- line-height는 줄간격 말함. -->
		<input type="text" name="cp_id" id="cp_id" class="idcheck_input"
			size="20" maxlength="20" /><br style="line-height: 300%;" />
		<button type="button" class="idcheck_btn" onclick="goCheck();">확인</button>
	</div>
		<div class="idcheckB">
			<br style="line-height: 200%" /> [<span class="idcheck cp_id" style='color: skyblue; font-weight: bold;'>${cp_id}</span>]는(은)<br />아이디로사용할 수 있습니다.<br />
			<button type="button" class="idcheck_btn" onclick="setcp_id()">닫기</button>
		</div>
</div>


</body>
</html>