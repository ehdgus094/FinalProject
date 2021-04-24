package com.naver.myhome.main.domain;

public class BoardReply {
	private int num;
	private String member_id;
	private int comment_num;
	private String content;
	private String reply_date;
	private int reply_like;
	private int reply_report;
	private String name;
	private String profile_img;
	private String login_type;
	private String likeOnOff;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public int getReply_like() {
		return reply_like;
	}
	public void setReply_like(int reply_like) {
		this.reply_like = reply_like;
	}
	public int getReply_report() {
		return reply_report;
	}
	public void setReply_report(int reply_report) {
		this.reply_report = reply_report;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getLogin_type() {
		return login_type;
	}
	public void setLogin_type(String login_type) {
		this.login_type = login_type;
	}
	public String getLikeOnOff() {
		return likeOnOff;
	}
	public void setLikeOnOff(String likeOnOff) {
		this.likeOnOff = likeOnOff;
	}
	
}
