<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

	
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>


<style type="text/css">

.dis{display: inline-block;}

#container {margin-left: 0px;width:500px;height:500px;}

ul#continents {margin:0px;
				list-style:none;
				width:340px;
				height:550px;
				position:relative;
				background:url('resources/img/map/map_korea_bg.png') no-repeat 0 0;
				float:left;}
ul#continents li {position:absolute;}

.incheon {width:61px;height:65px;top:98px;left:62px;}
.seoul {width:48px;height:44px;top:109px;left:108px;}
.gyunggi {width:115px;height:146px;top:61px;left:91px;}
.kangwon {width:186px;height:150px;top:38px;left:139px;}
.chungnam {width:129px;height:120px;top:179px;left:60px;}
.sejong {width:56px;height:50px;top:203px;left:119px;}
.daejeon {width:42px;height:47px;top:231px;left:143px;}
.chungbuk {width:116px;height:140px;top:154px;left:151px;}
.gyungbuk {width:153px;height:174px;top:162px;left:193px;}
.jeonbuk {width:130px;height:95px;top:269px;left:83px;}
.daegu {width:48px;height:49px;top:280px;left:234px;}
.jeonnam {width:178px;height:143px;top:333px;left:36px;}
.kwangju {width:48px;height:38px;top:354px;left:97px;}
.gyeongnam {width:145px;height:133px;top:286px;left:172px;}
.ulsan {width:52px;height:55px;top:301px;left:288px;}
.busan {width:77px;height:59px;top:341px;left:247px;}
.jeju {width:83px;height:51px;top:477px;left:56px;}

ul#continents li a {display:block;outline:none;height:100%;}
ul#continents li a {text-indent:-9000px;}
ul#continents li a:hover {background:url(resources/img/map/map_over.png) no-repeat 0 0;}

ul#continents li.incheon a:hover {background-position:-385px -47px;}
ul#continents li.kangwon a:hover {background-position:-8px -5px;}
ul#continents li.gyunggi a:hover {background-position:-199px -8px;}
ul#continents li.seoul a:hover {background-position:-326px -56px;}
ul#continents li.chungbuk a:hover {background-position:-451px -7px;}
ul#continents li.gyungbuk a:hover {background-position:-569px -4px;}
ul#continents li.sejong a:hover {background-position:-882px -45px;}
ul#continents li.chungnam a:hover {background-position:-725px -17px;}
ul#continents li.daejeon a:hover {background-position:-8px -187px;}
ul#continents li.daegu a:hover {background-position:-77px -177px;}
ul#continents li.jeonbuk a:hover {background-position:-149px -163px;}
ul#continents li.gyeongnam a:hover {background-position:-599px -186px;}
ul#continents li.ulsan a:hover {background-position:-773px -225px;}
ul#continents li.jeonnam a:hover {background-position:-384px -164px;}
ul#continents li.kwangju a:hover {background-position:-313px -197px;}
ul#continents li.jeju a:hover {background-position:-28px -330px;}
ul#continents li.busan a:hover {background-position:-860px -192px;}



td{
        width: 100px;
        height: 150px;
        text-align: center;
        font-size: 15px;
        font-family: 굴림;
        border:2px border-color:#006699;
        border-radius: 8px;/*모서리 둥글게*/ */
       	float:left;
       	font: 600 13px/30px "Roboto", sans-serif;
 }


#tblWSR >td {
		 width: 800px;
        height: 300px;
        text-align: left;
}

/* .noticeTbl > #noticeForecast {
		width:20px;height:20px;
		
} */
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#calendarLong").hide();  //장기예보테이블 숨김
		$("#calendarShort").hide(); //단기예보테이블 숨김
		$("#calendarWSR").hide();	//특보테이블 숨김
		
		console.log($("#forecastType").val());
		
		$(".region").click(function(){
			if($("#forecastType").val() == null || $("#forecastType").val() =="") {
				//선택옵션의 값이 null이거나 공백이면 알림이 뜨게함
				alert("예보종류를 선택하세요!");
				
			}
			
			else{
				
				  var lat = "";
		          var lon = "";
		          var datasky ="";
		 	  
		    	  
		    	  lat = $(this).attr("lat"); 
		    	  lon = $(this).attr("lon"); 
		   		
		      /* 	  lon = $(this).attr("v");  */
		 
		      datasky = {"lat":lat,"lon":lon};
				
		     	 
				
				if($("#forecastType").val() == 2) {  //장기예보선택  --> 단기와 특보는 있으면 안됨
					
					
					 $("#tblSeven>*").remove(); //장기예보날짜별로 보여주는tr아래의 td를 다 지움
					 
					 
					$("#calendarShort").hide(); //단기예보테이블을 지움
					
					$("#calendarWSR").hide(); //특보의테이블을 지움
					 
			      	$.ajax({
						url: "https://apis.openapi.sk.com/weather/forecast/6days?lat="+lat+"&lon="+lon+"&appKey=7e1ce176-e53f-4289-aadc-a4efbef3f474",  
						type: "GET",
						dataType: "json",//정해진 형식대로 써야하는거고 제이슨 쥐슨 xml이런것만 쓸 것
						success: function(json){ //괄호안에 변수는 내맘대로지만 헷갈리지않기위해서 같은 이름 씀
							
							var weather = json.weather;
							var forecastArray = weather.forecast6days;
							
					
						
							var tempMax = ""; 
							var tempMin = ""; 
							var skyStatus = "";
							
							 $.each(forecastArray, function(index, item){
								var haneul = item.temperature;
								var haneul0 = item.sky;
		
									  
									  tempMax= haneul.tmax3day;
									  tempMin= haneul.tmin3day; 
									  skyStatus= haneul0.pmName3day;
									  sevenCalendar(3, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax4day;
									  tempMin= haneul.tmin4day; 
									  skyStatus= haneul0.pmName4day;
									  sevenCalendar(4, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax5day;
									  tempMin= haneul.tmin5day; 
									  skyStatus= haneul0.pmName5day;
									  sevenCalendar(5, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax6day;
									  tempMin= haneul.tmin6day; 
									  skyStatus= haneul0.pmName6day;
									  sevenCalendar(6, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax7day;
									  tempMin= haneul.tmin7day; 
									  skyStatus= haneul0.pmName7day;
									  sevenCalendar(7, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax8day;
									  tempMin= haneul.tmin8day; 
									  skyStatus= haneul0.pmName8day;
									  sevenCalendar(8, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax9day;
									  tempMin= haneul.tmin9day; 
									  skyStatus= haneul0.pmName9day;
									  sevenCalendar(9, tempMax,tempMin,skyStatus);
									  
									  tempMax= haneul.tmax10day;
									  tempMin= haneul.tmin10day; 
									  skyStatus= haneul0.pmName10day;
									  sevenCalendar(10, tempMax,tempMin,skyStatus);
									
								}); 
							
					},
					error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
			         
		     });// end of ajax Long-------------------
			     
			      	$("#calendarLong").show();  //장기예보를 선택햇으니 데이터를 받아와서 장기예보 테이블을 보여줌
			     
				}// end of if(val=2)
				
				else if($("#forecastType").val() == 1){  //단기예보선택  -->장기랑 특보있으면 안됨
					
					$("#tbl25Hr>*").remove();  //단기예보의 시간별로 보여주는 tr의 td를 모두 지움
										 
					 
					$("#calendarLong").hide();  //장기예보테이블을지움
					
					$("#calendarWSR").hide();  // 특보테이블을 지움
					
					$.ajax({
						url: "https://apis.openapi.sk.com/weather/forecast/3days?lat="+lat+"&lon="+lon+"&appKey=7e1ce176-e53f-4289-aadc-a4efbef3f474",  
						type: "GET",
						dataType: "json",//정해진 형식대로 써야하는거고 제이슨 쥐슨 xml이런것만 쓸 것
						success: function(json){ //괄호안에 변수는 내맘대로지만 헷갈리지않기위해서 같은 이름 씀
							
							var weather = json.weather;
							var forecastArray = weather.forecast3days;
						
							var tempXHour = ""; 
							var rainProb = ""; 
							var SskyStatus = "";
							
							 $.each(forecastArray, function(index, item){
								var fcst3hour = item.fcst3hour; // forecastArray[n].fcst3hour
								var timeRelease = item.timeRelease;
								var haneul1 = fcst3hour.temperature; // forecastArray[n].fcst3hour.temperature
								var haneul2 = fcst3hour.precipitation;
								var haneul3 = fcst3hour.sky;
										
									  
									  tempXHour= haneul1.temp4hour;
									  rainProb= haneul2.prob4hour; 
									  SskyStatus= haneul3.name4hour;
									  hour25Calendar( timeRelease, tempXHour,rainProb,SskyStatus);
								
									  
									  tempXHour= haneul1.temp7hour;
									  rainProb= haneul2.prob7hour; 
									  SskyStatus= haneul3.name7hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									  
									  tempXHour= haneul1.temp10hour;
									  rainProb= haneul2.prob10hour; 
									  SskyStatus= haneul3.name10hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									  
									  tempXHour= haneul1.temp13hour;
									  rainProb= haneul2.prob13hour; 
									  SskyStatus= haneul3.name13hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									  
									  tempXHour= haneul1.temp16hour;
									  rainProb= haneul2.prob16hour; 
									  SskyStatus= haneul3.name16hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									  
									  tempXHour= haneul1.temp19hour;
									  rainProb= haneul2.prob19hour; 
									  SskyStatus= haneul3.name19hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									  
									  tempXHour= haneul1.temp22hour;
									  rainProb= haneul2.prob22hour; 
									  SskyStatus= haneul3.name22hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									  
									  tempXHour= haneul1.temp25hour;
									  rainProb= haneul2.prob25hour; 
									  SskyStatus= haneul3.name25hour;
									  hour25Calendar(timeRelease, tempXHour,rainProb,SskyStatus);
									
								}); 
							
					},
					error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
			         
		         
			     });// end of ajax Short-------------------
			     
					$("#calendarShort").show();  //단기예보를 클릭햇으니 단기예보데이터를 받아와서 단기테이블을 보여줌
			     
				}//end of else if( val ==1)
				
				else{//(val ==3)  // 기상특보를 선택했을 경우 --> 장기와 단기예보가 있으면 안됨
					
				
					 $("#tblWSR>*").remove();  // 특보의 내용을 보여주는 tr의 td를 다 지움
					 
					$("#calendarShort").hide(); //단기예보테이블을 지움
					$("#calendarLong").hide();  //장기예보테이블을지움
					
					
					$.ajax({
						url: "https://apis.openapi.sk.com/weather/severe/alert?lat="+lat+"&lon="+lon+"&appKey=7e1ce176-e53f-4289-aadc-a4efbef3f474",  
						type: "GET",
						dataType: "json",//정해진 형식대로 써야하는거고 제이슨 쥐슨 xml이런것만 쓸 것
						success: function(json){ //괄호안에 변수는 내맘대로지만 헷갈리지않기위해서 같은 이름 씀
							
							var weather = json.weather;
							var alertArray = weather.alert;
						
							
							var tOne="";
							var tTwo="";
							var tFour="";
							
							 $.each(alertArray, function(index, item){
								var timeRelease=item.timeRelease;
								var tStart=item.timeStart;
								var tEnd=item.timeEnd;
								
								var alert60 = item.alert60; // alertArray[n].alert60
								
								var t1 = alert60.t1; 
								var t2 = alert60.t2; 
								var t4 = alert60.t4;
						
								  weatherSR(timeRelease, tStart,tEnd,t1, t2, t4);
								}); 
							
					},
					error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
			         
			         
			     });// end of ajax WSR-------------------
			     
					 $("#calendarWSR").show();  // 특보를 선택햇으니 특보데이터를 받아와서 특보테이블을 보여줌
				}//end of else{val ==3}
				
			}//end of else(셀렉트옵션 값있을때)
		 });//end of click .region 이벤트임
		
		
		
		
	}); // document ready ---------------		
		
	
      function sevenCalendar(i, tempMax, tempMin, skyStatus) {
    	  
    	  var today = new Date();
    	  var object = new Date;
    	  var tbLCalendarYM = document.getElementById("tbLCalendarYM");
    	  tbLCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월";
    	  var row = document.getElementById("tblSeven");
    	  var x = "";
    	  
    	    x = row.insertCell();

    	    var numToday = String(today.getYear()+1900)+"-"
    	    			 + String(today.getMonth()+1)+"-"
    	                 + String(today.getDate());
    	    console.log(numToday);
    	    var week = ['(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)'];
    		var dayOfWeek = week[new Date(numToday).getDay()];
    		x.innerHTML =String(today.getDate()+i) + dayOfWeek + "<br/>"+"최고T :" + tempMax + "°C"+"<br/>"+"최저T :"+ tempMin + "°C" +"<br/>"+ "상태 : " + skyStatus;
    	
     	}
	
	
	
 function hour25Calendar(timeRelease, tempXHour, rainProb, SskyStatus) {
    	  
    	  var today = new Date();
    	  var tbSCalendarYMD = document.getElementById("tbSCalendarYMD");
    	  tbSCalendarYMD.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월" + today.getDate() + "일" +timeRelease;
    	  var row = document.getElementById("tbl25Hr");
    	  var x = "";
    	  
    	    x = row.insertCell();

    	    var numToday = String(today.getYear()+1900)+"-"
    	    			 + String(today.getMonth()+1)+"-"
    	                 + String(today.getDate());
    	    
    	    var week = ['(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)'];
    		var dayOfWeek = week[new Date(numToday).getDay()];
    		x.innerHTML =String(today.getDate()) + dayOfWeek +  "<br/>"+"온도 :" + tempXHour + "°C"+"<br/>"+"강수% :"+ rainProb + "%" +"<br/>"+ "상태 : " + SskyStatus;
    	
     	}
	
 
	function  weatherSR(timeRelease, tStart,tEnd,t1, t2, t4) {
	  var today = new Date();
   	  var tbWSRCalendarYMD = document.getElementById("tbWSRCalendarYMD");
   	  tbWSRCalendarYMD.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월" + today.getDate() + "일";
   	  
   	  var row = document.getElementById("tblWSR");
   	  var x = "";
   	  
   	 
   	    x = row.insertCell();

   	    var numToday = String(today.getYear()+1900)+"-"
   	    			 + String(today.getMonth()+1)+"-"
   	                 + String(today.getDate());
   	    
   	    var week = ['(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)'];
   		var dayOfWeek = week[new Date(numToday).getDay()];
   		x.innerHTML =String(today.getDate()) + dayOfWeek + "<br/>"+ "<br/>"+"발표시간:" + timeRelease + "<br/>"+ "<br/>"+"발효시간 :"+ tStart + "<br/>"+"<br/>"+ "발표해제시간 : " + tEnd + 
   					"<br/>"+"<br/>"+ "제목 : "+t1 + "<br/>"+"<br/>"+"해당구역:" + t2 + "<br/>"+"<br/>"+"내용:" + t4;
	}
      
</script>

<body style="background-color:#e6f7ff;">

<div style="margin: 100px 200px; height: 1000px;">
<div class="forecastType" style="border:#006699 3px solid; border-radius: 10px; text-align:center; width: 140px; height: 8.7%;display:block;">
	<h5 style="font: 'Roboto', sans-serif;">지상날씨</h5>
	<div class="forecastTyleslctDIV" style="float: none; width: 98%; margin-left: 1%; margin-top: 1%;">
	<select  title="forecastType" id="forecastType" name="forecastType" class="forecastTypeSlct" style="width:100%; height:42px; font: 200 20px/30px 'Roboto', sans-serif;">
		<option value="" style="font: 200 20px/30px 'Roboto', sans-serif; text-align: center;" selected disabled>----예보선택---</option>
		<option value="1" style="font: 200 20px/30px 'Roboto', sans-serif; text-align: center;">----단기예보---</option>
		<option value="2" style="font: 200 20px/30px 'Roboto', sans-serif; text-align: center;">----장기예보---</option>                       
		<option value="3" style="font: 200 20px/30px 'Roboto', sans-serif; text-align: center;">----기상특보---</option>
	</select>
	</div>	
</div>
									
<div id="container" style=" display: inline; ">
	<ul id="continents">
	  <li class="incheon"><a class="region" target="_self" lat="37.47772" lon="126.6249"></a></li>
	  <li class="kangwon"><a  class="region" target="_self" lat="37.6836" lon="127.88043"></a></li>
	  <li class="gyunggi"><a class="region" target="_self" lat="37.48863" lon="127.49446"></a></li>
	  <li class="chungnam"><a class="region" target="_self" lat="36.77658" lon="126.4939"></a></li>
	  <li class="sejong"><a class="region" target="_self" lat="36.63924" lon="127.44066"></a></li>
	  <li class="chungbuk"><a class="region" target="_self" lat="37.15928" lon="128.19434"></a></li>
	  <li class="daejeon"><a class="region" target="_self" lat="36.37198" lon="127.37211"></a></li>
	  <li class="gyeongnam"><a class="region" target="_self" lat="34.84546" lon="128.4356"></a></li>
	  <li class="gyungbuk"><a class="region" target="_self" lat="36.57293" lon="128.70734"></a></li>
	  <li class="daegu"><a class="region" target="_self" lat="35.87797" lon="128.65295"></a></li>
	  <li class="jeonbuk"><a class="region" target="_self" lat="35.8408" lon="127.119"></a></li>
	  <li class="jeonnam"><a class="region" target="_self" lat="34.81689" lon="126.38121"></a></li>
	  <li class="kwangju"><a class="region" target="_self" lat="35.17294" lon="126.89158"></a></li>
	  <li class="ulsan"><a class="region" target="_self" lat="35.5825" lon="129.33472"></a></li>
	  <li class="jeju"><a class="region" target="_self" lat="33.24616" lon="126.5653"></a></li>
	  <li class="busan"><a class="region" target="_self" lat="35.10468" lon="129.03203"></a></li>
	  <li class="seoul"><a class="region" target="_self" lat="37.57142" lon="126.9658"></a></li>
	</ul>
</div>

<div>
	<table id="noticeTbl" border="3" align="center">
    <tr class="noticeTbl" style="width: 640px;"><!-- label은 마우스로 클릭을 편하게 해줌 -->
        <td align="center" class="noticeForecast" colspan="2" style=" width: 80px;height: 60px;font-weight: bold;">단기예보</td>
        <td class="notiFCContente" style="width: 530px;height: 60px;">단기예보는 발표시간을 기준으로 4시간마다의 예보를 보여주며 +25시간까지 나타냅니다 </td>
    </tr>
    <tr class="noticeTbl">
    	<td align="center" class="noticeForecast" colspan="2" style=" width: 80px;height: 60px;font-weight: bold;">단기예보</td> 
     	<td class="notiFCContente" style="width: 530px;height: 60px;">장기예보는 발표시간을 기준으로 3일후부터 일주일간의 날씨를 나타냅니다 </td>
     </tr>
     <tr class="noticeTbl">
    	<td align="center" class="noticeForecast" colspan="2" style=" width: 80px;height: 60px;font-weight: bold;">기상특보</td> 
     	<td class="notiFCContente" style="width: 530px;height: 60px;">기상특보는 선택한 지역에서 발효된 기상특보를 나타냅니다 </td>
     </tr>
	</table>
</div>

<div style="border-color:#006699; margin-top: 30px">
	<table id="calendarLong" border="3" align="center">
    <tr class="tbLCalendarYM"><!-- label은 마우스로 클릭을 편하게 해줌 -->
        <td align="center" id="tbLCalendarYM" colspan="8" style="height:30px; font-weight: bold;">
        yyyy년 m월</td>
    </tr>
    <tr id=tblSeven>
    </tr>  
	</table>
</div>

<div style="border-color:#006699; margin-top: 30px">	
	<table id="calendarShort" border="3" align="center">
    <tr class="tbSCalendarYMD" ><!-- label은 마우스로 클릭을 편하게 해줌 -->
        <td align="center" id="tbSCalendarYMD" colspan="8" style="height:30px; font-weight: bold;">
        yyyy년 m월 d일</td>
    </tr>
    <tr id=tbl25Hr>
    </tr>  
	</table>
</div>

<div style="border-color:#006699; margin-top: 30px">	
	<table id="calendarWSR" border="3" align="center">
    <tr class="tbWSRCalendarYMD"><!-- label은 마우스로 클릭을 편하게 해줌 -->
        <td align="center" id="tbWSRCalendarYMD" colspan="1" style="height:30px; font-weight: bold;">
        yyyy년 m월 d일</td>
    </tr>
    <tr id=tblWSR>
    </tr>  
	</table>
</div>

</div>

</body>