<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	*:focus {
    	outline: none;
	}
	table, th, td {border: none;}
    #table {width: 970px; border-collapse: collapse; border: none;}
    #table th, #table td {padding: 5px;}
    #table th {background-color: transparent; border-bottom: 1px dotted #9035f9; height: 40px;}
     
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer;} 
     .nice-select {
     float:none;
     width: 15%;
     display: inline-block;
    }              
</style>

<link rel="stylesheet" href="<%= ctxPath%>/resources/css/ahm_style.css">
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style.css">


<script type="text/javascript">
 $(document).ready(function(){
	
	$(".subject").bind("mouseover", function(event){
		var $target = $(event.target);
		$target.addClass("subjectStyle");
	});
	
	$(".subject").bind("mouseout", function(event){
		var $target = $(event.target);
		$target.removeClass("subjectStyle");
	});
	
	$("#searchWord").keydown(function(event) {
		 if(event.keyCode == 13) {
			 // 엔터를 했을 경우
			 goSearch();
		 }
	 });

/// 페이지 바 클릭 시 ///
    $(".pageBar").click(function(){
    	
    	$("#currentPageNo").val($(this).attr("currentPageNo"));
    	
    	goSearch();
    }); // end of 통합검색 폼 양식 보내기 ---------

	<!-- === #102. 검색어 입력시 자동글 완성하기 2 === -->
	$("#displayList").hide();
	
	$("#searchWord").keyup(function(){
		
		var form_data = { searchType:$("#searchType").val()
				         ,searchWord:$("#searchWord").val() };
		
		$.ajax({
			url:"<%= request.getContextPath()%>/wordSearchShowNotice.we",
			type:"GET",
			data:form_data,
			dataType:"JSON",
			success:function(json){
			
			<!-- === #107. 검색어 입력시 자동글 완성하기 7 === -->	
				if(json.length > 0) { 
					// 검색된 데이터가 있는 경우임. 만약에 조회된 데이터가 없을 경우 if(json == null) 이 아니고 if(json.length == 0) 이라고 써야 한다. 
					
					var html = "";
				
					$.each(json, function(entryIndex, item){
						var word = item.word;
						var index = word.toLowerCase().indexOf( $("#searchWord").val().toLowerCase() ); 
						//  alert("index : " + index);
						var len = $("#searchWord").val().length;
						var result = "";
						
						result = "<span class='first' style='color:blue;'>" +word.substr(0, index)+ "</span>" + "<span class='second' style='color:purple; font-weight:bold;'>" +word.substr(index, len)+ "</span>" + "<span class='third' style='color:black;'>" +word.substr(index+len, word.length - (index+len) )+ "</span>";  
						
						html += "<span style='cursor:pointer;'>"+ result +"</span><br/>"; 
					});
					
					$("#displayList").html(html);
					$("#displayList").show();
				}
				else {
					// 검색된 데이터가 존재하지 않을 경우
					$("#displayList").hide();
				} // end of if ~ else ----------------				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	});
	
	
	$("#displayList").click(function(event){
		var word = "";
		var $target = $(event.target);
		
		if($target.is(".first")) {
			word = $target.text() + $target.next().text() + $target.next().next().text();
		}
		else if($target.is(".second")) {
			word = $target.prev().text() + $target.text() + $target.next().text();
		}
		else if($target.is(".third")) {
			word = $target.prev().prev().text() + $target.prev().text() + $target.text();
		}
		
		$("#searchWord").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
		
		$("#displayList").hide();
		
		goSearch();
	});
	
 });
 
 function goView(n_idx) {
	
	 var frm = document.goViewFrm;
	 frm.n_idx.value = n_idx;
	 
	 frm.method = "GET";
	 frm.action = "viewNotice.we";
     frm.submit();
 }
 
 function goSearch() {
	var frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "<%= request.getContextPath()%>/noticeList.we";
	frm.submit();
 }
 
</script>  

<div class="body" style="padding-left: 3%; margin-bottom: 50px; width:80%;">
	<h2 style="margin: 30px auto; text-align: center;">Notice</h2>
	<h6 style="margin: 30px auto; text-align: center;">Please read me!</h6>
	
	<table id="table" style="padding-left: 3%; margin-bottom: 50px; width:100%;">
		<tr>
			<th style="width: 10%;  text-align: center;">No</th>
			<th style="width: 45%; text-align: center;">Title</th>
			<th style="width: 10%;  text-align: center;">Name</th>
			<th style="width: 25%; text-align: center;">Date</th>
			<th style="width: 10%;  text-align: center;">View</th>
		</tr>	
		<c:forEach var="noticevo" items="${boardList}" varStatus="status">
			<tr>
				<td align="center">${noticevo.n_idx}</td>
				<td align="left"> 
					   	  <span class="subject" onclick="goView('${noticevo.n_idx}');">${noticevo.n_title}</span>
				</td>
				<td align="center">관리자</td>
				<td align="center">${noticevo.n_writeday}</td>
				<td align="center">${noticevo.n_viewcnt}</td>
				
		    </tr>
		</c:forEach>
	</table>
	<br/>
	
	<form name="goViewFrm">
		<input type="hidden" name="n_idx"/>
		<input type="hidden" name="gobackURL" value="${gobackURL}"/> 
	</form>
	
		<form name="searchFrm" style="">
	<div class="blog_area container row">
	<input type="hidden" id="currentPageNo" name="currentPageNo" value=""/><%-- 페이지바 때문에 만듦. --%>
		<nav class="blog-pagination justify-content-center d-flex" style="margin: 0 auto;">
				<ul class="pagination">
				
				<c:if test="${prev != null && prev != 0 && prev != ''}">
					<li class="page-item">
						<a class="page-link" aria-label="Previous">
							<span aria-hidden="true">
								<span class="lnr lnr-chevron-left pageBar" currentPageNo="${prev}"></span>
							</span>
						</a>
					</li>
				</c:if>
				
				<c:if test="${pageNoList != null && pageNoList != ''}">
					<c:forEach var="pageNo" items="${pageNoList}">
						<c:if test="${pageNo == currentPageNo}">
							<li class="page-item active"><a class="page-link pageBar" currentPageNo="${pageNo}">${pageNo}</a></li>
						</c:if>
						<c:if test="${pageNo != currentPageNo}">
							<li class="page-item"><a class="page-link pageBar" currentPageNo="${pageNo}">${pageNo}</a></li>
						</c:if>
					</c:forEach>
				</c:if>

				<c:if test="${next != null && next != 0 && next != ''}">							
					<li class="page-item">
						<a href="#" class="page-link" aria-label="Next">
							<span aria-hidden="true">
								<span class="lnr lnr-chevron-right pageBar" currentPageNo="${next}"></span>
							</span>
						</a>
					</li>
				</c:if>
				
				</ul>
			</nav>
	</div>
	
	
	<div align="right" style="width: 100%; border: 0px solid gray; margin-left: 50px; margin-bottom: 20px; " >
	<button type="button" class="bbtns" onclick="javascript:location.href='notice/noticeAdd.we'">글쓰기</button>
	</div>
	<!-- === #96. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --> 
	<div style="width: 100%;" align="center">
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="n_title">글제목</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" class="form-control" placeholder="Keword, PLEASE!" size="40" autocomplete="off" /> 
		<button type="button" class="bbtns" onclick="goSearch()">검색</button>
		<div id="displayList" style="position:relative; width: 314px; height: 100px; overflow: auto; margin-left: 70px; margin-top: -1px; border-top: 0px; border: none;">
	</div>
</div>
	</form>
	</div>
	
	
  





