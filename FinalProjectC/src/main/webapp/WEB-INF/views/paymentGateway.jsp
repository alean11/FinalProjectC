<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

$(document).ready(function() {

	var contactInfo = '${contactInfo}';
	var email = "";
	var hp = "";
	
	if(contactInfo.indexOf("@") == 1)
		email = contactInfo;
	else
		hp = contactInfo;

	
	var IMP = window.IMP;
	IMP.init('imp77089428');

	IMP.request_pay({
		pg : 'html5_inicis',
		pay_method : '${payMethod}',
		merchant_uid : 'merchant_' + new Date().getTime(),
		name : '결제테스트',
		amount : '${cart_price}',
		buyer_email : email,
		buyer_name : '${p_name}',
		buyer_tel : hp,
		m_redirect_url : '<%= request.getContextPath()%>/index.we'
	}, function(rsp) {
		if ( rsp.success ) {		
			goReserveInsert();
		} else {
			alert("결제에 실패했어..");
			self.close();
		}
	}); // end of IMP.request_pay()----------------------------

}); // end of $(document).ready()-----------------------------

	function goReserveInsert() {
	
		var form_data = $("form[name=reserveInfoFrm]").serialize();
	
		$.ajax({
			url: "<%= request.getContextPath()%>/reserveInsert.we",
			type: "POST",
			data: form_data,
			dataType: "JSON",
			success: function(json){
				alert(json.msg);
				window.opener.top.location.href="<%= request.getContextPath()%>/index.we";
				window.close();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax --------
		
	} // end of 폼 제출 후 DB 저장하고 팝업창 닫는 함수 -------

</script>
</head>	

<body>
	<form name="reserveInfoFrm" >
		<input type="hidden" name="p_userid" value="${p_userid}"/>
		<input type="hidden" name="p_name" value="${p_name}"/>
		<input type="hidden" name="fk_acc_name" value="${fk_acc_name}"/>
		<input type="hidden" name="fk_rtype_name" value="${fk_rtype_name}"/>
		<input type="hidden" name="cart_cnt" value="${cart_cnt}"/>
		<input type="hidden" name="full_acc_addr" value="${full_acc_addr}"/>
		<input type="hidden" name="full_acc_tel" value="${full_acc_tel}"/>
		<input type="hidden" name="r_idx" value="${r_idx}"/>
		<input type="hidden" name="rtype_idx" value="${rtype_idx}"/>
		<input type="hidden" name="book_start" value="${book_start}"/>
		<input type="hidden" name="book_end" value="${book_end}"/>
		<input type="hidden" name="reserver" value="${reserver}"/>
		<input type="hidden" name="contactInfo" value="${contactInfo}"/>
		<input type="hidden" name="cart_price" value="${cart_price}"/>
		<input type="hidden" name="requestTxt" value="${requestTxt}"/>
		<input type="hidden" name="expectedTime" value="${expectedTime}"/>
		<input type="hidden" name="payMethod" value="${payMethod}"/>
		<input type="hidden" name="adultNum" value="${adultNum}"/>
		<input type="hidden" name="kidsNum" value="${kidsNum}"/>
	</form>
</body>
</html>
