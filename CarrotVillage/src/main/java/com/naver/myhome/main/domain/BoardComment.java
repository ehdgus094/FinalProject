package com.naver.myhome.main.domain;

public class BoardComment {
	private int num;
	private String member_id;
	private int board_num;
	private String content;
	private String comment_date;
	private int comment_like;
	private int comment_report;
	private String name;
	private String profile_img;
	private String login_type;
	private int replyListCount;
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
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	public int getComment_like() {
		return comment_like;
	}
	public void setComment_like(int comment_like) {
		this.comment_like = comment_like;
	}
	public int getComment_report() {
		return comment_report;
	}
	public void setComment_report(int comment_report) {
		this.comment_report = comment_report;
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
	public int getReplyListCount() {
		return replyListCount;
	}
	public void setReplyListCount(int replyListCount) {
		this.replyListCount = replyListCount;
	}
	public String getLikeOnOff() {
		return likeOnOff;
	}
	public void setLikeOnOff(String likeOnOff) {
		this.likeOnOff = likeOnOff;
	}
	
	
}
