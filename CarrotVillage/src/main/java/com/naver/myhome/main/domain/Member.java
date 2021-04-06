package com.naver.myhome.main.domain;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private int num;
	private String name;
	private String password;
	private String email;
	private String regi_date;
	private String profile_img;
	private String profile_img_ori;
	private MultipartFile uploadfile;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRegi_date() {
		return regi_date;
	}
	public void setRegi_date(String regi_date) {
		this.regi_date = regi_date;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getProfile_img_ori() {
		return profile_img_ori;
	}
	public void setProfile_img_ori(String profile_img_ori) {
		this.profile_img_ori = profile_img_ori;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
}
