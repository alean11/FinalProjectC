package com.spring.wetre.model;

public class RtypeVO {

	private int rtype_idx;
	private int FK_acc_idx;
	private String rtype_Name;
	private int rtype_cnt;
	
	public RtypeVO() {}

	public RtypeVO(int fK_acc_idx, String rtype_Name, int rtype_cnt) {
		FK_acc_idx = fK_acc_idx;
		this.rtype_Name = rtype_Name;
		this.rtype_cnt = rtype_cnt;
	}
	public RtypeVO(int rtype_idx, int fK_acc_idx, String rtype_Name, int rtype_cnt) {
		super();
		this.rtype_idx = rtype_idx;
		FK_acc_idx = fK_acc_idx;
		this.rtype_Name = rtype_Name;
		this.rtype_cnt = rtype_cnt;
	}

	public int getRtype_idx() {
		return rtype_idx;
	}

	public void setRtype_idx(int rtype_idx) {
		this.rtype_idx = rtype_idx;
	}

	public int getFK_acc_idx() {
		return FK_acc_idx;
	}

	public void setFK_acc_idx(int fK_acc_idx) {
		FK_acc_idx = fK_acc_idx;
	}

	public String getRtype_Name() {
		return rtype_Name;
	}

	public void setRtype_Name(String rtype_Name) {
		this.rtype_Name = rtype_Name;
	}

	public int getRtype_cnt() {
		return rtype_cnt;
	}

	public void setRtype_cnt(int rtype_cnt) {
		this.rtype_cnt = rtype_cnt;
	}
	
	
}
