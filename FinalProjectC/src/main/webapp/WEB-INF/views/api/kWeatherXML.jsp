<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- trimDirectiveWhitespaces: true설정으로 공백이 있으면 지워줌. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:import url="http://www.kma.go.kr/XML/weather/sfc_web_map.xml" charEncoding="UTF-8"/>

<%-- - sk껀데 지역을 필수로 넣어줘야 해서 아직 안 씀.
		· <c:import url="https://api2.sktelecom.com/weather/current/hourly?version=1&lat=위도값&lon=경도값&appKey=내 고유 키값" charEncoding="UTF-8"/>
	 - 참조
	 	· https://openapi.sk.com/resource/apidoc/indexView
	 	· https://community.openapi.sk.com/t/api/7384
--%>