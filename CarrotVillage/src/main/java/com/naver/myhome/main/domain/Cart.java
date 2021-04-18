package com.naver.myhome.main.domain;

import javax.websocket.Session;

public class Cart {
	private Session session;
	private Member member;
	
	public Session getSession() {
		return session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
}
