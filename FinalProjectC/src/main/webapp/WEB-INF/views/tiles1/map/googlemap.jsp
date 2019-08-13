<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#map_canvas {
    width: 500px;
    height: 500px;
}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&callback=initMap"></script>


<script type="text/javascript">
$(document).ready(function () {
    var map;
    var elevator;
    var myOptions = {
        zoom: 15,
        center: {lat: 37.566535, lng: 126.97796919999996},
        
        
    };
    map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
    var addresses = "경상북도 경주시 보문로 484-7";
    // console.log(${storemapList.size()});
    /* var addresses = ['거제시', '통영시', '김해시','남해군','창원시']; */

    
   
        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&sensor=false&address='+addresses, null, function (data) {
            var p = data.results[0].geometry.location
            var latlng = new google.maps.LatLng(p.lat, p.lng);
            new google.maps.Marker({
                position: latlng,
                map: map
            });

        });
    

});
</script>
</head>
<body>
<div id="map_canvas"></div>

</body>

</html>