<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

	<!--================ Start About Area =================-->
	<section class="section_gap about-area">
		<div class="container">
			<div class="single-about row">
				<div class="col-lg-4 col-md-6 no-padding about-left">
					<div class="about-content">
						<h1>
							We Made <br>
							this beautiful <br>
							Web-Site
						</h1>
						<p>
							저희 조는 날씨를 기반으로 숙소검색이 가능한 웹페이지를 만들었습니다.
							주요 페이지에서는 날씨와 함께 여러 검색옵션을 통해 숙소 검색이 가능합니다.
							또한, 일반회원 뿐만 아니라 기업회원도 구분하여, 숙소의 등록 및 관리나 게시판 이용 등에서 차별화를 구현하였습니다.
						</p>
					</div>
				</div>
				<div class="col-lg-8 col-md-6 text-center no-padding about-right">
					<div class="about-thumb">
						<img src="<%= ctxPath%>/resources/img/about-img.jpg" class="img-fluid info-img" alt="">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================ End About Area =================-->

	<!--================Team Area =================-->
	<section class="team_area section_gap_top">
		<div class="container">
			<div class="row d-flex justify-content-center">
				<div class="col-lg-12">
					<div class="main_title">
						<p>We’re Offering these Trip Packages</p>
						<h1>Intelligent Team Members</h1>
						<span class="title-widget-bg"></span>
					</div>
				</div>
			</div>
			<div class="row team_inner">
				<div class="col-lg-4 col-md-6">
					<div class="team_item">
						<div class="team_img">
							<img class="img-fluid w-100" src="<%= ctxPath%>/resources/img/team/team-1.png" alt="">
							<div class="hover">
								<h4>박주희</h4>
								<p>메인, 날씨 페이지</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="team_item">
						<div class="team_img">
							<img class="img-fluid w-100" src="<%= ctxPath%>/resources/img/team/team-2.png" alt="">
							<div class="hover">
								<h4>정혜윤</h4>
								<p>숙소 목록, 결제 페이지, 전체 매니징</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="team_item">
						<div class="team_img">
							<img class="img-fluid w-100" src="<%= ctxPath%>/resources/img/team/team-3.png" alt="">
							<div class="hover">
								<h4>김명진</h4>
								<p>일반회원/기업회원 로그인, 상세보기 페이지</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="team_item">
						<div class="team_img">
							<img class="img-fluid w-100" src="<%= ctxPath%>/resources/img/team/team-4.png" alt="">
							<div class="hover">
								<h4>안혜민</h4>
								<p>일반회원 가입 및 정보수정, 게시판(공지사항, Q&A) 페이지</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="team_item">
						<div class="team_img">
							<img class="img-fluid w-100" src="<%= ctxPath%>/resources/img/team/team-5.png" alt="">
							<div class="hover">
								<h4>장건희</h4>
								<p>기업회원 가입 및 정보수정 , 호텔 등록, 객실등록 페이지</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="team_item">
						<div class="team_img">
							<img class="img-fluid w-100" src="<%= ctxPath%>/resources/img/team/team-6.png" alt="">
							<div class="hover">
								<h4>이영진</h4>
								<p>지도 검색, 예약, 예약내역 페이지, DB관리</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Team Area =================-->


	<!--================ Start Testimonials Area =================-->
	<section class="testimonials-area section_gap_bottom">
		<div class="container">
			<div class="testi-slider owl-carousel" data-slider-id="1">
				<div class="item">
					<div class="testi-item">
						<img src="<%= ctxPath%>/resources/img/quote.png" alt="">
						<h4>박주희</h4>
						<ul class="list">
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
						</ul>
						<div class="wow fadeIn" data-wow-duration="1s">
							<p>
								직접해보면서 잘 이해가 가지 않았던 부분을 다른 조원이 설명해주고 또 다시한번 같은내용을 응용해 봄으로써
								자신감이 붙은 것 같고 어떤 부분이 부족했는지에 대해 깨닫고 더 채워나갈 수 있는 시간이었습니다.
							</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="testi-item">
						<img src="<%= ctxPath%>/resources/img/quote.png" alt="">
						<h4>정혜윤</h4>
						<ul class="list">
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
						</ul>
						<div class="wow fadeIn" data-wow-duration="1s">
							<p>
								아..............
							</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="testi-item">
						<img src="<%= ctxPath%>/resources/img/quote.png" alt="">
						<h4>김명진</h4>
						<ul class="list">
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
						</ul>
						<div class="wow fadeIn" data-wow-duration="1s">
							<p>
								파이널프로젝트를 경험하면서 로그인 처리에 대한 AOP를 만들며 AOP에 대한 전반적인 흐름을 파악할 수 있었습니다. 
								또한, 상세페이지에서 코딩을 할때 주로 Ajax 기능을 사용하였는데 점점 사용빈도가 많아질수록 ajax를 활용하는 능력과
								자신감이 동시에 상승되는 것을 느꼈습니다. 마지막으로 파이널프로젝트를 통해 팀원간의 의사소통이 얼마나 중요한지를
								다시금 깨닫게 된 유익한 시간이었습니다.
							</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="testi-item">
						<img src="<%= ctxPath%>/resources/img/quote.png" alt="">
						<h4>안혜민</h4>
						<ul class="list">
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
						</ul>
						<div class="wow fadeIn" data-wow-duration="1s">
							<p>
								사이트를 만드는 것을 교육받는 것 이상으로 스스로 새로운 사이트를 구상하고 제작하는 과정의 험난함을 깨닫는 시간이었습니다.
								꼼꼼하고 섬세한 작업과 원활한 의사소통의 중요성을 깨닫는 좋은 기회였습니다!
								조원들의 도움을 받은 점이 많아 감사의 인사를 하고 싶고, 다음에는 제가 도움을 주는 사람이 될 수 있도록 노력해야겠습니다.
							</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="testi-item">
						<img src="<%= ctxPath%>/resources/img/quote.png" alt="">
						<h4>장건희</h4>
						<ul class="list">
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
						</ul>
						<div class="wow fadeIn" data-wow-duration="1s">
							<p>
								세미를 했던 경험을 토대로 삼아 하다보니 전체적인 진행은 좀 더 수월했고
								기능적인 부분은 여전히 어려웠지만 팀원들의 도움으로 잘 마무리 한것같고 실력이 조금은 늘은것 같아 좋은 경험을 한 것 같습니다.
							</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="testi-item">
						<img src="<%= ctxPath%>/resources/img/quote.png" alt="">
						<h4>이영진</h4>
						<ul class="list">
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
							<li><a href="#"><i class="fa fa-star"></i></a></li>
						</ul>
						<div class="wow fadeIn" data-wow-duration="1s">
							<p>
								신꼉써야 할 부분이 많아서 어려웠지만, 필요한 기능들을 검색하며 찾아 새로운 것을 배운다는 것이 좋았다.
								다음번에는 더욱 더 완성도 있게 만들고 싶다.
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="owl-thumbs d-flex justify-content-center" data-slider-id="1">
				<div class="owl-thumb-item">
					<div>
						<img class="img-fluid rounded-circle" src="<%= ctxPath%>/resources/img/testimonial/t1.png" alt="">
					</div>
					<div class="overlay overlay-grad "></div>
				</div>
				<div class="owl-thumb-item">
					<div>
						<img class="img-fluid rounded-circle" src="<%= ctxPath%>/resources/img/testimonial/t2.png" alt="">
					</div>
					<div class="overlay overlay-grad"></div>
				</div>
				<div class="owl-thumb-item">
					<div>
						<img class="img-fluid rounded-circle" src="<%= ctxPath%>/resources/img/testimonial/t3.png" alt="">
					</div>
					<div class="overlay overlay-grad"></div>
				</div>
				<div class="owl-thumb-item">
					<div>
						<img class="img-fluid rounded-circle" src="<%= ctxPath%>/resources/img/testimonial/t4.png" alt="">
					</div>
					<div class="overlay overlay-grad"></div>
				</div>
				<div class="owl-thumb-item">
					<div>
						<img class="img-fluid rounded-circle" src="<%= ctxPath%>/resources/img/testimonial/t5.png" alt="">
					</div>
					<div class="overlay overlay-grad"></div>
				</div>
				<div class="owl-thumb-item">
					<div>
						<img class="img-fluid rounded-circle" src="<%= ctxPath%>/resources/img/testimonial/t6.png" alt="">
					</div>
					<div class="overlay overlay-grad"></div>
				</div>
			</div>
		</div>
	</section>
	<!--================ End Testimonials Area =================-->
