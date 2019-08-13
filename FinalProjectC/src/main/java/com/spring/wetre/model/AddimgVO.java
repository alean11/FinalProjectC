package com.spring.wetre.model;

import org.springframework.web.multipart.MultipartFile;

public class AddimgVO {

	private String ad_img1;
	private String ad_img2;
	private String ad_img3;
	private String ad_img4;
	private String ad_img5;
	private int acc_idx;
	
	
	public int getAcc_idx() {
		return acc_idx;
	}


	public void setAcc_idx(int acc_idx) {
		this.acc_idx = acc_idx;
	}


	private MultipartFile attach1;
	private MultipartFile attach2;
	private MultipartFile attach3;
	private MultipartFile attach4;
	private MultipartFile attach5;
	
	 public AddimgVO() {}


	public AddimgVO(String ad_img1, String ad_img2, String ad_img3, String ad_img4, String ad_img5, int acc_idx,
			MultipartFile attach1, MultipartFile attach2, MultipartFile attach3, MultipartFile attach4,
			MultipartFile attach5) {
		super();
		this.ad_img1 = ad_img1;
		this.ad_img2 = ad_img2;
		this.ad_img3 = ad_img3;
		this.ad_img4 = ad_img4;
		this.ad_img5 = ad_img5;
		this.acc_idx = acc_idx;
		this.attach1 = attach1;
		this.attach2 = attach2;
		this.attach3 = attach3;
		this.attach4 = attach4;
		this.attach5 = attach5;
	}


	public String getAd_img1() {
		return ad_img1;
	}


	public void setAd_img1(String ad_img1) {
		this.ad_img1 = ad_img1;
	}


	public String getAd_img2() {
		return ad_img2; 
	}


	public void setAd_img2(String ad_img2) {
		this.ad_img2 = ad_img2;
	}


	public String getAd_img3() {
		return ad_img3;
	}


	public void setAd_img3(String ad_img3) {
		this.ad_img3 = ad_img3;
	}


	public String getAd_img4() {
		return ad_img4;
	}


	public void setAd_img4(String ad_img4) {
		this.ad_img4 = ad_img4;
	}


	public String getAd_img5() {
		return ad_img5;
	}


	public void setAd_img5(String ad_img5) {
		this.ad_img5 = ad_img5;
	}


	public MultipartFile getAttach1() {
		return attach1;
	}


	public void setAttach1(MultipartFile attach1) {
		this.attach1 = attach1;
	}


	public MultipartFile getAttach2() {
		return attach2;
	}


	public void setAttach2(MultipartFile attach2) {
		this.attach2 = attach2;
	}


	public MultipartFile getAttach3() {
		return attach3;
	}


	public void setAttach3(MultipartFile attach3) {
		this.attach3 = attach3;
	}


	public MultipartFile getAttach4() {
		return attach4;
	}


	public void setAttach4(MultipartFile attach4) {
		this.attach4 = attach4;
	}


	public MultipartFile getAttach5() {
		return attach5;
	}


	public void setAttach5(MultipartFile attach5) {
		this.attach5 = attach5;
	}
	 








}



 
 