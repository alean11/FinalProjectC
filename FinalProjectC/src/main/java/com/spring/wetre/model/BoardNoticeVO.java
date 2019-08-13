package com.spring.wetre.model;

// === #51. VO 생성하기
public class BoardNoticeVO {

	private String n_idx;          // 글번호 
	private String n_title;      // 글제목
	private String n_context;      // 글내용 
	private String n_viewcnt;    // 글조회수
	private String n_writeday;      // 글쓴시간
	private String status;       // 글삭제여부   1:사용가능한 글,  0:삭제된글 
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	
	
	public BoardNoticeVO() {}



	public BoardNoticeVO(String n_idx, String n_title, String n_context, String n_viewcnt, String n_writeday,
			String status, String previousseq, String previoussubject, String nextseq, String nextsubject) {
		super();
		this.n_idx = n_idx;
		this.n_title = n_title;
		this.n_context = n_context;
		this.n_viewcnt = n_viewcnt;
		this.n_writeday = n_writeday;
		this.status = status;
		this.previousseq = previousseq;
		this.previoussubject = previoussubject;
		this.nextseq = nextseq;
		this.nextsubject = nextsubject;
	}



	public String getN_idx() {
		return n_idx;
	}



	public void setN_idx(String n_idx) {
		this.n_idx = n_idx;
	}



	public String getN_title() {
		return n_title;
	}



	public void setN_title(String n_title) {
		this.n_title = n_title;
	}



	public String getN_context() {
		return n_context;
	}



	public void setN_context(String n_context) {
		this.n_context = n_context;
	}



	public String getN_viewcnt() {
		return n_viewcnt;
	}



	public void setN_viewcnt(String n_viewcnt) {
		this.n_viewcnt = n_viewcnt;
	}



	public String getN_writeday() {
		return n_writeday;
	}



	public void setN_writeday(String n_writeday) {
		this.n_writeday = n_writeday;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getPreviousseq() {
		return previousseq;
	}



	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}



	public String getPrevioussubject() {
		return previoussubject;
	}



	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}



	public String getNextseq() {
		return nextseq;
	}



	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}



	public String getNextsubject() {
		return nextsubject;
	}



	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}
	
	
	
}
