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
    #table th, #table td {width: 100%; padding: 5px;}
    #table tr:first-child {border-bottom: #9035f9 1px solid;
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


<div style="padding-left: 10%; margin-bottom: 50px; width:100%; border: none; float: center;">
	
	<table id="table" style="word-wrap: break-word; table-layout: fixed;">
	
    <tr>
        <th style="width:10%;">TITLE</th>
        <th style="text-align: left;color: #555; width:20%;">${boardvo.q_title}</th>
        <th style="width:10%;">WRITEDATE</th>
        <th style="width: 30%;color: #555;">${boardvo.q_writeday}</th>
        <th style="width:10%;">VIEWCOUNT</th>
        <th style="color: #555; width:20%;">${boardvo.q_viewcnt}</th>
    <tr>
    	<th id="content" colspan="6" style="font-weight: normal;">${boardvo.q_context}</th>
    </tr>
    </table>
   
 
	
	<br/>
	<div style="margin: 40px;">
	<div style="margin-bottom: 1%; width: 30%; float: left;">PREVIOUS : <span class="move hover" onClick="javascript:location.href='view.we?qna_idx=${boardvo.previousseq}'">${boardvo.previoussubject}</span></div>
	<div style="margin-bottom: 1%; width: 30%; float: right;">NEXT : <span class="move hover" onClick="javascript:location.href='view.we?qna_idx=${boardvo.nextseq}'">${boardvo.nextsubject}</span>
	
	</div>
	</div>
	
	<br/>
	
	<div>
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/qnaList.we'">목록보기</button> 
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/edit.we?qna_idx=${boardvo.qna_idx}'">수정</button>
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/del.we?qna_idx=${boardvo.qna_idx}'">삭제</button>
	<button type="button" class="bbtns" onClick="javascript:location.href='<%= request.getContextPath() %>/qna/qnaAdd.we?fk_qna_seq=${boardvo.qna_idx}&groupno=${boardvo.groupno}&depthno=${boardvo.depthno+1}'">답변글쓰기</button> 
	</div>
	
</div>

