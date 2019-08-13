package com.spring.wetre.model;

// === #51. VO 생성하기
public class BoardVO {

	private String qna_idx;          // 글번호 
	private String p_userid;    // 사용자ID
	private String q_writer;         // 글쓴이 
	private String q_title;      // 글제목
	private String q_context;      // 글내용 
	private String q_pwd;           // 글암호
	private String q_viewcnt;    // 글조회수
	private String q_writeday;      // 글쓴시간
	private String status;       // 글삭제여부   1:사용가능한 글,  0:삭제된글 
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	private String groupno;
	private String fk_qna_seq;
	private String depthno;
	
	
	public BoardVO() {
	}


	public BoardVO(String qna_idx, String p_userid, String q_writer, String q_title, String q_context, String q_pwd,
			String q_viewcnt, String q_writeday, String status, String previousseq, String previoussubject,
			String nextseq, String nextsubject, String groupno, String fk_qna_seq, String depthno) {
		super();
		this.qna_idx = qna_idx;
		this.p_userid = p_userid;
		this.q_writer = q_writer;
		this.q_title = q_title;
		this.q_context = q_context;
		this.q_pwd = q_pwd;
		this.q_viewcnt = q_viewcnt;
		this.q_writeday = q_writeday;
		this.status = status;
		this.previousseq = previousseq;
		this.previoussubject = previoussubject;
		this.nextseq = nextseq;
		this.nextsubject = nextsubject;
		this.groupno = groupno;
		this.fk_qna_seq = fk_qna_seq;
		this.depthno = depthno;
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






	public String getQna_idx() {
		return qna_idx;
	}



	public void setQna_idx(String qna_idx) {
		this.qna_idx = qna_idx;
	}



	public String getP_userid() {
		return p_userid;
	}



	public void setP_userid(String p_userid) {
		this.p_userid = p_userid;
	}



	public String getQ_writer() {
		return q_writer;
	}



	public void setQ_writer(String q_writer) {
		this.q_writer = q_writer;
	}



	public String getQ_title() {
		return q_title;
	}



	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}



	public String getQ_context() {
		return q_context;
	}



	public void setQ_context(String q_context) {
		this.q_context = q_context;
	}



	public String getQ_pwd() {
		return q_pwd;
	}



	public void setQ_pwd(String q_pwd) {
		this.q_pwd = q_pwd;
	}



	public String getQ_viewcnt() {
		return q_viewcnt;
	}



	public void setQ_viewcnt(String q_viewcnt) {
		this.q_viewcnt = q_viewcnt;
	}



	public String getQ_writeday() {
		return q_writeday;
	}



	public void setQ_writeday(String q_writeday) {
		this.q_writeday = q_writeday;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getGroupno() {
		return groupno;
	}



	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}



	public String getFk_qna_seq() {
		return fk_qna_seq;
	}



	public void setFk_qna_seq(String fk_qna_seq) {
		this.fk_qna_seq = fk_qna_seq;
	}



	public String getDepthno() {
		return depthno;
	}



	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}
	
	
	
}
