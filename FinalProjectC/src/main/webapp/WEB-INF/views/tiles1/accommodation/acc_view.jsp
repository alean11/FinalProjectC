<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    

<%
    String ctxPath = request.getContextPath();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#googlemap {
	position: relative;
    left: 630px;
    top: 5px;
    
}

</style>

<link rel="stylesheet" href="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&callback=initMap"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	/* 구글 지도 코딩 시작 */
	
	var addresses = "${acc_addr1}"; /* acc_addr1 */
	
	$.getJSON('https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&sensor=false&address='+addresses, null, function(data){
        var p = data.results[0].geometry.location;
        var latlng = new google.maps.LatLng(p.lat, p.lng);
      
		
        var map;
        var elevator;
        var myOptions = {
            zoom: 15,
         // center: {lat: 37.566535, lng: 126.97796919999996},
            center: latlng,
            mapTypeId: 'roadmap'  
        };
        
        map = new google.maps.Map(document.getElementById('googlemap'), myOptions);
        new google.maps.Marker({
            position: latlng,
            map: map
        });
        
        // console.log(${storemapList.size()});
        /* var addresses = ['거제시', '통영시', '김해시','남해군','창원시']; */
    }); // end of $.getJSON --------------------------
	
	/* 구글 지도 코딩 끝 */
	 
	// 달력 Bootstrap 시작
	$( "#book_start" ).datepicker({dateFormat:"yy-mm-dd"});
	$( "#book_end" ).datepicker({dateFormat:"yy-mm-dd"});
	// 달력 Bootstrap 끝
		
	
	// 체크인 및 체크아웃과 인원 선택 후 검색 버튼을 눌렀을 때
	$("#btnSearch").click(function(){
		
		
		// 방 종류 select 태그의 value 값을 얻어온다.
		var adult = $("#adult").val();
		var kids = $("#kids").val();
		
		
		if(adult == "") {
			alert("성인 인원 수를 제대로 입력하세요.");
			return;
		}
		
		if(kids == "") {
			alert("청소년 인원 수를 제대로 입력하세요.");
			return;
		}
		
		var frm = document.searchFrm;
		
		// 체크인 및 체크아웃의 value 값을 얻어온다.
		var startDate = frm.book_start.value;
		var endDate = frm.book_end.value;
		
		// 체크인 및 체크아웃의 날짜를 아무것도 입력하지 않았으면 alert를 띄워주겠다.
		if(startDate == "" || endDate == "") {
			alert("검색하실 날짜를 선택하세요!!");
			return;
		}
		
		console.log("뱀이야");
		// console.log(${start});
		// console.log(${end});
			
		
		
		// 날짜 뽑아오기
		startDate = startDate.substring(0,4) + startDate.substring(5,7) + startDate.substring(8);
		
		endDate = endDate.substring(0,4) + endDate.substring(5,7) + endDate.substring(8);
		
		console.log(typeof (startDate.substring(0,4) + startDate.substring(5,7) + startDate.substring(8)));
		console.log(startDate.substring(0,4));
		console.log(startDate.substring(4,6));
		console.log(startDate.substring(6,8));
		
		console.log(endDate.substring(0,4));
		console.log(endDate.substring(4,6));
		console.log(endDate.substring(6,8));
		
		if(Number(endDate) - Number(startDate) < 0) {
			alert("날짜 구간 범위를 올바르게 하세요!!");
			return;
		}
		
		/* frm.method = "GET";
		frm.action = 
		frm.submit(); */
		
		
		var data_form = $("form[name=searchFrm]").serialize();
		
		/* var data_form = {"book_start":$("#book_start").val(),
				         "book_end":$("#book_end").val(),
				         "adult":$("#adult").val(),
				         "kids":$("#kids").val()}; */
		
		// 객실 타입 및 객실 가격을 얻어오기 위해 Ajax를 쓰겠다. 		         
		$.ajax({
			url:"acc_view2.we",
			type:"GET",
			data:data_form,
			dataType:"JSON",
			async: true,
			success:function(json){
				
				if(json.length > 0) {
								
					$.each(json, function(index, item){
						
						<c:set var="start" value="item.book_start" />
						<c:set var="end" value="item.book_end" />
						
						console.log("item.rtype_name: "+item.rtype_name);
						console.log("item.totalpay: "+item.totalpay);
						console.log("시험용");
						console.log("item.book_start: "+item.book_start);
						console.log("item.book_end: "+item.book_end);
					    console.log(${start});
					    console.log(${end});
					    console.log(startDate);
					    console.log(endDate);
					    					   
					     
						var html  = "";
						
						var str_addfee = item.BM_BR_ADDFEE;
						var addfee = Number(str_addfee);
							 
					    html += "<div class='section-top-border'>";
					    html += "<h3 class='mb-30 title_color'>객실 예약</h3>";
					    html += "<div class='progress-table-wrap'>";
					    html += "<div class='progress-table'>";
					    html += "<div class='table-head'>";
					    html += "<div class='serial'>순번</div>";
					    html += "<div class='serial' style='border: 0px solid red; width:13%; position:relative; left: -65px;'>객실 종류</div>";
					    html += "<div class='percentage' style='border: 0px solid navy; width: 13%; position:relative; left: -10px;'>객실  옵션</div>";
					    html += "<div class='country' style='border: 0px solid green; position:relative; left: 100px; width: 15%;'>조식 선택</div>";
					    html += "<div class='superman' style='border: 0px solid orange; padding-top: 8px; position:relative; left: 20px; color: black;'>숙박 가격</div>";
					    html += "<div class='percentage' style='border: 0px solid pink; position:relative; left: 90px;'>예약하기</div>";
					    html += "</div>";
					    
						for(var i = 0; i < json.length; i++) {
														
							html += "<div class='table-row'>";
						    html += "<div class='serial'>"+(i+1)+"</div>";
						    html += "<div class='country' style='position:relative; left: -30px;'>"+json[i].rtype_name+"</div>";
						    html += "<div class='percentage' style='border: 0px solid navy; color: black; position:relative; left: -265px; width: 300px;'>"+json[i].BM_AMENITY+" <br/>/ "+json[i].BM_DEVICE +"</div>";
						    html += "<div class='country"+i+"' style='border: 0px solid green; padding-top: 27px; display: inline-block; color: black; position:relative; left: -205px; top:5px;'><label for='barmenity"+i+"' style='cursor: pointer;'>조식 포함&nbsp;&nbsp;</label><input type='checkbox' name='barmenity"+i+"' class='barmenity' id='barmenity"+i+"' value='"+Number(json[i].totalpay)+Number(json[i].BM_BR_ADDFEE)+"'/> <input type='hidden' value='"+json[i].BM_BR_ADDFEE+"' /><span style='border: 0px solid red; position:relative; left: 200px; top:-34px;'>"+json[i].totalpay+"</span></div>";               
						    html += "<div class='percentage'><button type='button' class='btn btn-outline-success' style='cursor: pointer;' onclick='reservation("+'"'+json[i].rtype_name+'"'+","+json[i].r_idx+","+json[i].totalpay+","+json[i].rtype_idx+")'>예약하기</button>";
						    html += "</div>";
						    html += "</div>";
						    
						    $("#roomtable").append(html);
						    						    
						}// end of for-------------------------------------    
						    
						    html += "</div>";
						    html += "</div>";
						    html += "</div>";
						    					    
					        $("#roomtable").html(html);    
				        
					}); // end of $.each(json, function(index, item) -----------------------
					
				}
				else {
					alert("해당 날짜에 예약이 불가합니다!");
				}
				 // end of if ~ else ----------------
				
			}, // end of function(json) --------------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()---------------------------
		
	}); // end of $("#btnSearch").click(function() ---------
     

     $(document).on("click", ".barmenity", function() {
    	 var bm_br_addfee_val = Number($(this).next().val());
    	 var totalpay_val = Number($(this).next().next().text());
    	 
    	 var bool = $(this).is(":checked");
    	 
    	 if(bool==true) {
    		 $(this).next().next().text(bm_br_addfee_val + totalpay_val); 
    	 } 
    	 else {
    		 $(this).next().next().text(totalpay_val - bm_br_addfee_val); 
    	 }
     }); // end of $(document).on("click", ".barmenity", function() ---------------------
	
     goLikeDislikeCount();		 
    		 
     goCommentListView();
	
	 // 댓글버튼 클릭시
     $(".btnCommentOK").click(function(){
			
			if( ${sessionScope.loginuser == null} ) {
				alert("숙박후기를 작성하시려면 먼저 로그인 하십시오!");
				location.href="<%= ctxPath%>/privateLogin.we";
				return;
			}
			
			var commentContents = $("#comments").val().trim();
			
			if(commentContents == "") {
				alert("숙박후기 내용을 입력하세요!!");
				return;
			}
			
			var queryString = $("form[name=commentFrm]").serialize();
			// form 태그에 있는 모든 input 을 보내겠다.
			$.ajax({
				url:"<%= ctxPath%>/accommodation/commentRegister.we",
				type:"POST",
				data:queryString,
				success:function(){
					goCommentListView(); // json 타입으로 select 를 해오겠다.
					$("#comments").val("").focus();
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} // end of error ------------------------------------- 
				
			}); // end of $.ajax({ ------------------------------
		}); // end of button --------

}); // end of $(document).ready(function() ----------------
	
	// 좋아요 함수 실행
	function golikeAdd(accVal) {
		   	
	           var p_userid = "${sessionScope.loginuser.p_userid}"; 
	           
	           
	           if(p_userid == null || p_userid == "") {
	        	   alert("먼저 로그인 하세요!!");
	        	   location.href="<%= ctxPath%>/privateLogin.we";
	           }
	           else {
			       var form_data = {userid:p_userid,
						            acc_idx:accVal};
				   
				   $.ajax({
					  url:"like.we",
					  type:"POST",
					  data:form_data,
					  dataType:"JSON", // select 를 json 으로 받겠다.
					  success:function(json) {
						   // alert(json.msg);
						      swal(json.msg);
						      goLikeDislikeCount();
					  },
					  error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  } // end of error ------------------------------------- 
				   }); // end of $.ajax -------------------------------   
	           }
		   
	} // end of function golikeAdd(pnumVal) -----------------------------------------------------------
	
	// 싫어요 함수 실행
	function goDisLikeAdd(accVal) {
		   	
	           var p_userid = "${sessionScope.loginuser.p_userid}";
	           
	           
	           if(p_userid == null || p_userid == "") {
	        	   alert("먼저 로그인 하세요!!");
	        	   location.href="<%= ctxPath%>/privateLogin.we";
	           }
	           else {
			       var form_data = {userid:p_userid,
						            acc_idx:accVal};
				   
				   $.ajax({
					  url:"disLike.we",
					  type:"POST",
					  data:form_data,
					  dataType:"JSON", // select 를 json 으로 받겠다.
					  success:function(json) {
						   // alert(json.msg);
						      swal(json.msg);
						      goLikeDislikeCount();
					  },
					  error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  } // end of error ------------------------------------- 
				   }); // end of $.ajax -------------------------------   
	           }
		   
	} // end of function goDisLikeAdd(pnumVal) -----------------------------------------------------------
	
	// 좋아요, 싫어요 갯수 구하기
	function goLikeDislikeCount() {
		   
		   $.ajax({
			  
			   url:"likeDislikeCount.we",
			   type:"GET",
			   data:{acc_idx:"${avo.acc_idx}"}, // "" 은 빼도 무방하다.
			   dataType:"JSON",
			   success:function(json){
				   var likecnt = json.LIKECNT;
				   var dislikecnt = json.DISLIKECNT;
				   
				   $("#likeCnt").text(likecnt);
				   $("#dislikeCnt").text(dislikecnt);
			   },
			   error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   } // end of error ------------------------------------- 
			   
		   });
		   
	   } // end of goLikeDislikeCount()-------------------------------------------
	
	function goCommentListView() {
		// 숙박 후기를 보여주는 함수
		
		$.ajax({
			url:"commentList.we",
			type:"GET",
			data:{acc_idx:"${avo.acc_idx}"},
			dataType:"JSON",
			success:function(json){
				// json 은 ajax 요청에 의해 URL 페이지로부터 리턴받은 데이터 (JSONArray 형태)이다.
				var html = "";
				
				if (json.length > 0) {    
					$.each(json, function(index, item){
					  html += "<div><span class='markColor'>▶</span> "+item.contents+"</div>"
					  	    + "<div style='padding-left: 18px; margin-bottom: 20px;'>작성일자:&nbsp;"+item.com_writedate+"<span style='padding-left: 20px;'>작성자:&nbsp;"+item.userid+"</span></div>";       
					  				       
					}); 
				}// end of if -----------------------
				
				else {
					html += "<div>등록된 상품후기가 없습니다.</div>";
				}// end of else ---------------------
				
				$("#viewComments").html(html);
							
			},
			error: function(request, status, error){
				console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   } // end of error -------------------------------------
		});
		
		
   } // end of function goCommentListView() --------------------------------
   
   // 예약하기 버튼을 눌렀을때
	function reservation(rtypeNameVal, ridxVal, totalpay, rtypeIdxVal) {
		
	   var p_userid = "${sessionScope.loginuser.p_userid}";
	   var log = "";
		
		if(p_userid == null || p_userid == "") {
	    	alert("먼저 로그인 하세요!!");
	    	location.href="<%= ctxPath%>/privateLogin.we";
	    }
	    else {
			var adultNum = $('#adult').val();
			var kidsNum = $('#kids').val();
			var book_start = $("#book_start").val();
			var book_end = $("#book_end").val();
			
			var frm = document.reserveFrm;
			frm.adultNum.value = adultNum;
			frm.kidsNum.value = kidsNum;
			frm.rtype_cnt.value = 1;
			frm.book_start.value = book_start;
			frm.book_end.value = book_end;
			frm.rtype_name.value = rtypeNameVal;
			frm.r_idx.value = ridxVal;
			frm.accPrice.value = totalpay;
			frm.rtype_idx.value = rtypeIdxVal;
			
			frm.action = "<%=ctxPath%>/payment.we";
			frm.method = "POST";
			frm.submit();
			
		}	
	}
 

</script>


</head>
<body>
  <div style="width: 95%; margin: 0 auto;">
  
  	<!--================ 호텔 이름 및 호텔 주소 시작 =================-->
	<section class="popular-places-area section_gap_bottom">
		<div class="container" style="margin-top: 25px;">
			<div class="row d-flex justify-content-center">
				<div class="col-lg-12">
					<div class="main_title">
						<p>We’re Offering these Trip Packages</p>
						<h1>${avo.acc_name}</h1>
						<h5 style="margin-top: 20px;">${avo.acc_addr1}</h5>
						<h5>${avo.acc_addr2}</h5>
						<span class="title-widget-bg"></span>
					</div>
				</div>
			</div>
		</div>
		
		<!--================ 호텔 이름 및 호텔 주소 끝 =================-->
		
		
		<!--================ 호텔 이미지 시작 =================-->
		<div id="myCarousel" class="carousel slide" data-ride="carousel" style="height: 350px;">
		    
		    <div class="carousel-inner">		    
			<div class="popular-places-slider owl-carousel">
				<div class="single-popular-places">
					<div class="popular-places-img">
						<img src="<%= ctxPath%>/resources/img/hotel_img/${avo.acc_img}">
					</div>
					<div class="popular-places-text">
						<a href="single-blog.html">
						</a>
						<p>Proper Guided Tour</p>
						<h4>
							${avo.acc_name}<br/> 
							Welcome!
						</h4>
					</div>
				</div>
					  		
				<c:forEach var="addaccImg" items="${addaccImgList}" varStatus="status">
			    <div class="single-popular-places">
					<div class="popular-places-img">
						<img src="<%= ctxPath%>/resources/img/hotel_img/${addaccImg.ad_img1}" alt="">
					</div>
					<div class="popular-places-text">
						<a href="single-blog.html">
						</a>
						<p>Proper Guided Tour</p>
						<h4>
							${avo.acc_name}<br/> 
							Dream and Fun package
						</h4>
					</div>
				</div>
				
				<div class="single-popular-places">
					<div class="popular-places-img">
						<img src="<%= request.getContextPath()%>/resources/img/hotel_img/${addaccImg.ad_img2}" alt="">
					</div>
					<div class="popular-places-text">
						<a href="single-blog.html">
						</a>
						<p>Proper Guided Tour</p>
						<h4>
							${avo.acc_name}<br/>
							Have Your Good Time
						</h4>
					</div>
				</div>
				
				<div class="single-popular-places">
					<div class="popular-places-img">
						<img src="<%= request.getContextPath()%>/resources/img/hotel_img/${addaccImg.ad_img3}" alt="">
					</div>
					<div class="popular-places-text">
						<a href="single-blog.html">
						</a>
						<p>Proper Guided Tour</p>
						<h4>
							${avo.acc_name}<br/>
							Enjoy!							
						</h4>
					</div>
				</div>
				</c:forEach>
								
				<!-- <!-- Left and right controls -->
			    <!-- <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			      <span class="glyphicon glyphicon-chevron-left"></span>
			      
			    </a>
			    <a class="right carousel-control" href="#myCarousel" data-slide="next">
			      <span class="glyphicon glyphicon-chevron-right"></span>
			      
			    </a> -->
			</div>
		</div>
		</div>
			
	</section>
	<!--================ 호텔 이미지 끝 =================-->
	
	
	<!--================ 호텔 설명 시작 =================-->
	<div class="item">
			<div class="testi-item" style="text-align: center; border: 0px solid yellow; max-height: 300px; overflow: auto;">
				<img src="img/quote.png" alt="">
				<h3>호텔 설명</h3>
				<ul class="list">
					<li><i class="fa fa-star"></i></li>
					<li><i class="fa fa-star"></i></li>
					<li><i class="fa fa-star"></i></li>
					<li><i class="fa fa-star"></i></li>
					<li><i class="fa fa-star"></i></li>
				</ul>
				<div class="wow fadeIn" data-wow-duration="1s">
					<p>${avo.acc_text}</p>
				</div>
			</div>
	</div>
	<!--================ 호텔 설명 끝 =================-->
   	
   	
   	<!--================ 구글 지도 시작 =================-->  
   	<div style="text-align: center; margin-bottom: 30px;"><h3>호텔 위치</h3></div>
   	
   	<div class="row">
   		<div class="col-md-4 line" id="googlemap" style="min-height: 480px; width: 950px; margin-bottom: 50px;"></div>     
	</div>      
	<!--================ 구글 지도 끝 =================-->    
	     
	      
     <!--================ 체크인 체크아웃 날짜 및 인원수 보여주기 시작 =================-->
     <div class="row" style="border: 0px solid red; margin-bottom: 25px; margin: 0 auto; width: 520px;"> 
        <%-- <c:forEach var="DateAndPeopleCount" items="${DateAndPeopleCountList}" varStatus="status">
        <div style="margin-left: 25px;">
             <div><span>현재 예약일을 ${DateAndPeopleCount.book_start}부터 ${DateAndPeopleCount.book_end}까지 선택하셨고</span></div>
	         <div><span>현재 ${DateAndPeopleCount.acc_name}의 방 종류는 ${DateAndPeopleCount.rtype_name}가 있고 남은 객실수는 ${DateAndPeopleCount.rtype_cnt} </span></div>
	         
        </div>
        </c:forEach> --%>
        
        
	        <form name="searchFrm" style="padding: 20px 0 20px 20px;">
	        	<input type="hidden" name="acc_idx" value="${avo.acc_idx}" /> <%-- value="${acc_idx}" 방 검색 시, 해당 호텔의 방을 다시 검색하러 들어가는거니까, 호텔 idx를 다시 넣어줘야 함. --%>
	        
	        	<%-- 숙박 날짜 검색 --%>
	         	<span style="display: inline-block; margin-right: 20px; font-size: 12pt; font-weight: bold;">체크인 및 체크아웃</span><input type="text" name="book_start" id="book_start" value="" autocomplete="off" /> <span style="display: inline-block; width: 10px; text-align: center;">-</span> <input type="text" name="book_end" id="book_end" value="" autocomplete="off" />
	       		
	       		<div>
	       		<div style="margin:20px 0; border: 0px solid gray; display: inline-block;">	
					<%-- 성인 인원수 검색 --%>
					<div class="line" style="display: inline-block;">
						<select name="adult" id="adult">
							<option value="" >::성인 인원 검색::</option>
							<option value="1">성인 1명</option>
							<option value="2">성인 2명</option>
							<option value="3">성인 3명</option>
						</select>
					</div>
					
					
					<%-- 청소년 인원수 검색 --%>
					<div class="col-md-4 line" style="display: inline-block;">
						<select name="kids" id="kids">
							<option value="" >::청소년 인원 검색::</option>
							<option value="1">청소년 1명</option>
							<option value="2">청소년 2명</option>
						</select>
					</div>
				</div>
				
				<div style="display: inline-block; position: relative; top: -17px; margin-left: 20px;">	
					<button type="button" class="btn btn-warning" id="btnSearch" style="color: white; font-weight: bold; width: 110px; height: 41px;">검&nbsp;색</button>
				</div>
				</div>
			</form>	
		  </div>
     
     <!--================ 체크인 체크아웃 날짜 및 인원수 보여주기 끝 =================-->
     
     <!-- 방 타입 및 방 가격 보여주기 시작 -->
     <div id="roomtable"></div>
     <!-- 방 타입 및 방 가격 보여주기 끝 -->
     
     
     <!-- 좋아요 및 싫어요 보여주기 시작 -->
     <div class="row" style="margin: 0 auto; width: 70%; border: 0px solid blue; text-align: center;">
		    <div class="col-md-1" id="likeCnt" align="left" style="color: black; font-size: 22pt; position: relative; top: 70px; left: 130px; margin-right: 100px;">1</div>
	   	<img src="<%= ctxPath%>/resources/img/like2.png" style="cursor: pointer; margin-right: 160px;" onClick="golikeAdd('${avo.acc_idx}');" />
	    
		    <div class="col-md-1" id="dislikeCnt" align="left" style="color: black; font-size: 22pt; position: relative; top: 75px; left: 130px; margin-right: 100px;">0</div> 
	    <img src="<%= ctxPath%>/resources/img/dislike2.png" style="cursor: pointer;" onClick="goDisLikeAdd('${avo.acc_idx}');" /> 
	 </div> 
     <!-- 좋아요 및 싫어요 보여주기 끝 -->
     
     
     <!-- 댓글쓰기 시작 -->
     <div style="width: 750px; margin: 0 auto; margin-bottom: 100px; border: 0px solid orange;">
     <span style="display: inline-block; margin-top: 70px; font-size: 16pt; color: orange; font-weight: bold;">숙박이용 후기</span> 
	 <div id="viewComments" style="border: 0px solid red; margin-top: 15px; max-height: 200px; overflow: auto; width: 700px;"></div>
	 <form name="commentFrm">
		<div class="register" style="width: 700px;">
			<textarea cols="97" class="customHeight" name="comments" id="comments" style="margin-top: 25px;"></textarea>
		</div>
		<div class="register">
			<button type="button" class="btn btn-warning btnCommentOK" style="margin-top: 21px; color: white; font-weight: bold; position: relative; left: 310px;" >후기등록</button>
		</div>
			<input type="hidden" name="acc_idx" value="${avo.acc_idx}" />
			<input type="hidden" name="goBackURL" value="${goBackURL}" /> 
	 </form>
	 </div>
     <!-- 댓글쓰기 끝 -->

<form name='reserveFrm'>
	<input type='hidden' name='acc_name' value='${avo.acc_name}'>
	<input type='hidden' name='acc_grade' value='${avo.acc_grade}'>
	<input type='hidden' name='acc_addr1' value='${avo.acc_addr1}'>
	<input type='hidden' name='acc_addr2' value='${avo.acc_addr2}'>
	<input type='hidden' name='acc_tel1' value='${avo.acc_tel1}'>
	<input type='hidden' name='acc_tel2' value='${avo.acc_tel2}'>
	<input type='hidden' name='acc_tel3' value='${avo.acc_tel3}'>
	<input type='hidden' name='adultNum' value=''>
	<input type='hidden' name='kidsNum' value=''>
	<input type='hidden' name='accPrice' value=''>
	<input type='hidden' name='rtype_name' value=''>
	<input type='hidden' name='rtype_cnt' value=''>
	<input type='hidden' name='r_idx' value=''>
	<input type='hidden' name='rtype_idx' value=''>
	<input type='hidden' name='book_start' value=''>
	<input type='hidden' name='book_end' value=''>
</form>

   </div> 
</body>
</html>