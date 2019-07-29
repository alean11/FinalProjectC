<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- !!!!!주의!!!!!! fn을 쓸 때, onclick="함수()" 이거 안 먹힘. document.ready로 불러와서 제이쿼리로 쓰면 먹힘. --%>

<% String ctxPath = request.getContextPath(); %>

<%-- 날짜선택 달력 관련 --%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<%-- 가격바 스타일 관련 추가 --%>
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/chy_style.css">

<script type="text/javascript">

	// 날짜 달력 관련
	$(function() {
	
		  $('.book_start, .book_end').daterangepicker({
		      autoUpdateInput: false,
		      locale: {
		          cancelLabel: 'Clear'
		      }
		  });
	
		  $('.book_start, .book_end').on('apply.daterangepicker', function(ev, picker) {
		      $('input[name="book_start"]').val(picker.startDate.format('YYYY-MM-DD'))
		      $('input[name="book_end"]').val(picker.endDate.format('YYYY-MM-DD'))      
		  });
	
		  $('.book_start, .book_end').on('cancel.daterangepicker', function(ev, picker) {
			  $('input[name="book_start"]').val('');
			  $('input[name="book_end"]').val('');
		  });
	}); // end of 날짜 달력 ----------------------




	$(document).ready(function(){
		
		/// 자동완성 부분 가리기 ///
		$(".searchWordListWrapper").hide();
		
		
		/// 검색바 x 누르면 검색어 전부 삭제 ///
		$(".btn-default").click(function(){
			$("#blendSearchWord").val("");
		}); // end of 검색바 x -----------------
		
		
		/// 호텔 등급 & 타입 받기 ///
		receiveAccGrade();
		receiveAccType();
		
		/// 숙박일 미정 체크 시 check-in/out 박스 값 없애고 disabled 만들기
	    $("#undecidedDates").change(function(){
	    	
			if($("#undecidedDates").is(":checked")){
				$('input[name="book_start"]').attr('disabled', true);
				$('input[name="book_start"]').val("");
				$('input[name="book_start"]').css("background-color","#f2f2f2");
				$('input[name="book_end"]').attr('disabled', true);
				$('input[name="book_end"]').val("");
				$('input[name="book_end"]').css("background-color","#f2f2f2");
			}else{
				$(".book_start").attr('disabled', false);
				$('input[name="book_start"]').css("background-color","white");
				$(".book_end").attr('disabled', false);
				$('input[name="book_end"]').css("background-color","white");
			}
	        
	    }); // end of 숙박일 미정 체크 이벤트 ---------
	    
	    
	    
	    /// 예보기간 선택 이벤트 ///
	    $("#blendWeatherDaysOpt").change(function(){
	    	if($("#blendWeatherDaysOpt").val() == 0) {
	    		receiveTodayWeather(); // 현재 날씨
	    	}
	    	if($("#blendWeatherDaysOpt").val() == 3) {
				receiveLongWeather(); // 3일 후 날씨
	    	}
	    }); // end of 예보기간 선택 이벤트 -------------
	    
	    
	    /// 통합검색 폼 양식 보내기 ///
	    $("#blendedSearchBtn").click(function(){
	    	
	    	console.log("날씨기간: "+$("#blendWeatherDaysOpt").val());
	    	console.log("날씨종류: "+$("#blendWeatherOpt").val());
	    	
	    	// 예보기간 선택했는데, 날씨 선택 안 했으면 경고함.
	    	if( ($("#blendWeatherDaysOpt").val() != "" && $("#blendWeatherDaysOpt").val() != null) &&
	    		($("#blendWeatherOpt").val() == "" || $("#blendWeatherOpt").val() == null) ) {
	    		alert("날씨를 선택해줘!");
	    		return;
	    	}
			
	    	// 날씨 선택했는데, 예보기간 선택 안 했으면 경고함.
	    	if( ($("#blendWeatherOpt").val() != "" && $("#blendWeatherOpt").val() != null) &&
	    		($("#blendWeatherDaysOpt").val() == "" || $("#blendWeatherDaysOpt").val() == null) ) {
	    		alert("예보기간을 선택해줘!");
	    		return;
	    	}
	    	goBlendedSearch();
	    	
	    }); // end of 통합검색 폼 양식 보내기 ---------
	    
	    
	    
	    /// 호텔등급 및 호텔 종류 선택/해제 시 통합검색 폼 양식 보냄. ///
 	    $("[name='acc_grade']").click(function(){
	    	goBlendedSearch();
	    }); // end of 호텔 종류 변경 시 통합검색 보냄 ----------
 	    $("[name='acc_type']").click(function(){
	    	goBlendedSearch();
	    }); // end of 호텔 종류 변경 시 통합검색 보냄 ----------
	    
	    
	    
	}); // end of document ready -----------------

	
	
	
	/// 통합검색 제출 함수 ///
	function goBlendedSearch() {
    	
		var frm = document.blendedSearchFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/accommodation/accList.we";
		frm.submit();

	} // end of 통합검색 ---------------
	
	
	
    /// 호텔 등급 받아온 값 꽂아줌: 옵션 유지 위함임. ///
    function receiveAccGrade() {
	
		// 컨트롤러에서 보낸 값을 받아오자
		//	: js/jquery는 브라우저 언어이고 JAVA, jstl, el 등은 서버언어 이기 때문에, 직접 값을 주고받을 수 없음.
		//	: 따라서, jstl로 컨트롤러에서 보낸 값을 받고, 그 값을 배열로 받아준 후, 그 배열을 js/jquery에 대입해줘야 함.
		var accGradeList = new Array();
		var aGradeCntList = new Array();
		var aTypeCntList = new Array();

		// 호텔 등급
		<c:if test="${acc_gradeArr != null && not empty acc_gradeArr}">
			<c:forEach var="accGrade" items="${acc_gradeArr}" varStatus="status">
				var gradeArray = new Object();
				gradeArray = "${accGrade}";
				accGradeList.push(gradeArray);
			</c:forEach>
		</c:if>
		// console.log("호텔등급: "+JSON.stringify(accGradeList));
		
		
		// 호텔 등급과 그 개수
		<c:if test="${accGradeCntList != null && not empty accGradeCntList}">
			<c:forEach var="gradeCnt" items="${accGradeCntList}" varStatus="status">
				var gradeJson = new Object();
				gradeJson.key${gradeCnt.acc_grade} = "${gradeCnt.CNT}";
				aGradeCntList.push(gradeJson);
			</c:forEach>
		</c:if>

		 var gradeCntJsonArray = JSON.stringify(aGradeCntList[0]) ;
		console.log(gradeCntJsonArray); // ==> [{"key1":"1"},{"key2":"2"},{"key5":"4"},{"key4":"4"},{"key3":"1"}]
		var gradeCntJson = JSON.parse(gradeCntJsonArray);
		var str_grade = gradeCntJson.key1;
		console.log(str_grade);
		
		// 호텔 등급 체크박스 제어
		if(accGradeList != null && accGradeList != "") {
		
			$("[name='acc_grade']").prop("checked", false); // 일단 전부 체크 해제

			$.each(accGradeList, function(index, gradeItem){
				// console.log(gradeItem);
				
				// 체크박스 제어
				$("[name='acc_grade']").each(function(index, inputItem){
					if(gradeItem == $(this).val()) {
						// console.log("호텔등급 찾음! "+$(this).val());
						$(this).prop("checked", true); // 값 온 것만 다시 체크
					}
				}); // end of 체크박스 체크

				// 등급 문자 꽂아주기
				var key = "key";
				$(".gradeListAnchor").each(function(index, anchorItem) {
					// console.log($(this).text());
					key = key+($(this).text());
				//	console.log(key);
				//	console.log(gradeCntJson.key);

						//if(gradeCntJson.key$(this).text() == $(this).text()) {
						
						// $(this).text(gradeItem+"-stars");
						//}
					
				});
				
				
			});
		}
		else {
			$("[name='acc_grade']").prop("checked", true); // 일단 전부 체크 해제
		}
		
    } // end of 호텔 등급 받기 -------------
    
    
    
    /// 호텔 종류 받아온 값 꽂아줌: 옵션 유지 위함임. ///
    function receiveAccType() {
	
		// 컨트롤러에서 보낸 값을 받아오자
		var accTypeList = new Array();

		<c:if test="${acc_typeArr != null && not empty acc_typeArr}">
			<c:forEach var="accType" items="${acc_typeArr}" varStatus="status">
				var typeArray = new Object();
				typeArray = "${accType}";
				accTypeList.push(typeArray);
			</c:forEach>
		</c:if>
		
		// console.log("호텔등급: "+JSON.stringify(accGradeList));
		
		
		if(accTypeList != null && accTypeList != "") {
			
			$("[name='acc_type']").prop("checked", false);
			
			$.each(accTypeList, function(index, typeItem){
				// console.log(typeItem);
				$("[name='acc_type']").each(function(index, inputItem){
					if(typeItem == $(this).val()) {
						// console.log("호텔종류 찾음! "+$(this).val());
						$(this).prop("checked", true);
					}
				});
			});
		} // end of if ---------
    } // end of 호텔 등급 받기 -------------
	
	
	
	
	/// ajax로 현재 날씨 지역을 얻어오는 함수 ///
	function receiveTodayWeather() {
	      	
		/// 날씨 api로 지역을 뽑아옴. ///
		$.ajax({
			url: "<%= ctxPath%>/accommodation/kNowWeatherXML.we",
			type: "GET",
			dataType: "XML",
			success: function(xml){
				
				// 첫번째 태그 <current> 찾기
				var rootElement = $(xml).find(":root");
				// console.log($(rootElement).prop("tagName")); // ==> current
				// console.log($(xml).find("weather").prop("tagName")); ==> 먹힘
				
				// 세번째 태그 <local> 찾기. (두번째 태그는 필요없어서 뺌.)
				var localArr = $(rootElement).find("local");
				
				var sunnyWeather = "";
				var cloudyWeather = "";
				var badWeather = "";
				var nthWeather = "";
				
				for(var i=0; i<localArr.length; i++) {
					
					var local = $(localArr).eq(i);
					
					// 날씨별 지역명 뽑자
					if( $(local).attr("desc") == "맑음" ) {
						console.log("맑음: "+$(local).text());
						sunnyWeather += $(local).text()+",";
					}
					else if( $(local).attr("desc") == "흐림" || $(local).attr("desc") == "구름많음" || $(local).attr("desc") == "구름조금") {
						console.log("흐림: "+$(local).text());
						cloudyWeather += $(local).text()+",";
					}
					else if ( $(local).attr("desc") == "비" || $(local).attr("desc") == "박무" || $(local).attr("desc") == "안개" || $(local).attr("desc") == "천둥번개") {
						console.log("나쁨: "+$(local).text());
						badWeather += $(local).text()+","; // 가끔 콤마가 안 붙음. 왜..?
					}
					else {
						nthWeather += $(local).text()+",";
					}
					
				} // end of for -----------
				
				console.log("맑음: "+sunnyWeather);
				console.log("흐림: "+cloudyWeather);
				console.log("나쁨: "+badWeather);
				
				// 히든폼에 날씨 지역값 꽂아줌.
				$("#sunnyWeather").val(sunnyWeather); //  이전 페이지에서 상세 리스트 페이지에 보내줘야, 리스트 페이지 로딩되자맞 날씨 아이콘이 뜸
				$("#cloudyWeather").val(cloudyWeather);
				$("#badWeather").val(badWeather);
			
			
		<%--	// 컨트롤러에 지역 날씨를 보내줌. 혹시 몰라서 냅둠 //
				var region_data = {"sunny":sunnyWeather,
								   "cloudy":cloudyWeather,
								   "bad":badWeather};
			
				$.ajax({
					url: "<%= ctxPath%>/accommodation/accList.we",
					data: region_data,
					type: "GET",
					success: function(){},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				}); // end of 날씨 지역 보내주는 ajax -------- --%>		
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax ---------
			
	} // end of ajax로 현재 날씨 지역을 얻어오는 함수 --------------------------------------------
	
	
	
	
	/// ajax로 중기예보(3일후 오후 기준) 지역을 얻어오는 함수 ///
	function receiveLongWeather() {
	  
			/// 날씨 api로 지역을 뽑아옴. /// -> 이걸 첫번째가 성공하면, 두번째를 그 안에서 보내고, 두번쨰 성공하면 세번째를 그 안에서 보내고... 10번 반복하면 될듯?
			$.ajax({
				url: "<%= ctxPath%>/accommodation/kLongWeatherXML.we",
				type: "GET",
				dataType: "XML",
				success: function(xml){
					
					console.log("성공!");
					
					var rootElement = $(xml).find(":root");
					// console.log($(rootElement).prop("tagName")); // ==> response

					var regid = $(rootElement).find("regid");
					// console.log($(regid).text()); // ==> 공백
					// console.log($(rootElement).find("regid")); // ==> r.fn.init(0)
					// console.log($(rootElement).find("regid").prop("tagName")); // ==> undefined
					// console.log(typeof($(rootElement).find("regid"))); // ==> object
					
					// console.log($(rootElement).find("regid").text()); // ==> 공백
					// console.log(typeof($(rootElement).find("regid").text())); // ==> string
					// console.log($(rootElement).find("items").find("item").find("regid").text()); // 공백
					
					// console.log($(rootElement).find("regid").val()); // ==> undefined
					// console.log(typeof($(rootElement).find("regid").val())); // ==> undefined
					
					// console.log($(rootElement).find("regid").attr()); // ==> 에러 내용: r.fn.init.attr

					// console.log($(xml).find("regid").prop("tagName")); // ==> undefined
					// console.log(document.querySelector("body > response > items > item > regid")); // ==> null
					
					var sunnyWeather = "";
					var cloudyWeather = "";
					var badWeather = "";
					var nthWeather = "";
					
					<%--
					var wf3PmArr =  $(rootElement).find("wf3Pm");
					
					for(var i=0; i<regidArr.length; i++) {
						console.log($(regidArr).eq(i).text());
						
						// 지역명은 코드로 오기 때문에, 코드를 지역명으로 바꿔줘야 됨. 아직 먹히는지 안 먹히는지는 모름;
						if($(regidArr).eq(i).text() == "11B00000") { $(regidArr).eq(i).text("서울,인천,경기도") };
						if($(regidArr).eq(i).text() == "11D10000") { $(regidArr).eq(i).text("강원도") }; // 영서
						if($(regidArr).eq(i).text() == "11D20000") { $(regidArr).eq(i).text("강원도") }; // 영동
						if($(regidArr).eq(i).text() == "11C20000") { $(regidArr).eq(i).text("대전,세종,충청남도") };
						if($(regidArr).eq(i).text() == "11C10000") { $(regidArr).eq(i).text("충청북도") };
						if($(regidArr).eq(i).text() == "11F20000") { $(regidArr).eq(i).text("광주,전라남도") };
						if($(regidArr).eq(i).text() == "11F10000") { $(regidArr).eq(i).text("전라북도") };
						if($(regidArr).eq(i).text() == "11H10000") { $(regidArr).eq(i).text("대구,경상북도") };
						if($(regidArr).eq(i).text() == "11H20000") { $(regidArr).eq(i).text("부산,울산,경상남도") };
						if($(regidArr).eq(i).text() == "11G00000") { $(regidArr).eq(i).text("제주도") };
						
						
						var wf3Pm = $(wf3PmArr).eq(i); // 3일 후 날씨
						
						// 날씨별 지역명 뽑자: 오후날씨
						if( $(wf3Pm).text().indexOf("맑음") != -1 ) {
							sunnyWeather += $(regidArr).eq(i)+",";
						}
						else if( $(wf3Pm).text().indexOf("흐림") != -1 || $(wf3Pm).text().indexOf("구름많음") != -1 || $(wf3Pm).text().indexOf("구름조금") != -1 ) {
							cloudyWeather += $(regidArr).eq(i)+",";
						}
						else if ( $(wf3Pm).text().indexOf("비") != -1 || $(wf3Pm).text().indexOf("박무") != -1 || $(wf3Pm).text().indexOf("안개") != -1 || $(wf3Pm).text().indexOf("천둥번개") != -1 ) {
							badWeather += $(regidArr).eq(i)+",";
						}
						else {
							nthWeather += $(regidArr).eq(i)+",";
						}
						
					} // end of for ----------- --%>
					
					
					console.log("맑음: "+sunnyWeather);
					console.log("흐림: "+cloudyWeather);
					console.log("나쁨: "+badWeather);
					
					// 히든폼에 날씨 지역 코드값을 꽂아줌.
					$("#sunnyWeather").val(sunnyWeather);
					$("#cloudyWeather").val(cloudyWeather);
					$("#badWeather").val(badWeather);
					
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			}); // end of ajax ---------
			
	} // end of ajax로 중기예보(3일후) 지역을 얻어오는 함수 --------------------------------------------
	
	
	
	
	// 숫자 세자리마다 콤마 함수 //
	function numberCom(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

		
	
</script>


    <%--================ 여긴 뭐 넣지.. =================--%>
    <section class="blog_categorie_area">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="categories_post">
                        <img src="<%= ctxPath%>/resources/img/blog/cat-post/cat-post-3.jpg" alt="post">
                        <div class="categories_details">
                            <div class="categories_text">
                                <a href="blog-details.html">
                                    <h5>Social Life</h5>
                                </a>
                                <div class="border_line"></div>
                                <p>Enjoy your social life together</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="categories_post">
                        <img src="<%= ctxPath%>/resources/img/blog/cat-post/cat-post-2.jpg" alt="post">
                        <div class="categories_details">
                            <div class="categories_text">
                                <a href="blog-details.html">
                                    <h5>Politics</h5>
                                </a>
                                <div class="border_line"></div>
                                <p>Be a part of politics</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="categories_post">
                        <img src="<%= ctxPath%>/resources/img/blog/cat-post/cat-post-1.jpg" alt="post">
                        <div class="categories_details">
                            <div class="categories_text">
                                <a href="blog-details.html">
                                    <h5>Food</h5>
                                </a>
                                <div class="border_line"></div>
                                <p>Let the food be finished</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%--================ 여긴 뭐 넣지.. =================--%>




<%--  ********** 호텔 리스트 시작 ********* --%>
    <%-- 호텔 리스트 지금꺼 말고 네모칸 여러개 뜨는걸로 하고(패키지에 있는거), 네모칸 왼쪽 위 날짜 나오는 부분에 검색한 날의 날씨 아이콘이 이미지로 대신 뜨게 할 것. --%>
<section class="blog_area">
    <div class="container">
        <div class="row">

				<%-- 리스트 나오는 전체 감싸는 부분 --%>
               <div class="col-lg-8">
                    <div class="blog_left_sidebar">

                    	<%-- 결과 리스트 나오는 부분 --%>
						<div class="row">
						
                    	<%-- 결과 리스트 반복 부분 --%>
                    		<c:if test="${!empty accList && accList != null}">
		                    	<c:forEach var="accvo" items="${accList}" >
		                    	<c:set var="addr1" value="${accvo.acc_addr1}" />
		                    	<c:set var="addr2" value="${accvo.acc_addr2}" />
									<div class="col-lg-4 col-md-6">
										<div class="single-package">
											<div class="thumb">
	<%-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 이거 이미지 경로 수정해야 함!! 호텔등록 만들어지고, 호텔 등록 시 파일첨부하는 경로로 수정해야 됨!! ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ --%>
												<img class="img-fluid" src="<%= ctxPath%>/resources/img/hotel_img/${accvo.acc_img}" style="width: 180px; height: 125px;">							
											</div>
											
											<c:if test="${!empty sunnyRegionArr && sunnyRegionArr != null}">
												<c:forEach var="sunnyArr" items="${sunnyRegionArr}">
													<c:set var="sunnyVal" value="${sunnyArr}" /> <%-- 변수로 선언해주지 않으면, fn:contains()가 안 먹힘. 오류는 안 나는데, 안 먹힘. --%>
													<c:if test="${fn:contains(addr1, sunnyVal) || fn:contains(addr2, sunnyVal)}">
														<p class="date"><span><img src="<%= ctxPath%>/resources/img/blog/weaIconSunny.png"></span> <br> 좋음</p>
													</c:if>
												</c:forEach>
											</c:if>
											
											<c:if test="${!empty cloudyRegionArr && cloudyRegionArr != null}">
												<c:forEach var="cloudyArr" items="${cloudyRegionArr}">
													<c:set var="cloudyVal" value="${cloudyArr}" />
													<c:if test="${fn:contains(addr1, cloudyVal) || fn:contains(addr2, cloudyVal)}">
														<p class="date"><span><img src="<%= ctxPath%>/resources/img/blog/weaIconCloudy.png"></span> <br> 흐림</p>
													</c:if>
												</c:forEach>
											</c:if>
											
											<c:if test="${!empty badRegionArr && badRegionArr != null}">
												<c:forEach var="badArr" items="${badRegionArr}">
													<c:set var="badVal" value="${badArr}" />
													<c:if test="${fn:contains(addr1, badVal) || fn:contains(addr2, badVal)}">
														<p class="date"><span><img src="<%= ctxPath%>/resources/img/blog/weaIconBad.png"></span> <br> 나쁨</p>
													</c:if>
												</c:forEach>
											</c:if>
											
											<div class="meta-top d-flex">
												<p><span class="fa fa-location-arrow"></span> ${accvo.region_name}</p>
												<p class="ml-20"><span class="fa fa-calendar"></span> ${accvo.acc_type}</p>
											</div>
											<h4>${accvo.acc_name}</h4>
											<p>
												${accvo.acc_text}
											</p>
											<a href="<%= request.getContextPath() %>/accommodation/accView.we?acc_idx=${accvo.acc_idx}" class="primary-btn">Read More</a>
										</div>
									</div>
								</c:forEach>
							</c:if>
							<c:if test="${empty accList || accList == null}">
								<h4 style="margin: 5% auto;">검색 결과가 없습니다.</h4>
							</c:if>
							<%-- 결과 리스트 반복 부분 끝 --%>
							
						</div>
						<%-- 결과 리스트 나오는 부분 끝 --%>
						
						<%-- 페이지바 부분 --%>
                        <nav class="blog-pagination justify-content-center d-flex">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a href="#" class="page-link" aria-label="Previous">
                                        <span aria-hidden="true">
                                            <span class="lnr lnr-chevron-left"></span>
                                        </span>
                                    </a>
                                </li>
                                <li class="page-item"><a href="#" class="page-link">01</a></li>
                                <li class="page-item active"><a href="#" class="page-link">02</a></li>
                                <li class="page-item"><a href="#" class="page-link">03</a></li>
                                <li class="page-item"><a href="#" class="page-link">04</a></li>
                                <li class="page-item"><a href="#" class="page-link">09</a></li>
                                <li class="page-item">
                                    <a href="#" class="page-link" aria-label="Next">
                                        <span aria-hidden="true">
                                            <span class="lnr lnr-chevron-right"></span>
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        
                        
                    </div>
                </div>

                
                
<%-- ***************** 사이드 검색바 ******************  --%>
			<div class="col-lg-4" style="margin-bottom: 30px;">
				<div class="blog_right_sidebar">

<%-- >>> 호텔 종류까지의 사이드바 폼 시작 <<< --%>
<form name="blendedSearchFrm">

					<%-- ============= 검색바 시작 ================ --%>
					<aside class="single_sidebar_widget search_widget author_widget">
                            <h3 style="margin-bottom: 50px;">Blended Search</h3>
                            <div style="margin-bottom: 20px;" class="input-group">
	                            <div class="input-group">
	                                <input type="text" id="blendSearchWord" name="blendSearchWord" class="form-control" placeholder="Where?">
	                                <span class="input-group-btn">
	                                    <button class="btn btn-default" type="button"><i class="lnr lnr-cross"></i></button>
	                                </span>
	                            </div>
	                            <%-- 검색어 자동 완성: 검색어 입력 부분 --%>
								<div class="searchWordListWrapper" style="overflow: auto; width:100%; background: linear-gradient(90deg, #ff2f8b 0%, #9035f9 100%);
																		  margin: 0 auto; height: 150px; position: absolute; padding: 1px; border-radius: 10px;
																		  margin-top: 37px; z-index: 300;">
									<div class="searchWordListInner" style="background-color: white; width: 100%; height: 99.9%; border-radius: 10px;"></div>
								</div>
                            </div>
							<%-- 체크인 박스 --%>
                            <div class="media post_item" style="margin-bottom: 15px;">
                                <img class="book_start" src="<%= ctxPath%>/resources/img/blog/listicon3.png" style="cursor: pointer;">
                                <input type="text" name="book_start" class="book_start" class="form-control" readonly style="border-left: 1px solid #ced4da; width: 100px; margin: 2px 8px 0px 8px; height: 24px; background-color: white; cursor: pointer;"/>
                                <div class="media-body" style="text-align: left;">
                                    <a class="book_start" style="cursor: pointer;">
                                        <h5 style="margin: 3px 0px 0px 10px;">Check-in</h5>
                                    </a>
                                </div>
                            </div>
                            
                            <%-- 체크아웃 박스 --%>
                            <div class="media post_item" style="margin-bottom: 7px; cursor: pointer;">
                                <img class="book_end" src="<%= ctxPath%>/resources/img/blog/listicon3.png" style="cursor: pointer;">
                                <input type="text" name="book_end" class="book_end" class="form-control" readonly style="border-left: 1px solid #ced4da; width: 100px; margin: 2px 8px 0px 8px; height: 24px; background-color: white; cursor: pointer;"/>
                                <div class="media-body" style="text-align: left;">
                                    <a class="book_end" style="cursor: pointer;">
                                        <h5 style="margin: 3px 0px 0px 10px;">Check-out</h5>
                                    </a>
                                </div>
                            </div>
                            
                            <%-- 숙박일 미정 체크박스 --%>
                            <div style="float: left; margin: 0px 10px 30px 0px;"><label for="undecidedDates" style="cursor: pointer;">숙박일 미정</label></div>
                            <div class="primary-checkbox" style="float: left; margin: 3px 0px 20px 0px;">
									<input type="checkbox" id="undecidedDates">
									<label for="undecidedDates"></label>
							</div>
							
                            <%-- 날씨 --%>
                            <div class="media post_item" style="clear: both;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding: 7px 12px 0px 0px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left; margin: 0px 0px 8px 10px;">
                                   <h6 style="display: inline; padding-right: 12px;">Weather</h6>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="blendWeatherOpt" id="blendWeatherOpt">
											<option value="">선택</option>
											<c:if test="${blendWeatherOpt == 'sunny'}">
												<option value="sunny" selected>좋음</option>
												<option value="cloudy">흐림</option>
												<option value="bad">나쁨</option>
											</c:if>
											<c:if test="${blendWeatherOpt == 'cloudy'}">
												<option value="sunny">좋음</option>
												<option value="cloudy" selected>흐림</option>
												<option value="bad">나쁨</option>
											</c:if>
											<c:if test="${blendWeatherOpt == 'bad'}">
												<option value="sunny">좋음</option>
												<option value="cloudy">흐림</option>
												<option value="bad" selected>나쁨</option>
											</c:if>
											<c:if test="${empty blendWeatherOpt || blendWeatherOpt == null || blendWeatherOpt == ''}">
												<option value="sunny">좋음</option>
												<option value="cloudy">흐림</option>
												<option value="bad">나쁨</option>
											</c:if>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="media post_item"style="padding: 7px 0 20px 0;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon4.png" style="padding: 7px 12px 0px 0px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left; margin: 0px 0px 8px 10px;">
									<h6 style="display: inline; padding-right: 30px;">Term</h6>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="blendWeatherDaysOpt" id="blendWeatherDaysOpt">
											<option value="">선택</option>
											<c:if test="${blendWeatherDaysOpt == '0'}">
												<option value="0" selected>현재</option>
												<option value="3">3일후</option>
											</c:if>
											<c:if test="${blendWeatherDaysOpt == '3'}">
												<option value="0">현재</option>
												<option value="3" selected>3일후</option>
											</c:if>
											<c:if test="${empty blendWeatherDaysOpt || blendWeatherDaysOpt == null || blendWeatherDaysOpt == ''}">
												<option value="0">현재</option>
												<option value="3">3일후</option>
											</c:if>
										</select>
									</div>
                                </div>
                            </div>
                            <%-- 날씨 히든인풋. 이건 value로 꽂으면 값이 안 들어가서, 히든에 꽂아줘야 됨. 제이쿼리에서는 컨트롤러에서 보낸 값을 못 받아서 jstl 써야됨. --%>
                            <c:if test="${not empty sunnyRegionAjax && sunnyRegionAjax != null && sunnyRegionAjax != ''}">
                            	<input type="hidden" name="sunny" id="sunnyWeather" value="${sunnyRegionAjax}"/>
                            </c:if>
                            <c:if test="${not empty cloudyRegionAjax && cloudyRegionAjax != null && cloudyRegionAjax != ''}">
                            	<input type="hidden" name="cloudy" id="cloudyWeather" value="${cloudyRegionAjax}"/>
                            </c:if>
                            <c:if test="${not empty badRegionAjax && badRegionAjax != null && badRegionAjax != ''}">
                            	<input type="hidden" name="bad" id="badWeather" value="${badRegionAjax}"/>
                            </c:if>
                            <c:if test="${(empty sunnyRegionAjax || sunnyRegionAjax == null || sunnyRegionAjax == '') &&
                            			  (empty cloudyRegionAjax || cloudyRegionAjax == null || cloudyRegionAjax == '') &&
                            			  (empty badRegionAjax || badRegionAjax == null || badRegionAjax == '')}">
	                            <input type="hidden" name="sunny" id="sunnyWeather" />
								<input type="hidden" name="cloudy" id="cloudyWeather" />
								<input type="hidden" name="bad" id="badWeather" />
                            </c:if>
                            
                            <%-- 성인, 어린이 셀렉트 박스 --%>
                            <div class="media post_item" style="padding-top: 7px;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding: 7px 12px 0px 0px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left; margin: 0px 0px 8px 10px;">
                                   <div style="display: inline; padding-right: 38px; color: black; font-weight: 600;">어른</div>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="adultNum">
											<option value="">선택</option>
											<c:forEach begin="1" end="4" step="1" varStatus="status">
												<option value="${status.count}" ${status.count==adultNum?'selected':''}>${status.count}명</option>
											</c:forEach>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="media post_item" style="padding: 7px 0 20px 0;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding: 7px 12px 0px 0px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left; margin: 0px 0px 8px 10px;">
                                   <div style="display: inline; padding-right: 38px; color: black; font-weight: 600;">아이</div>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="kidsNum">
											<option value="">선택</option>
											<c:forEach begin="1" end="4" step="1" varStatus="status">
												<option value="${status.count}" ${status.count==kidsNum?'selected':''}>${status.count}명</option>
											</c:forEach>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="media post_item" style="padding-bottom: 30px;">
								<div class="widget price" style="width: 94%; text-align: center;">
									<div class="widget-desc">
										<div class="slider-range">
											<div data-min="0" data-max="777777" data-unit=" &#8361;" class="slider-range-price ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all" data-value-min="0" data-value-max="777777" data-label-result="Price:">
												<div class="ui-slider-range ui-widget-header ui-corner-all"></div>
												<span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0" style="margin-left: 0px;"></span>
												<span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0" style="margin-left: 0px;"></span>
											</div>
											<c:if test="${(not empty accListPrice1 && accListPrice1 !=null && accListPrice1 != '') &&
														  (empty accListPrice2 || accListPrice2 == null || accListPrice2 == '')}">
												<div class="range-price">Price: <fmt:formatNumber value="${accListPrice1}" maxFractionDigits="3" /> - 777,777 &#8361;</div>
												<input type="hidden" class="accListPrice1" name="accListPrice1" value="${accListPrice1}" />
												<input type="hidden" class="accListPrice2" name="accListPrice2" value="" />
											</c:if>
											<c:if test="${(empty accListPrice1 || accListPrice1 ==null || accListPrice1 == '') &&
														  (not empty accListPrice2 && accListPrice2 != null && accListPrice2 != '')}">
												<div class="range-price">Price: 0 - <fmt:formatNumber value="${accListPrice2}" maxFractionDigits="3" /> &#8361;</div>
												<input type="hidden" class="accListPrice1" name="accListPrice1" value="" />
												<input type="hidden" class="accListPrice2" name="accListPrice2" value="${accListPrice2}" />
											</c:if>
											<c:if test="${(not empty accListPrice1 && accListPrice1 !=null && accListPrice1 != '') &&
														  (not empty accListPrice2 && accListPrice2 != null && accListPrice2 != '')}">
												<div class="range-price">Price: <fmt:formatNumber value="${accListPrice1}" maxFractionDigits="3" /> - <fmt:formatNumber value="${accListPrice2}" maxFractionDigits="3" /> &#8361;</div>
												<input type="hidden" class="accListPrice1" name="accListPrice1" value="${accListPrice1}" />
												<input type="hidden" class="accListPrice2" name="accListPrice2" value="${accListPrice2}" />
											</c:if>
											<c:if test="${(empty accListPrice1 || accListPrice1 ==null || accListPrice1 == '') &&
														  (empty accListPrice2 || accListPrice2 == null || accListPrice2 == '')}">
												<div class="range-price">Price: 0 - 777,777 &#8361;</div>
												<input type="hidden" class="accListPrice1" name="accListPrice1" value="" />
												<input type="hidden" class="accListPrice2" name="accListPrice2" value="" />
											</c:if>
										</div>
									</div>
								</div>
                            </div>
                            
                            <%-- 통합검색 제출 버튼 --%>
                            <div class="newsletter_widget" style="clear: both;">
								<a id="blendedSearchBtn" style="cursor: pointer;" class="bbtns">Search</a>
                            </div>

                            <div class="br"></div>
					</aside>
						<%-- ============= 검색바 끝 ================ --%>


						<%-- ============= 호텔 등급 옵션 ============= --%>
                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title">Star Rating</h4>
                            <ul class="list cat-list">
                            <c:forEach begin="1" end="5" step="1" varStatus="status">
                                <li>
									<div class="d-flex justify-content-between">
										<label for="primary-checkbox${status.end-status.count+1}" style="margin-bottom: 0; cursor: pointer;">
											<a class="gradeListAnchor">${status.end-status.count+1}</a>
											<c:if test="${empty accGradeCntList || accGradeCntList == null}">
												<a>${status.end-status.count+1}-Star (0)</a>
											</c:if>
										</label>
										<div class="primary-checkbox">
											<input type="checkbox" name="acc_grade" id="primary-checkbox${status.end-status.count+1}" value="${status.end-status.count+1}" />
											<label for="primary-checkbox${status.end-status.count+1}" style="margin-bottom: 0;"></label><%-- 이거 없으면 체크박스 체크 안 됨;; --%>
										</div>
									</div>
                                </li>
                            </c:forEach>
                            </ul>
                            <div class="br"></div>
                        </aside>
                            	
						<%-- ============= 호텔 종류 옵션 ============= --%>
                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title">Accommodation Type</h4>
                            <ul class="list cat-list">
                               <li>
								<div class="d-flex justify-content-between">
									<label for="hotel" style="margin-bottom: 0; cursor: pointer;">
									<c:if test="${!empty accTypeCntList && accTypeCntList != null}">
										<c:forEach var="accTypeCnt" items="${accTypeCntList}" >
											<c:if test="${accTypeCnt.acc_type == '호텔'}">
												<a>호텔 (${accTypeCnt.CNT})</a>
											</c:if>
										</c:forEach>
									</c:if>
									<c:if test="${empty accTypeCntList || accTypeCntList == null}">
										<a>호텔 (0)</a>
									</c:if>
									</label>
									<div class="primary-checkbox">
										<input type="checkbox" name="acc_type" id="hotel" value="호텔" checked>
										<label for="hotel" style="margin-bottom: 0;"></label><%-- 이거 없으면 체크박스 체크 안 됨;; --%>
									</div>
								</div>
                               </li>
                               <li>
								<div class="d-flex justify-content-between">
									<label for="resort" style="margin-bottom: 0; cursor: pointer;">
									<c:if test="${!empty accTypeCntList && accTypeCntList != null}">
										<c:forEach var="accTypeCnt" items="${accTypeCntList}" >
											<c:if test="${accTypeCnt.acc_type == '리조트'}">
												<a>리조트 (${accTypeCnt.CNT})</a>
											</c:if>
										</c:forEach>
									</c:if>
									<c:if test="${empty accTypeCntList || accTypeCntList == null}">
										<a>리조트 (0)</a>
									</c:if>
									</label>
									<div class="primary-checkbox">
										<input type="checkbox" name="acc_type" id="resort" value="리조트" checked>
										<label for="resort" style="margin-bottom: 0;"></label><%-- 이거 없으면 체크박스 체크 안 됨;; --%>
									</div>
								</div>
                               </li>
                            </ul>
                            <div class="br"></div>
                        </aside>
</form>
<%-- >>> 호텔 종류까지의 사이드바 폼 끝 <<< --%>

<%-- ************* 태그 클라우드 *************************** --%>
                        <aside class="single-sidebar-widget tag_cloud_widget">
                            <h4 class="widget_title">Tag Clouds</h4>
                            <ul class="list">
                                <li><a href="#">Technology</a></li>
                                <li><a href="#">Fashion</a></li>
                                <li><a href="#">Architecture</a></li>
                                <li><a href="#">Fashion</a></li>
                                <li><a href="#">Food</a></li>
                                <li><a href="#">Technology</a></li>
                                <li><a href="#">Lifestyle</a></li>
                                <li><a href="#">Art</a></li>
                                <li><a href="#">Adventure</a></li>
                                <li><a href="#">Food</a></li>
                                <li><a href="#">Lifestyle</a></li>
                                <li><a href="#">Adventure</a></li>
                            </ul>
                        </aside>
<%-- ************* 태그 클라우드 *************************** --%>

                    </div>
                </div>
                
		</div>
	</div>
</section>



<%-- 가격바 슬라이드 관련 js --%>
<script src="<%= request.getContextPath()%>/resources/js/plugins.js"></script>
<script src="<%= request.getContextPath()%>/resources/js/active.js"></script>
                            	