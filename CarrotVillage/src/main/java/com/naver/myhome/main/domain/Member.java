package com.naver.myhome.main.domain;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private String id;
	private String password;
	private String email;
	private String name;
	private String post;
	private String address;
	private String phone_num;
	private String birth;
	private String gender;
	private String profile_img = "${pageContext.request.contextPath}/resources/image/nhj_profile.png";
	private String profile_img_ori;
	private int subscribe;
	private String subscribe_name;
	private String regi_date;
	private String auth_lev;
	private String is_seller;
	private String login_type;
	
	private MultipartFile uploadfile;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone_num() {
		return phone_num;
	}

	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
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

	public int getSubscribe() {
		return subscribe;
	}

	public void setSubscribe(int subscribe) {
		this.subscribe = subscribe;
	}

	public String getSubscribe_name() {
		return subscribe_name;
	}

	public void setSubscribe_name(String subscribe_name) {
		this.subscribe_name = subscribe_name;
	}

	public String getRegi_date() {
		return regi_date;
	}

	public void setRegi_date(String regi_date) {
		this.regi_date = regi_date;
	}

	public String getAuth_lev() {
		return auth_lev;
	}

	public void setAuth_lev(String auth_lev) {
		this.auth_lev = auth_lev;
	}

	public String getIs_seller() {
		return is_seller;
	}

	public void setIs_seller(String is_seller) {
		this.is_seller = is_seller;
	}

	public String getLogin_type() {
		return login_type;
	}

	public void setLogin_type(String login_type) {
		this.login_type = login_type;
	}

	public MultipartFile getUploadfile() {
		return uploadfile;
	}

	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}
	
}
