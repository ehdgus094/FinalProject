package com.naver.myhome.main.Controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.naver.myhome.main.domain.Cart;
import com.naver.myhome.main.domain.Member;

@Controller
@ServerEndpoint(value="/boot.do")  //클라이언트가 접속할 서버 주소
public class EchoHandler {
	static final List<Cart> sessionList 
							= Collections.synchronizedList(new ArrayList<Cart>());
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	public EchoHandler() {
		logger.info("웹소켓(서버) 객체생성");
	}
	
	/*
	 * @OnOpen 은 클라이언트가 웹소켓에 들어오고 서버에 아무런 문제 없이 들어왔을 때 실행하는 메소드입니다.
	 */
	@OnOpen
	public void onOpen(Session session) throws UnsupportedEncodingException {
		logger.info("Open session id : " + session.getId());
		String queryString = URLDecoder.decode(session.getQueryString(), "UTF-8");
		logger.info("session 쿼리 스트링 : " + queryString);
		
		String id = queryString.substring(queryString.indexOf("id") + 3, queryString.indexOf("name") - 1);
		String name = queryString.substring(queryString.indexOf("name") + 5, queryString.indexOf("profile_img") - 1);
		String profile_img = queryString.substring(queryString.indexOf("profile_img") + 12, queryString.indexOf("login_type") - 1);
		String login_type = queryString.substring(queryString.indexOf("login_type") + 11);
	    
		Member member = new Member();
		member.setId(id);member.setName(name);
		member.setProfile_img(profile_img);
		member.setLogin_type(login_type);

		Cart cart = new Cart();
		cart.setSession(session);
		cart.setMember(member);

		sessionList.add(cart);

		// String message = id + "님이 입장하셨습니다.in";
		// sendAllSessionToMessage(session, message);
	}
	
	//보낸 사람 정보(id와 파일이름) 구하기
	private String getInfo(Session self) {
		String information = "";
		synchronized (sessionList) {
			for (Cart cart : EchoHandler.sessionList) {
				Session s = cart.getSession();
				if (self.getId().equals(s.getId())) {
					information = cart.getMember().getId() + "&" + cart.getMember().getName() 
								+ "&" + cart.getMember().getProfile_img() 
								+ "&" + cart.getMember().getLogin_type();
					logger.info("보낸 사람의 정보 = " + information);
					break;
				}				
			}
		}
		return information;
	}
	
	
	private void sendMessage(Session self, String message) {
		if (message.equals("")) {
			synchronized (sessionList) {
				try {
					for (Cart cart : EchoHandler.sessionList) {
						
						Session s = cart.getSession();
						if (!self.getId().equals(s.getId())) { // 나를 제외한 사람에게 보냅니다.
							s.getBasicRemote().sendText("");
						}
					}
				} catch (Exception e) {
					logger.info("sendMessage 오류 " + e.getMessage());
				}
			}
		} else {
			String info = getInfo(self);
			String message1 = message.substring(0, message.lastIndexOf(" "));
			int roomNum = Integer.parseInt(message.substring(message.lastIndexOf(" ") + 1));
			
			synchronized (sessionList) {
				try {
					for (Cart cart : EchoHandler.sessionList) {
						
						Session s = cart.getSession();
						if (!self.getId().equals(s.getId())) { // 나를 제외한 사람에게 보냅니다.
							logger.info("보내는 메시지 : " + info + "&" + roomNum + "&" + message1);
							s.getBasicRemote().sendText(info + "&" + roomNum + "&" + message1);
						}
					}
				} catch (Exception e) {
					logger.info("sendMessage 오류 " + e.getMessage());
				}
			}
		}
		
	}

	/*
	 * @OnMessage 는 클라이언트에게 메시지가 들어왔을 때, 실행되는 메소드입니다.
	 * String geMessage에는 jsp의 ws.send()로 보낸 내용이 저장되어 있습니다.
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		logger.info("Message : " + message);
		sendMessage(session, message);
	}
	
	@OnError
	public void onError(Throwable e, Session session) {
		e.printStackTrace();
		logger.info("error입니다.");
		remove(session);
	}
	
	//@OnClose는 클라이언트와 웹소켓과의 연결이 끊기면 실행되는 메소드입니다.
	@OnClose
	public void onClose(Session session) {
		logger.info("Session " + session.getId() + " has ended");
		remove(session);
	}
	
	private void remove(Session session) {
		synchronized (sessionList) {
			for (int i = 0; i < sessionList.size(); i++) {
				Session s = sessionList.get(i).getSession();
				if (session.getId().equals(s.getId())) {  //나와 세션 아이디가 같은 cart를 제거합니다.
					sessionList.remove(i);
					return;
				}
			}
		}
	}
}
