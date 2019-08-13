package com.spring.wetre.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.wetre.model.*;


// === #177. (웹채팅관련8) === 

public class WebsocketEchoHandler extends TextWebSocketHandler {

		// === 웹소켓서버에 연결한 클라이언트 사용자들을 저장하는 리스트 ===
		private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
		
	    @Override
	    public void afterConnectionEstablished(WebSocketSession wsession)
	    	throws Exception {
	    	// >>> 파라미터 WebSocketSession wsession 은  웹소켓서버에 접속한 클라이언트 사용자임. <<<
	    	
	    	connectedUsers.add(wsession);
	 
	        System.out.println("====> 웹채팅확인용 : " + wsession.getId() + "님이 접속했습니다.");
	        
	        System.out.println("====> 웹채팅확인용 : " + "연결 컴퓨터명 : " + wsession.getRemoteAddress().getHostName());
	        System.out.println("====> 웹채팅확인용 : " + "연결 컴퓨터명 : " + wsession.getRemoteAddress().getAddress().getHostName());
	        System.out.println("====> 웹채팅확인용 : " + "연결 IP : " + wsession.getRemoteAddress().getAddress().getHostAddress()); 
	    }
	 
	    
	    @Override
	    protected void handleTextMessage(WebSocketSession wsession, TextMessage message) 
	    	throws Exception {
	    	
	    	Map<String, Object> map = wsession.getAttributes();
	    	PersonalVO loginuser = (PersonalVO)map.get("loginuser");  // "loginuser" 은 HttpSession에 저장된 키 값이다.
    	
	        MessageVO messageVO = MessageVO.convertMessage(message.getPayload());
	        
	        String hostAddress = "";
	 
	        for (WebSocketSession webSocketSession : connectedUsers) {
	            if (messageVO.getType().equals("all")) { // 채팅할 대상이 "전체" 일 경우 
	                if (!wsession.getId().equals(webSocketSession.getId())) {
                		if( loginuser != null && !"".equals(loginuser.getP_userid())) {
                			webSocketSession.sendMessage(new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [" +loginuser.getP_userid()+ "]" + " ▶ " + messageVO.getMessage()));  
                		}
                		else {
                			webSocketSession.sendMessage(new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [" +wsession.getId()+ "]" + " ▶ " + messageVO.getMessage()));
                		}
	                }
	            } else { // 특정 대상
	            	hostAddress = webSocketSession.getRemoteAddress().getAddress().getHostAddress();
	                if (messageVO.getTo().equals(hostAddress)) {
	                	if( loginuser != null && !"".equals(loginuser.getP_userid())) {
			                    webSocketSession.sendMessage(
			                    			new TextMessage(
			                    					"<span style='color:red; font-weight: bold;' >"
			                    							+ wsession.getRemoteAddress().getAddress().getHostAddress() +" [" +loginuser.getP_userid()+ "]" + "▶ " + messageVO.getMessage()
			                    							+ "</span>") );
                   		}
	                	else {
	                		webSocketSession.sendMessage(
	                				new TextMessage(
	                						"<span style='color:red; font-weight: bold;' >"
	                								+ wsession.getRemoteAddress().getAddress().getHostAddress() +" [" +wsession.getId()+ "]" + "▶ " + messageVO.getMessage()
	                								+ "</span>") );
	                	}
	                    break;
	                }
	            }
	        }
	 
	        
	        System.out.println("====> 웹채팅확인용 : 웹세션ID " + wsession.getId() + "의 메시지 : " + message.getPayload() );
	        // ====> 웹채팅확인용 : 웹세션ID 23의 메시지 : {"message":"채팅방에 <span style='color: red;'>입장</span>했습니다","type":"all","to":"all"}
	    }
	 

	    @Override
	    public void afterConnectionClosed(WebSocketSession wsession, CloseStatus status) 
	    	throws Exception {
	    	
	    	Map<String, Object> map = wsession.getAttributes();
	    	PersonalVO loginuser = (PersonalVO)map.get("loginuser");
	    	
	    	connectedUsers.remove(wsession);
	   	 
	        for (WebSocketSession webSocketSession : connectedUsers) {
	            if (!wsession.getId().equals(webSocketSession.getId())) {
	            	
	            	if(loginuser != null) {
	            		webSocketSession.sendMessage(new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [" +loginuser.getP_userid()+ "]" + "님이 <span style='color: red;'>퇴장</span>했습니다.")); 
	            	}
	            	else {
	            		webSocketSession.sendMessage(new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [" +wsession.getId()+ "]" + "님이 <span style='color: red;'>퇴장</span>했습니다.")); 
	            	}
	            }
	        }
	       
	        System.out.println("====> 웹채팅확인용 : 웹세션ID " + wsession.getId() + "이 퇴장했습니다.");
	    }
	    
	    
		// init-method(@PostConstruct)
		public void init() throws Exception {		}	    
	
}
