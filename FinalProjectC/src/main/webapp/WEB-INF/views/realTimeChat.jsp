<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Bootstrap CSS -->
	<script src="<%= request.getContextPath()%>/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/json2.js"></script>

<style type="text/css">
	#chatContainer{
		width: 380px;
		height: 500px;
		margin: 0 auto;
	}
	#chatMessage{
		overFlow: auto;
		width: 376px;
	    height: 440px;
	    max-height: 445px;
	    border: 1px solid #ff2f8b;
	    border-bottom: none;
	}
	#sendMessageArea{
		width: 378px;
	    border: none;
	    margin-top: -1px;
	}
	#message {
		width: 295px;
		border: 1px solid #ff2f8b;
		height: 38px;
		padding: 3px 3px;
	}
	#sendMessage {
		width: 75px;
	    border: none;
	    background: linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
	    color: white;
	    cursor: pointer;
	    font-weight: bold;
	    padding: 12.5px 0px 15px 0px;
	    margin-top: -1px;
	}
	.outOfChat {
		border: none;
	    padding: 2px 10px;
	    border-radius: 30px;
	    cursor: pointer;
	}
	*:focus {
    	outline: none;
	}
</style>

<script type="text/javascript" >

    $(document).ready(function(){
        
    	// 우선 웹소켓에 넣어줄 주소가 필요함.
        var url = window.location.host;
    	var pathname = window.location.pathname;
    	var appCtx = pathname.substring(0, pathname.lastIndexOf("/"));
    	var root = url+appCtx;
		var wsUrl = "ws://"+root+"/realTimeChatStart.we";
		
		// 만든 주소를 웹소켓을 만들면서 넣어줌.
		var websocket = new WebSocket(wsUrl);
	    // alert(wsUrl);
    	
    	var messageObj = {};
    	
	    // === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 ===
    	websocket.onopen = function() {

    		$("#chatMessage").text("소켓 연결 성공! 채팅 시작!");
            $("#chatMessage").append("<br/>");
            
            messageObj = { message : "채팅방에 <span style='color: red;'>입장</span>했습니다"
        		     	 , type : "all"
        		     	 , to : "all" };
        		     	
            websocket.send(JSON.stringify(messageObj));
        };
    	
    	// === 메시지 수신 콜백함수
        websocket.onmessage = function(evt) {
            $("#chatMessage").append(evt.data);
            $("#chatMessage").append("<br/>");
            $("#chatMessage").scrollTop(99999999);
        };
        
        // === 웹소캣 연결 해제 콜백함수
        websocket.onclose = function() {
            websocket.send("채팅을 종료합니다.");
        }
         
        
        $("#message").keydown(function (key) {
             if (key.keyCode == 13) {
                $("#sendMessage").click();
             }
        });
         
        $("#sendMessage").click(function() {
            if( $("#message").val() != "") {
                
            	// ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
                // 자바스크립트에서 replaceAll 은 없다.
                // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
                // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
                var messageVal = $("#message").val();
                messageVal = messageVal.replace(/<script/gi, "&lt;script");
            	
                messageObj = {};
                messageObj.message = messageVal;
                messageObj.type = "all";
                messageObj.to = "all";
                 
                websocket.send(JSON.stringify(messageObj));
                // JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환한다
                
                $("#chatMessage").append("<span style='color:navy; font-weight:bold;'>[나] ▷ " + messageVal + "</span><br/>");
                $("#chatMessage").scrollTop(99999999);
                 
                $("#message").val("");
            }
        });
    });
</script>
</head>
<body>
	<div id="chatContainer"><%--
	--%><div id='chatMessage'></div><%--
	--%><div id='sendMessageArea'><%--
	    --%><input type='text' id='message' placeholder='메시지 내용'/><input type='button' id='sendMessage' value='보내기' /></div><%--
	--%><%-- <input type='button' class='outOfChat' value='X' /> --%><%--
--%></div>
</body>
</html>