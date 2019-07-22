<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<%-- 가격바 스타일 관련 추가 --%>
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/chy_style.css">

<script type="text/javascript">

	$(document).ready(function(){
		
		/// 문서 로딩되자마자 날씨 api로 뽑아야됨 ///
		$.ajax({
			url: "<%= ctxPath%>/accommodation/kWeatherXML.we",
			type: "GET",
			dataType: "XML",
			success: function(xml){
				
				// [매칭기준] 우리 사이트 기준: 기상청 용어(강사님이 준 xml쪽 용어)
				// 좋음: 맑음
				// 흐림: 흐림, 구름많음
				// 나쁨: 비, 박무, 안개
				// 참고: http://www.weather.go.kr/HELP/html/help_fct008.jsp
				
				
				// 첫번째 태그 <current> 찾기
				var rootElement = $(xml).find(":root");
				// console.log($(rootElement).prop("tagName")); // ==> current
				
				// 세번째 태그 <local> 찾기
				var localArr = $(rootElement).find("local");
				
				var sunnyWeather = "";
				var cloudyWeather = "";
				var badWeather = "";
				var nthWeather = "";
				
				for(var i=0; i<localArr.length; i++) {
					
					var local = $(localArr).eq(i);
					
					// 날씨별 지역명 뽑자
					if( $(local).attr("desc") == "맑음" ) {
					//	console.log("맑음: "+$(local).text());
						sunnyWeather += $(local).text()+",";
					}
					else if( $(local).attr("desc") == "흐림" || $(local).attr("desc") == "구름많음" ) {
					//	console.log("흐림: "+$(local).text());
						cloudyWeather += $(local).text()+",";
					}
					else if ( $(local).attr("desc") == "비" || $(local).attr("desc") == "박무" || $(local).attr("desc") == "안개" ) {
					//	console.log("나쁨: "+$(local).text());
						badWeather += $(local).text()+",";
					}
					else {
						nthWeather += $(local).text()+",";
					}
					
				} // end of for -----------
				
				
				/// 지역 보내기 ///
				var region_data = { "sunny":sunnyWeather
								  , "cloudy":cloudyWeather
								  , "bad":badWeather
								  };
				$.ajax({
					url: "<%= ctxPath%>/accommodation/accList.we",
					type: "GET",
					data: region_data,
					success: function(){
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				}); // end of 지역 보내는 ajax --------
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of 문서 로딩되자마자 날씨 지역 뽑는 ajax --------
		
		
		
		/// 검색바 x 누르면 검색어 전부 삭제 ///
		$(".btn-default").click(function(){
			$("#blendSearchInput").val("");
		}); // end of 검색바 x -----------------
		
		
		
		/// 숙박일 미정 체크 시 check-in/out 박스 값 없애고 disabled 만들기
	    $("#undecidedDates").change(function(){
	    	
			if($("#undecidedDates").is(":checked")){
				$("#book_start").attr('disabled', true);
				$("#book_start").val("");
				$("#book_end").attr('disabled', true);
				$("#book_end").val("");
			}else{
				$("#book_start").attr('disabled', false);
				$("#book_end").attr('disabled', false);
			}
	        
	    }); // end of 숙박일 미정 체크 이벤트 ---------
		
		
		
		
		
	}); // end of document ready -----------------
	
	
	/// 통합검색 제출 함수 ///
	function goBlendedSearch() {

		// 값 선택 했는지 검사 해줘야됨. //
		
		
		var frm = document.blendedSearchFrm;
		
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/accommodation/accList.we";
		frm.submit();

	} // end of 통합검색 ---------------
	
	
	// 세부검색: (기존 검색상태를 유지/유지 안함.), 각 검색항목

	
	
	
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


               <div class="col-lg-8">
                    <div class="blog_left_sidebar">
                        <article class="row blog_item">
                            <div class="col-md-3">
                                <div class="blog_info text-right">
                                    <div class="post_tag">
                                        <a href="#">Food,</a>
                                        <a class="active" href="#">Technology,</a>
                                        <a href="#">Politics,</a>
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <ul class="blog_meta list">
                                        <li><a href="#">Mark wiens<i class="lnr lnr-user"></i></a></li>
                                        <li><a href="#">12 Dec, 2017<i class="lnr lnr-calendar-full"></i></a></li>
                                        <li><a href="#">1.2M Views<i class="lnr lnr-eye"></i></a></li>
                                        <li><a href="#">06 Comments<i class="lnr lnr-bubble"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="blog_post">
                                    <img src="<%= ctxPath%>/resources/img/blog/main-blog/m-blog-1.jpg" alt="">
                                    <div class="blog_details">
                                        <a href="single-blog.html">
                                            <h2>Astronomy Binoculars A Great Alternative</h2>
                                        </a>
                                        <p>MCSE boot camps have its supporters and its detractors. Some people do not
                                            understand why you should have to spend money on boot camp when you can get
                                            the MCSE study materials yourself at a fraction.</p>
                                        <a href="single-blog.html" class="blog_btn">View More</a>
                                    </div>
                                </div>
                            </div>
                        </article>
                        <article class="row blog_item">
                            <div class="col-md-3">
                                <div class="blog_info text-right">
                                    <div class="post_tag">
                                        <a href="#">Food,</a>
                                        <a class="active" href="#">Technology,</a>
                                        <a href="#">Politics,</a>
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <ul class="blog_meta list">
                                        <li><a href="#">Mark wiens<i class="lnr lnr-user"></i></a></li>
                                        <li><a href="#">12 Dec, 2017<i class="lnr lnr-calendar-full"></i></a></li>
                                        <li><a href="#">1.2M Views<i class="lnr lnr-eye"></i></a></li>
                                        <li><a href="#">06 Comments<i class="lnr lnr-bubble"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="blog_post">
                                    <img src="<%= ctxPath%>/resources/img/blog/main-blog/m-blog-2.jpg" alt="">
                                    <div class="blog_details">
                                        <a href="single-blog.html">
                                            <h2>The Basics Of Buying A Telescope</h2>
                                        </a>
                                        <p>MCSE boot camps have its supporters and its detractors. Some people do not
                                            understand why you should have to spend money on boot camp when you can get
                                            the MCSE study materials yourself at a fraction.</p>
                                        <a href="single-blog.html" class="blog_btn">View More</a>
                                    </div>
                                </div>
                            </div>
                        </article>
                        <article class="row blog_item">
                            <div class="col-md-3">
                                <div class="blog_info text-right">
                                    <div class="post_tag">
                                        <a href="#">Food,</a>
                                        <a class="active" href="#">Technology,</a>
                                        <a href="#">Politics,</a>
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <ul class="blog_meta list">
                                        <li><a href="#">Mark wiens<i class="lnr lnr-user"></i></a></li>
                                        <li><a href="#">12 Dec, 2017<i class="lnr lnr-calendar-full"></i></a></li>
                                        <li><a href="#">1.2M Views<i class="lnr lnr-eye"></i></a></li>
                                        <li><a href="#">06 Comments<i class="lnr lnr-bubble"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="blog_post">
                                    <img src="<%= ctxPath%>/resources/img/blog/main-blog/m-blog-3.jpg" alt="">
                                    <div class="blog_details">
                                        <a href="single-blog.html">
                                            <h2>The Glossary Of Telescopes</h2>
                                        </a>
                                        <p>MCSE boot camps have its supporters and its detractors. Some people do not
                                            understand why you should have to spend money on boot camp when you can get
                                            the MCSE study materials yourself at a fraction.</p>
                                        <a href="single-blog.html" class="blog_btn">View More</a>
                                    </div>
                                </div>
                            </div>
                        </article>
                        <article class="row blog_item">
                            <div class="col-md-3">
                                <div class="blog_info text-right">
                                    <div class="post_tag">
                                        <a href="#">Food,</a>
                                        <a class="active" href="#">Technology,</a>
                                        <a href="#">Politics,</a>
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <ul class="blog_meta list">
                                        <li><a href="#">Mark wiens<i class="lnr lnr-user"></i></a></li>
                                        <li><a href="#">12 Dec, 2017<i class="lnr lnr-calendar-full"></i></a></li>
                                        <li><a href="#">1.2M Views<i class="lnr lnr-eye"></i></a></li>
                                        <li><a href="#">06 Comments<i class="lnr lnr-bubble"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="blog_post">
                                    <img src="<%= ctxPath%>/resources/img/blog/main-blog/m-blog-4.jpg" alt="">
                                    <div class="blog_details">
                                        <a href="single-blog.html">
                                            <h2>The Night Sky</h2>
                                        </a>
                                        <p>MCSE boot camps have its supporters and its detractors. Some people do not
                                            understand why you should have to spend money on boot camp when you can get
                                            the MCSE study materials yourself at a fraction.</p>
                                        <a href="single-blog.html" class="blog_btn">View More</a>
                                    </div>
                                </div>
                            </div>
                        </article>
                        <article class="row blog_item">
                            <div class="col-md-3">
                                <div class="blog_info text-right">
                                    <div class="post_tag">
                                        <a href="#">Food,</a>
                                        <a class="active" href="#">Technology,</a>
                                        <a href="#">Politics,</a>
                                        <a href="#">Lifestyle</a>
                                    </div>
                                    <ul class="blog_meta list">
                                        <li><a href="#">Mark wiens<i class="lnr lnr-user"></i></a></li>
                                        <li><a href="#">12 Dec, 2017<i class="lnr lnr-calendar-full"></i></a></li>
                                        <li><a href="#">1.2M Views<i class="lnr lnr-eye"></i></a></li>
                                        <li><a href="#">06 Comments<i class="lnr lnr-bubble"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="blog_post">
                                    <img src="<%= ctxPath%>/resources/img/blog/main-blog/m-blog-5.jpg" alt="">
                                    <div class="blog_details">
                                        <a href="single-blog.html">
                                            <h2>Telescopes 101</h2>
                                        </a>
                                        <p>MCSE boot camps have its supporters and its detractors. Some people do not
                                            understand why you should have to spend money on boot camp when you can get
                                            the MCSE study materials yourself at a fraction.</p>
                                        <a href="single-blog.html" class="blog_btn">View More</a>
                                    </div>
                                </div>
                            </div>
                        </article>
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
                    
						<%-- ============= 검색바 시작 ================ --%>
					<aside class="single_sidebar_widget search_widget author_widget">
						<form name="blendedSearchFrm">
                            <h3 style="margin-bottom: 50px;">Blended Search</h3>
                            <div class="input-group" style="margin-bottom: 20px;">
                                <input type="text" name="blendSearchWord" class="form-control" placeholder="Where?">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="lnr lnr-cross"></i></button>
                                </span>
                            </div>
                            
							<%-- 체크인 박스 --%>
                            <div class="media post_item" style="margin-bottom: 15px;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon3.png">
                                <input type="text" name="book_start" id="book_start" class="form-control" readonly style="border-left: 1px solid #ced4da; width: 100px; margin: 2px 8px 0px 8px; height: 24px; background-color: white;"/>
                                <div class="media-body" style="text-align: left;">
                                    <a href="#">
                                        <h5 style="margin: 3px 0px 0px 10px;">Check-in</h5>
                                    </a>
                                </div>
                            </div>
                            
                            <%-- 체크아웃 박스 --%>
                            <div class="media post_item" style="margin-bottom: 7px;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon3.png">
                                <input type="text" name="book_end" id="book_end" class="form-control" readonly style="border-left: 1px solid #ced4da; width: 100px; margin: 2px 8px 0px 8px; height: 24px; background-color: white;"/>
                                <div class="media-body" style="text-align: left;">
                                    <a href="#">
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

                            <%-- 성인, 어린이 셀렉트 박스 --%>
                            <div class="media post_item" style="clear: both;">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding-top: 7px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left; margin: 0px 0px 8px 10px;">
                                   <div style="display: inline; padding-right: 38px; color: black; font-weight: 600;">어른</div>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="ay_fee">
											<option value="1">1명</option>
											<option value="2">2명</option>
											<option value="3">3명</option>
											<option value="4">4명</option>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="media post_item">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding-top: 7px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left; margin: 0px 0px 8px 10px;">
                                   <div style="display: inline; padding-right: 38px; color: black; font-weight: 600;">아이</div>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="k_fee">
											<option value="1">1명</option>
											<option value="2">2명</option>
											<option value="3">3명</option>
											<option value="4">4명</option>
										</select>
									</div>
                                </div>
                            </div>
                            
                            <%-- 날씨 --%>
                            <div class="media post_item">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding: 7px 12px 30px 0px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px; text-align: left;">
                                   <h6 style="display: inline; padding-right: 12px;">Weather</h6>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="blendWeatherOpt" id="blendWeatherOpt">
											<option value="sunny">좋음</option>
											<option value="cloudy">흐림</option>
											<option value="bad">나쁨</option>
										</select>
									</div>
                                </div>
                            </div>
                        </form>
                            
                            <%-- 상세검색 제출 버튼 --%>
                            <div class="newsletter_widget" style="clear: both;">
								<a onclick="goBlendedSearch();" class="bbtns">Search</a>
                            </div>

                            <div class="br"></div>
					</aside>
						<%-- ============= 검색바 끝 ================ --%>

						<%-- ============= 날씨 및 지역 옵션============= --%>
                        <aside class="single_sidebar_widget popular_post_widget author_widget">
                        	<h3 style="margin-bottom: 50px;">Advanced Search</h3>
                            <h3 class="widget_title">Weather & Region</h3>
                            <div class="media post_item">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon1.png" style="padding: 7px 0px 0px 15px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px;">
                                   <h3 style="display: inline; padding-right: 12px;">Weather</h3>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="advanceWeatherOpt" id="advanceWeatherOpt">
											<option value="sunny">좋음</option>
											<option value="cloudy">흐림</option>
											<option value="bad">나쁨</option>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="media post_item">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon2.png" style="padding: 7px 0px 0px 15px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px;">
									<h3 style="display: inline; padding-right: 20px;">Region</h3>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select name="region_code">
											<option value="" selected>지역</option>
											<c:if test="${!empty regionList}">
												<c:forEach var="regionMap" items="${regionList}">
												<option value="${regionMap.reCode}">${regionMap.reShotName}</option>
												</c:forEach>
											</c:if>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="media post_item">
                                <img src="<%= ctxPath%>/resources/img/blog/listicon4.png" style="padding: 7px 0px 0px 15px;">
                                <div class="media-body" style="width: 250px; padding-left: 0px;">
									<h3 style="display: inline; padding-right: 30px;">Term</h3>
									<div class="default-select" style="width: 130px; display: inline-flex;">
										<select>
											<option value="">단기</option><%-- 날씨API의 단기,중기 결정하는 키의 밸류값을 여기 밸류에 적어줘야 함. --%>
											<option value="">중기</option>
										</select>
									</div>
                                </div>
                            </div>
                            <div class="br"></div>
                        </aside>

						<%-- ============= 호텔 등급 옵션 ============= --%>
                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title">Star Rating</h4>
                            <ul class="list cat-list">
                            <c:forEach begin="1" end="5" step="1" varStatus="status">
                                <li>
								<div class="d-flex justify-content-between">
									<label for="primary-checkbox${status.end-status.count+1}" style="margin-bottom: 0; cursor: pointer;"><a>${status.end-status.count+1}-Star</a></label>
									<div class="primary-checkbox">
										<c:if test="${status.end-status.count+1 == 5}">
											<input type="checkbox" id="primary-checkbox${status.end-status.count+1}" checked>
										</c:if>
										<c:if test="${status.end-status.count+1 != 5}">
											<input type="checkbox" id="primary-checkbox${status.end-status.count+1}">
										</c:if>
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
									<label for="hotel" style="margin-bottom: 0; cursor: pointer;"><a>호텔</a></label>
									<div class="primary-checkbox">
										<input type="checkbox" id="hotel" value="호텔" checked>
										<label for="hotel" style="margin-bottom: 0;"></label><%-- 이거 없으면 체크박스 체크 안 됨;; --%>
									</div>
								</div>
                               </li>
                               <li>
								<div class="d-flex justify-content-between">
									<label for="resort" style="margin-bottom: 0; cursor: pointer;"><a>리조트</a></label>
									<div class="primary-checkbox">
										<input type="checkbox" id="resort" value="리조트" checked>
										<label for="resort" style="margin-bottom: 0;"></label><%-- 이거 없으면 체크박스 체크 안 됨;; --%>
									</div>
								</div>
                               </li>
                            </ul>
                            <div class="br"></div>
                        </aside>

                        <%-- ============= 가격 옵션 슬라이드바 ============= --%>
                        <aside class="single_sidebar_widget popular_post_widget">
                            <h3 class="widget_title">Filter by Price</h3>
                            <div class="media post_item">

							<div class="widget price" style="width: 94%; text-align: center;">
								<div class="widget-desc">
									<div class="slider-range">
										<div data-min="0" data-max="3000000" data-unit=" &#8361;" class="slider-range-price ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all" data-value-min="0" data-value-max="3000000" data-label-result="Price:">
											<div class="ui-slider-range ui-widget-header ui-corner-all"></div>
											<span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0" style="margin-left: 0px;"></span>
											<span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0" style="margin-left: 0px;"></span>
										</div>
									<div class="range-price">Price: 0 - 3,000,000 &#8361;</div>
									<%-- 나중에 DB에 보낼 때는 콤마 빼야함. --%>
									</div>
								</div>
							</div>
							

                            </div>
                            <div class="br"></div>
                        </aside>
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
