package com.spring.wetre.model;

public class RoomVO {
	private int r_idx;
	private int FK_acc_idx;
	private String FK_rtype_idx;
	private String r_text;	
	private int ay_fee;
	private int k_fee;
	
	public RoomVO() {}
	public RoomVO(int fK_acc_idx, String r_text, int ay_fee, int k_fee) {
		FK_acc_idx = fK_acc_idx;
		this.r_text = r_text;
		this.ay_fee = ay_fee;
		this.k_fee = k_fee;
	}
	public RoomVO(int r_idx, int fK_acc_idx, String fK_rtype_idx, String r_text, int ay_fee, int k_fee) {
		super();
		this.r_idx = r_idx;
		FK_acc_idx = fK_acc_idx;
		FK_rtype_idx = fK_rtype_idx;
		this.r_text = r_text;
		this.ay_fee = ay_fee;
		this.k_fee = k_fee;
	}
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public int getFK_acc_idx() {
		return FK_acc_idx;
	}
	public void setFK_acc_idx(int fK_acc_idx) {
		FK_acc_idx = fK_acc_idx;
	}
	public String getFK_rtype_idx() {
		return FK_rtype_idx;
	}
	public void setFK_rtype_idx(String fK_rtype_idx) {
		FK_rtype_idx = fK_rtype_idx;
	}
	public String getR_text() {
		return r_text;
	}
	public void setR_text(String r_text) {
		this.r_text = r_text;
	}
	public int getAy_fee() {
		return ay_fee;
	}
	public void setAy_fee(int ay_fee) {
		this.ay_fee = ay_fee;
	}
	public int getK_fee() {
		return k_fee;
	}
	public void setK_fee(int k_fee) {
		this.k_fee = k_fee;
	}
	
	
	
	

}
