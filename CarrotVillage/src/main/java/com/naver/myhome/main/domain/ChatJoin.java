package com.naver.myhome.main.domain;

public class ChatJoin {
	private int num;
	private String member_id;
	private int chat_room_num;
	
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
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
}
