<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>

<head>

	<!-- Required meta tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" href="<%= ctxPath%>/resources/img/favicon.png" type="image/png">
	<title>Wetre</title>

	<!-- Bootstrap CSS -->
	<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/bootstrap.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/vendors/linericon/style.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/vendors/owl-carousel/owl.carousel.min.css">
    <link rel="stylesheet" href="<%= ctxPath%>/resources/vendors/nice-select/css/nice-select.css">
	
	<!-- main css -->
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style.css">
	
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>

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



#tblSeven > td{
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

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#calendar").hide();
		
		$(".region").click(function(){
			$("#calendar").show();
		});
		
		$(".setRoomOptions_select").hide();
		
		$("#btnSearch").click(function(){
			goSearch();
		});
		
		
		$("#setRoomOptions selectId").click(function(){
			$("#roomPersonview").show();
		});
		
		
		$(".srp_selectAdult").change(function(){
			console.log($(".srp_selectAdult").val());
			$("#srp_adult").text($(".srp_selectAdult").val());
		}); // end of 성인 셀렉트 클릭 -------------
		
		
		$(".srp_selectChilid").change(function(){
			console.log($(".srp_selectChilid").val());
			$("#srp_child").text($(".srp_selectChilid").val());
		}); // end of 성인 셀렉트 클릭 -------------
		
		
		$("#set_room_Person").click(function(){
					
			$(".setRoomOptions_select").toggle();
		});
		

		  $('input[name="book_start"], input[name="book_end"]').daterangepicker({
		      autoUpdateInput: false,
		      locale: {
		          cancelLabel: 'Clear'
		      }
		  });

		  $('input[name="book_start"], input[name="book_end"]').on('apply.daterangepicker', function(ev, picker) {
		      $("#startDate").val(picker.startDate.format('YYYY-MM-DD'))
		      $("#endDate").val(picker.endDate.format('YYYY-MM-DD'))      
		  });

		  $('input[name="book_start"], input[name="book_end"]').on('cancel.daterangepicker', function(ev, picker) {
			  $("#startDate").val('');
			  $("#endDate").val('');
		  });
		  
		  /* var day = $("#calendar").children("td").val();
		  
		  console.log(day); */
		
		    
		  
		     $(".region").click(function () {
		    	  $("#tblSeven>*").remove();
		    	  var lat = "";
		          var lon = "";
		          var datasky ="";
		 	  
		    	  
		    	  lat = $(this).attr("lat"); 
		    	  lon = $(this).attr("lon"); 
		   			console.log(lat);
		   			console.log(lon);
		   		
		      /* 	  lon = $(this).attr("v");  */
		 
		      datasky = {"lat":lat,"lon":lon};
		      
		      	$.ajax({
		      		//url에 내가 sk에서 임포트 해온주소를 써도 된다.그때는 실수가 있으면 안됨.
					url: "https://apis.openapi.sk.com/weather/forecast/6days?lat="+lat+"&lon="+lon+"&appKey=7e1ce176-e53f-4289-aadc-a4efbef3f474",  
					type: "GET",
					/* data: datasky,  */// 중부지방   //데이터는 보내긴해야하지만 지금은 안쓸거니까 주석처리
					dataType: "json",//정해진 형식대로 써야하는거고 제이슨 쥐슨 xml이런것만 쓸 것
					success: function(json){ //괄호안에 변수는 내맘대로지만 헷갈리지않기위해서 같은 이름 씀
						
						var weather = json.weather;
						var forecastArray = weather.forecast6days;
						
						/* for(var i=0; i<forecastArray.length; i++) {
							
							var haneul = forecastArray[i].sky;
							console.log(haneul.amCode2day);
						} */
					
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
		         
		     });// end of ajax-------------------
		});// end of click------------------
		
		
		
		/// 검색바 관련 ///
		$("#headerSearchBarBtn").click(function(){
			goAccList();
		}); // end of 검색바 click ------
				
	    $("#headerSearchBarBtn").keydown(function(event){
			if(event.keyCode == 13) { // 엔터를 했을 경우
				goAccList();
			}
		}); // end of 검색바 엔터 ----------------------
		
		
		
	}); // document ready ---------------		
	
	
	// 검색바 관련
	function goAccList() {
		var frm = document.searchBarFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/accommodation/accList.we";
		frm.submit();
	} // end of 통합검색 ---------------

	
	
	function goSearch()  {
		
		var frm = document.searchFrm;
		frm.method="GET";
		frm.action="<%= request.getContextPath()%>/accommodation/accList.we";
		frm.submit();
	}
     
      function sevenCalendar(i, tempMax, tempMin, skyStatus) {
    	  
    	  var today = new Date();
    	  var tbCalendarYM = document.getElementById("tbCalendarYM");
    	  tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월";
    	  var row = document.getElementById("tblSeven");
    	  var x = "";
    	  
    	    x = row.insertCell();

    	    var numToday = String(today.getYear()+1900)+"-"
    	    			 + String(today.getMonth()+1)+"-"
    	                 + String(today.getDate()+i);
    	    console.log(numToday);
    	    var week = ['(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)'];
    		var dayOfWeek = week[new Date(numToday).getDay()];
    		x.innerHTML =String(today.getDate()+i) + dayOfWeek + "<br/>"+"최고T :" + tempMax + "°C"+"<br/>"+"최저T :"+ tempMin + "°C" +"<br/>"+ "상태 : " + skyStatus;
     	}
      
          

  	 
</script>



<body style="background-color:#e6f7ff; color:#333399;">

    <!--================ Start Header Menu Area =================-->
	<header class="header_area">
		<div class="main_menu">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<a class="navbar-brand logo_h" href="<%= ctxPath%>/index.we"><img src="<%= ctxPath%>/resources/img/WETRE_LOGO_re2.png" alt="Wetre"></a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse offset" id="navbarSupportedContent">
						<ul class="nav navbar-nav menu_nav ml-auto">
							<li class="nav-item">
								<a class="nav-link" href="<%= ctxPath%>/index.we">Home</a>
							</li>
							<li class="nav-item">
								<a href="<%= ctxPath%>/foreCastSL.we" class="nav-link dropdown-toggle">Weather</a>
							</li>
							<li class="nav-item submenu dropdown">
								<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
								 aria-expanded="false">Accommodation</a>
								<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/accommodation/accList.we">Accommodation</a></li>
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/map.we">Map</a></li>
								</ul>
							</li>
							<li class="nav-item submenu dropdown">
								<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
								 aria-expanded="false">Board</a>
								<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/noticeList.we">Notice</a></li>
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/qnaList.we">Q & A</a></li>
								</ul>
							</li>
							<li class="nav-item submenu dropdown active">
								<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
								 aria-expanded="false">Wetre</a>
								<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/aboutus.we">About us</a></li>
									<li class="nav-item"><a class="nav-link" href="#">MBoard</a></li>
									<li class="nav-item"><a class="nav-link" href="#">YBoard</a></li>
									<li class="nav-item"><a class="nav-link" href="#">JBoard</a></li>
									<li class="nav-item"><a class="nav-link" href="#">GBoard</a></li>
									<li class="nav-item"><a class="nav-link" href="#">HBoard</a></li>
								</ul>
							</li>
						</ul>
						<ul class="nav navbar-nav ml-auto">
							<li class="nav-item submenu dropdown">
<%-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 로그인 후 보이는 메뉴에서 조건식은 원하는대로 설정할 것. --%>
								<c:if test="${sessionScope.loginuser == null && sessionScope.companyuser == null}">
								<a href="#" class="primary-btn dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
								 aria-expanded="false">Sign In</a>
								<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/privateLogin.we">Personal</a></li>
									<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/companyLogin.we">Company</a></li>
								</ul>
								</c:if>
								<c:if test="${sessionScope.loginuser != null && sessionScope.companyuser == null}">
									<a href="<%= ctxPath%>/privateLogout.we" class="primary-btn" style="margin-right: 20px;">Logout</a>
									<a href="#" class="primary-btn">${sessionScope.loginuser.p_name}</a>
									<ul class="dropdown-menu">
										<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/personalEdit.we">정보수정</a></li>
										<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/myPage.we">예약확인</a></li>
									</ul>
									<%-- 예약 내역 페이지는 여기서 해야 --%>
								</c:if>
								<c:if test="${sessionScope.loginuser == null && sessionScope.companyuser != null}">
									<a href="<%= ctxPath%>/companyLogout.we" class="primary-btn" style="margin-right: 20px;">Logout</a>
									<a href="<%= ctxPath%>/hrregister.we" class="primary-btn">${sessionScope.companyuser.cp_name}</a>
									<ul class="dropdown-menu">
										<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/companymp.we">정보수정</a></li>
										<li class="nav-item"><a class="nav-link" href="<%= ctxPath%>/hrregister.we">호텔관리</a></li>
									</ul>
								</c:if>
							</li>
							<li class="nav-item">
								<button type="button" class="search nav-link">
									<i class="lnr lnr-magnifier" id="search"></i>
								</button>
							</li>
						</ul>
					</div>
				</div>
			</nav>
			
			<%-- 상단바 검색 아이콘 누르면 나오는 검색폼. --%>
			<div class="search_input" id="search_input_box">
				<div class="container">
					<form name="searchBarFrm" class="d-flex justify-content-between">
						<input type="text" class="form-control" name="blendSearchWord" placeholder="WHERE you want to go?">
						<button type="button" id="headerSearchBarBtn" class="btn"></button>
						<span class="lnr lnr-cross" id="close_search" title="Close Search"></span>
					</form>
				</div>
			</div>
		</div>
	</header>
	<!--================ End Header Menu Area =================-->

	<!--================Home Banner Area =================-->
	<section class="banner_area ">
	<c:set var="randomBanner"><%= java.lang.Math.round(java.lang.Math.random()*5) %></c:set>
		<div class="banner_inner overlay d-flex align-items-center" style="background: url('<%= ctxPath%>/resources/img/banner/${randomBanner}.jpg');">
			<div class="container">
				<div class="banner_content">
						<div class="page_link">
<%-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 각자 컨트롤러단에서 보여주려는 뷰단을 리턴할 때, 꼭 키값을 menuname 으로 해서, 해당 페이지의 메뉴 이름을 꼭 보낼 것! --%>
<%-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 첫 번째 href에 줄 주소의 키값은 menulink 로 해서 보낼 것!! --%>
							<c:if test="${menulink != null && menulink != ''}">
								<a href="${requestScope.menulink}">${requestScope.menuname}</a>
							</c:if>
<%-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 각자 컨트롤러단에서 보여주려는 뷰단을 리턴할 때, 꼭 키값을 pagename 으로 페이지 이름을 보낼 것! 그래야 헤더부분에 제목 뜸. --%>
<%-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 두 번째 href에 줄 주소의 키값은 pagelink 로 해서 보낼 것!! --%>
							<a href="${requestScope.pagelink}">${requestScope.pagename}</a>
						</div>
					<h2>${requestScope.pagename}</h2>
				</div>
			</div>
		</div>
	</section>
	<!--================End Home Banner Area =================-->


	
	
	<section style="font: 600 12px/80px 'Roboto', sans-serif;">
	<div class="indexContainer" style="min-height: 800px; margin: 8%;">
			<div class="searchDIV" style=" height:900px; height:28%; margin:3% 3%; padding: 0 6% 0 6%; width: 90%; border: 2px solid #006699;">
				 <form name="searchFrm" id="boxcontainer;">
					
					<!-- 리조트검색  -->
					<div class="searchArea dis"  style="float: left;margin-top: 5%;margin-right:4%;font-size: x-large;">
						   <span class="searchLabel_text" id="searchdesti">어디 갈까?</span>
						   <input class="searchLabel_input" name="blendSearchWord" type="text" id="areaKeyword"  value="" style="height: 12%;width:64%;font-size: 14pt; text-align:center;" placeholder="리조트명 검색 "/>	  					
					</div>
					
					<!-- 날짜지정  -->				
					 <div class="schedule" style="display:inline-block; width:40%; margin-top:3%; " >
						<table style="width: 100%; font-size: 30px; margin-top:8%;">
					
						<tr style="width: 100%;">
							<td align="left" style="width:40%; height:1%">
								<input name="book_start" style="width:100%; text-align: center;" type="text"  id="startDate" value="" placeholder="체크인" autocomplete="off" />
							</td>
							
							<td align="center" style="width:20%">
								 -> 
							</td>
							
							<td align="left" style="width:40%">
								<input name="book_end" style="width:100%; text-align: center;" type="text"  id="endDate" value="" placeholder="체크아웃" autocomplete="off" />
							</td>
						</tr>            
						<tr style="width: 100%;">
							<td align="center">
								14:00
							</td>
						 
							<td align="center">
								
							</td>
							
							<td align="center">
								12:00
							</td>					
						</tr>
					</table>
					 </div>
					
									 
					<!-- 방조건선택  -->										
					<div class="mainRoomOptions dis" id="setRoomOptions selectId" class="room_Person" style="display:inline-block; width:20%; font-size: 18px;" >
						<div id="roomPersonview" >	
							<button type="button" id="set_room_Person" class="set room_Person" style="clear:both; display:block;width: 80%; margin-left: 15%; height: 43%; float: left;margin-top: -36%;">
								<span>객실 1<strong class="secondary" id="srp_room"></strong></span>
								<span>성인<strong class="secondary" id="srp_adult">0</strong></span>
								<span>아동<strong class="secondary" id="srp_child">0</strong></span>
							</button>
					</div>	
					
							
							<div class="setRoomOptions_select"  style="clear:both; display: -webkit-box; border: gray 1px solid;">	
									<h5><strong>객실<span class="srp_boxNum">1</span></strong></h5>
									<div class="person_adult" style="display:inline-flex;">
										<select  title="howManyPerson" name=adultNum class="srp_selectAdult">
											<option value="1">성인 1명</option>
											<option value="2">성인 2명</option>                       
											<option value="3">성인 3명</option>
											<option value="4">성인 4명</option>
											<option value="5">성인 5명</option>
											<option value="6">성인 6명</option>
											<option value="7">성인 7명</option>
											<option value="8">성인 8명</option>
										</select>
									</div>
									
									<div class="person_child" style="display:inline-flex;">	
										<select  title="howManyPerson" name="kidsNum" class="srp_selectChilid">
											<option value="0" selected>아동 0명</option>
											<option value="1" >아동 1명</option>
											<option value="2">아동 2명</option>
											<option value="3">아동 3명</option>
											<option value="4">아동 4명</option>
											<option value="5">아동 5명</option>
											<option value="6">아동 6명</option>
											<option value="7">아동 7명</option>
										</select>	
									</div>	
								
							</div>
						 </div>
				 </form> 
					 
					<div style="width: 57px;font-size: 17px; float: right; margin-top: -11.1%;" >			  
						<button type="button" class="bt-search" id="btn_search" onClick="goSearch()" style="height: 74px;">검색</button>
					</div>
			</div>
			
			<div id="container" style="display: inline;">
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
			<table id="noticeTbl" border="3" align="center" style="border-color:#006699;">
			<tr class="noticeTbl">
			    	<td align="center" class="noticeForecast" colspan="2" style="width:160px;height:60px;font-weight: bold;">단기예보</td> 
			     	<td class="notiFCContente" style="width:640px;height:60px;">장기예보는 발표시간을 기준으로 3일후부터 일주일간의 날씨를 나타냅니다 </td>
			     </tr>
			</table>
		</div>
		
		<div style="margin-top: 30px;">
			<table id="calendar" border="3" align="center" style="border-color:#006699;">
		    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
		        <td align="center" id="tbCalendarYM" colspan="8" style="height:30px; font-weight: bold;">
		        yyyy년 m월</td>
		    </tr>
		    <tr id=tblSeven>
		    </tr>  
		</table>
		<!-- <script language="javascript" type="text/javascript">
		    buildCalendar();//
			</script> -->
		</div>
</div>
	</section>
	<!--================ End Home Banner Area =================-->

	<!--================ Start CTA Area =================-->
	<div class="cta-area section_gap" style="background-image:url(<%= ctxPath%>/resources/img/banner/index_5.jpg);" style="height: 400px; margin-left: 650px; margin-top: 10%; font: 600 12px/80px 'Roboto', sans-serif;">
		<div class="container" >
				<div class="col-lg-5"  >
					<h1 style=" color : white; font: 600 40px/30px 'Roboto', sans-serif;">오늘의 추천 여행지</h1>
					<h3 style=" color : white; font: 600 30px/30px 'Roboto', sans-serif;">${accvo.acc_name}</h3>
					<p style=" color : white; font: 400 18px/30px 'Roboto', sans-serif;">${accvo.acc_text}
					</p>
					<button type="button" onClick="location.href='<%= ctxPath%>/accommodation/accView.we?acc_idx=${accvo.acc_idx}'" class="primary-btn">Book a Trip</button>
				</div>
		</div>
	</div>
	<!--================ End CTA Area =================-->

	<!--================ Start Trip Package Area =================-->
	<section class="package-area section_gap_top" style="font: 600 12px/30px 'Roboto', sans-serif;">
		<div class="container">
			<div class="row d-flex justify-content-center">
				<div class="ol-lg-12">
					<div class="main_title">
						<p style="font-size: 20pt;">이 여행은 어떠세요?</p>
						<h2>Famous Trips Packages</h2>
						<span class="title-widget-bg"></span>
					</div>
				</div>
			</div>
			<div class="row">
			<c:forEach items="${avoList}" var="avo" >
				<div class="col-lg-4 col-md-6">
					<div class="single-package">
						<div class="thumb">
							<img class="img-fluid" src="<%= ctxPath%>/resources/img/hotel_img/${avo.acc_img}" />								
						</div>
						<div class="meta-top d-flex">
							<p><span class="fa fa-location-arrow"></span>${avo.region_name}</p>
							<p class="ml-20"><span class="fa fa-calendar"></span>${avo.acc_type}</p>
						</div>
						<h4 style="font: 600 12px/30px 'Roboto', sans-serif;">${avo.acc_name}<br></h4>
						<p>${avo.acc_text}</p>
						<a href="<%= ctxPath%>/accommodation/accView.we?acc_idx=${avo.acc_idx}" class="primary-btn">Read More</a>
						<!--"fqfw.we?acc_idx=${acc_idx}" 를 해야 acc_idx를 파라미터로 갖고 그 idx에 맞는 상세페이지를 띄워줌 -->
					</div>
				</div>
			</c:forEach>
			</div>
		</div>	
	</section>
	<!--================ End Trip Package Area =================-->

	

	<!--================  Start Footer Area =================-->
	<footer class="footer-area">
		<div class="footer_top section_gap_top">
			<div class="container">
				<div class="row">
					<div class="col-lg-4 col-md-6 col-sm-6">
						<div class="single-footer-widget">
							<h5 class="footer_title">About Wetre</h5>
							<p class="about-text"> We offer that you can go on a trip in nice weather. Just leave your time free for you.</p>
						</div>
					</div>
					<div class="col-lg-4 col-md-6 col-sm-6">
						<div class="single-footer-widget">
							<h5 class="footer_title">Navigation Links</h5>
							<div class="row">
								<div class="col-5">
									<ul class="list">
										<li><a href="<%= ctxPath%>/index.we">Home</a></li>
										<li><a href="#">Weather</a></li>
										<li><a href="<%= ctxPath%>/accommodation/accList.we">Accommodation</a></li>
									</ul>
								</div>
								<div class="col-5">
									<ul class="list">
										<li><a href="#">Notice</a></li>
										<li><a href="#">About us</a></li>
										<li><a href="#">Contact</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4  col-md-6 col-sm-6">
						<div class="single-footer-widget mail-chimp">
							<h5 class="mb-20">Instragram Feed</h5>
							<ul class="instafeed d-flex flex-wrap">
								<li><img src="<%= ctxPath%>/resources/img/i1.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i2.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i3.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i4.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i5.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i6.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i7.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i8.jpg" alt=""></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="copyright">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-12">
						<p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
</p>
					</div>
					<div class="col-lg-6 col-md-12 text-right">
						<div class="social-icons">
							<a href="#"><i class="fa fa-facebook"></i></a>
							<a href="#"><i class="fa fa-twitter"></i></a>
							<a href="#"><i class="fa fa-dribbble"></i></a>
							<a href="#"><i class="fa fa-behance"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!--================ End Footer Area =================-->

	<!-- Optional JavaScript -->
	
	
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="<%= ctxPath%>/resources/js/popper.js"></script>
	<script src="<%= ctxPath%>/resources/js/bootstrap.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/stellar.js"></script>
	<script src="<%= ctxPath%>/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="<%= ctxPath%>/resources/vendors/nice-select/js/jquery.nice-select.min.js"></script>
	<script src="<%= ctxPath%>/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/owl-carousel-thumb.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/jquery.ajaxchimp.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/mail-script.js"></script>
	<!--gmaps Js-->
	<script src="<%= ctxPath%>/resources/js/gmaps.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/theme.js"></script>

</body>

