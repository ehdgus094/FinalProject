package com.naver.myhome.main.domain;

public class ChatMessageJoin {
	private int num;
	private String member_id;
	private int chat_room_num;
	private String message;
	private String chat_date;
	
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
	public int getChat_room_num() {
		return chat_room_num;
	}
	public void setChat_room_num(int chat_room_num) {
		this.chat_room_num = chat_room_num;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getChat_date() {
		return chat_date;
	}
	public void setChat_date(String chat_date) {
		this.chat_date = chat_date;
	}
	
}
