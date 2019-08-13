<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style type="text/css">

	#table {
	margin-top: 30px;
	}
	table, th, td, input, textarea {border: none;}
    #table {width: 970px; border-collapse: collapse; border: none;}
    #table th, #table td {width: 80%; padding: 5px;}
    #table tr:first-child {border-bottom: #9035f9 1px dotted;
    					   line-height: 50px; text-align: center;}
   	#table th:last-child { padding: 20px;
   	}
	
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	a {text-decoration: none !important;}
	.hover:hover {
  color: #23527c;
  cursor: pointer;
}
</style>

<link rel="stylesheet" href="<%= ctxPath%>/resources/css/ahm_style.css">
<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style.css">


<div style="padding-left: 10%; margin-bottom: 50px; width:80%; border: none;">
	
	<table id="table" style="word-wrap: break-word; table-layout: fixed;">
	
	    <tr>
	        <th style="width:10%;">TITLE</th>
	        <th style="text-align: left;color: #555; width:20%;">${noticevo.n_title}</th>
	        <th style="width:10%;">WRITEDATE</th>
	        <th style="width: 130px;color: #555; width:20%;">${noticevo.n_writeday}</th>
	        <th style="width:10%;">VIEWCOUNT</th>
	        <th style="width: 130px;color: #555; width:20%;">${noticevo.n_viewcnt}</th>
	    <tr>
	    	<th id="content" colspan="6" style="font-weight: normal;">${noticevo.n_context}</th>
	    </tr>
	 </table>
   
 
	
	<br/>
	<div style="margin: 40px auto;">
	<div style="margin-bottom: 1%; width: 30%; float: left;">PREVIOUS : <span class="move hover" onClick="javascript:location.href='viewNotice.we?n_idx=${noticevo.previousseq}'">${noticevo.previoussubject}</span></div>
	<div style="margin-bottom: 1%; width: 30%; float: right;">NEXT : <span class="move hover" onClick="javascript:location.href='viewNotice.we?n_idx=${noticevo.nextseq}'">${noticevo.nextsubject}</span></div>
	</div>
	<br/>
	<div style="width:100%;">
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/noticeList.we'">목록보기</button> 
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/noticeEdit.we?n_idx=${noticevo.n_idx}'">수정</button>
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/delNotice.we?n_idx=${noticevo.n_idx}'">삭제</button>
	</div>
</div>


