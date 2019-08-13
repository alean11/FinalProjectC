package com.spring.wetre.model;

public class BarmenityVO {

	private int r_idx;
	private String bm_br_addfee;
	private String bm_amenity;
	private String bm_device;
	
	public BarmenityVO() {}
	
	public BarmenityVO(String bm_br_addfee, String bm_amenity, String bm_device) {
		this.bm_br_addfee = bm_br_addfee;
		this.bm_amenity = bm_amenity;
		this.bm_device = bm_device;
	}
	public BarmenityVO(int r_idx, String bm_br_addfee, String bm_amenity, String bm_device) {
		super();
		this.r_idx = r_idx;
		this.bm_br_addfee = bm_br_addfee;
		this.bm_amenity = bm_amenity;
		this.bm_device = bm_device;
	}
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public String getBm_br_addfee() {
		return bm_br_addfee;
	}
	public void setBm_br_addfee(String bm_br_addfee) {
		this.bm_br_addfee = bm_br_addfee;
	}
	public String getBm_amenity() {
		return bm_amenity;
	}
	public void setBm_amenity(String bm_amenity) {
		this.bm_amenity = bm_amenity;
	}
	public String getBm_device() {
		return bm_device;
	}
	public void setBm_device(String bm_device) {
		this.bm_device = bm_device;
	}
	
	
}
