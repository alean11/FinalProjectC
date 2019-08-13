package com.spring.wetre.model;


public class CommentVO {
	
	private String acc_idx;      // 호텔번호
	private String seq;          // 댓글번호
	private String fk_userid;    // 사용자ID
	private String name;         // 성명
	private String comments;      // 댓글내용
	private String com_writedate;      // 작성일자
	private String parentSeq;    // 원게시물 글번호
	private String status;       // 글삭제여부
	
	public CommentVO() { }
	
	public CommentVO(String acc_idx, String seq, String fk_userid, String name, String comments, String com_writedate, String parentSeq, String status) {
		this.acc_idx = acc_idx;
		this.seq = seq;
		this.fk_userid = fk_userid;
		this.name = name;
		this.comments = comments;
		this.com_writedate = com_writedate;
		this.parentSeq = parentSeq;
		this.status = status;
	}
	
	
	public String getAcc_idx() {
		return acc_idx;
	}

	public void setAcc_idx(String acc_idx) {
		this.acc_idx = acc_idx;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getCom_writedate() {
		return com_writedate;
	}

	public void setCom_writedate(String com_writedate) {
		this.com_writedate = com_writedate;
	}

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}