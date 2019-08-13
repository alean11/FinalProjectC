<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#headerSearchBarBtn").click(function(){
			goAccList();
		}); // end of 검색바 click ------
				
	    $("#headerSearchBarBtn").keydown(function(event){
			if(event.keyCode == 13) { // 엔터를 했을 경우
				goAccList();
			}
		}); // end of 검색바 엔터 ----------------------
		
	}); // end of document ------
	
	
	function goAccList() {
		var frm = document.searchBarFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/accommodation/accList.we";
		frm.submit();
	} // end of 통합검색 ---------------


</script>


<%-- ======= #25. tile1 중 header 페이지 만들기  ======= --%>

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