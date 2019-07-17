package com.spring.wetre.model;

public class AccVO {

	private int acc_idx;
	private String cp_id;
	private int state;
	private String acc_name;
	private String acc_tel1;
	private String acc_tel2;
	private String acc_tel3;
	private String acc_post1;
	private String acc_post2;
	private String acc_addr1;
	private String acc_addr2;
	private String acc_img;
	private String acc_text;
	private int acc_Rcnt;
	private int acc_status;
	
	public AccVO() {}
	
	public AccVO(int acc_idx, String cp_id, int state, String acc_name, String acc_tel1, String acc_tel2,
			String acc_tel3, String acc_post1, String acc_post2, String acc_addr1, String acc_addr2, String acc_img,
			String acc_text, int acc_Rcnt, int acc_status) {
		this.acc_idx = acc_idx;
		this.cp_id = cp_id;
		this.state = state;
		this.acc_name = acc_name;
		this.acc_tel1 = acc_tel1;
		this.acc_tel2 = acc_tel2;
		this.acc_tel3 = acc_tel3;
		this.acc_post1 = acc_post1;
		this.acc_post2 = acc_post2;
		this.acc_addr1 = acc_addr1;
		this.acc_addr2 = acc_addr2;
		this.acc_img = acc_img;
		this.acc_text = acc_text;
		this.acc_Rcnt = acc_Rcnt;
		this.acc_status = acc_status;
	}

	public int getAcc_idx() {
		return acc_idx;
	}

	public void setAcc_idx(int acc_idx) {
		this.acc_idx = acc_idx;
	}

	public String getCp_id() {
		return cp_id;
	}

	public void setCp_id(String cp_id) {
		this.cp_id = cp_id;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getAcc_name() {
		return acc_name;
	}

	public void setAcc_name(String acc_name) {
		this.acc_name = acc_name;
	}

	public String getAcc_tel1() {
		return acc_tel1;
	}

	public void setAcc_tel1(String acc_tel1) {
		this.acc_tel1 = acc_tel1;
	}

	public String getAcc_tel2() {
		return acc_tel2;
	}

	public void setAcc_tel2(String acc_tel2) {
		this.acc_tel2 = acc_tel2;
	}

	public String getAcc_tel3() {
		return acc_tel3;
	}

	public void setAcc_tel3(String acc_tel3) {
		this.acc_tel3 = acc_tel3;
	}

	public String getAcc_post1() {
		return acc_post1;
	}

	public void setAcc_post1(String acc_post1) {
		this.acc_post1 = acc_post1;
	}

	public String getAcc_post2() {
		return acc_post2;
	}

	public void setAcc_post2(String acc_post2) {
		this.acc_post2 = acc_post2;
	}

	public String getAcc_addr1() {
		return acc_addr1;
	}

	public void setAcc_addr1(String acc_addr1) {
		this.acc_addr1 = acc_addr1;
	}

	public String getAcc_addr2() {
		return acc_addr2;
	}

	public void setAcc_addr2(String acc_addr2) {
		this.acc_addr2 = acc_addr2;
	}

	public String getAcc_img() {
		return acc_img;
	}

	public void setAcc_img(String acc_img) {
		this.acc_img = acc_img;
	}

	public String getAcc_text() {
		return acc_text;
	}

	public void setAcc_text(String acc_text) {
		this.acc_text = acc_text;
	}

	public int getAcc_Rcnt() {
		return acc_Rcnt;
	}

	public void setAcc_Rcnt(int acc_Rcnt) {
		this.acc_Rcnt = acc_Rcnt;
	}

	public int getAcc_status() {
		return acc_status;
	}

	public void setAcc_status(int acc_status) {
		this.acc_status = acc_status;
	}
	
	
	
}
