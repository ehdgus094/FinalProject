package com.naver.myhome.main.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.naver.myhome.main.dao.MemberDAO;
import com.naver.myhome.main.domain.ChatInvisible;
import com.naver.myhome.main.domain.ChatJoin;
import com.naver.myhome.main.domain.ChatMessage;
import com.naver.myhome.main.domain.ChatMessageJoin;
import com.naver.myhome.main.domain.ChatRoom;
import com.naver.myhome.main.domain.Member;
 
@Service
public class MemberServiceImpl implements MemberService {
    
	@Autowired
    MemberDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
    
	@Override
	public int insert(Member member) {
		return dao.insert(member);
	}
	
	@Override
	public int memberChk(String field, String value, String login_type) {
		Member member = memberInfo(field, value, login_type);
		return (member == null) ? -1 : 1;
	}

	@Override
	public int passwordChk(String id, String password) {
		
		Member member = memberInfo(id);
		int result = -1;
		if (member != null) {
			if (passwordEncoder.matches(password, member.getPassword())) {
				result = 1;
			} else {
				result = 0;
			}
		}
		
		return result;
	}

	@Override
	public Member memberInfo(String field, String value, String login_type) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("field", field);
		map.put("value", value);
		map.put("login_type", login_type);
		return dao.memberInfo(map);
	}
	
	@Override
	public Member memberInfo(String id) {
		return dao.memberInfo(id);
	}

	@Override
	public int memberUpdate(Member member) {
		return dao.memberUpdate(member);
	}
	
	@Override
	public int memberDelete(String id) {
		return dao.memberDelete(id);
	}

	@Override
	public List<Member> memberSearch(Map<String, String> map) {
		return dao.memberSearch(map);
	}

	@Override
	public ChatRoom existRoom(List<String> chatMembers) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id1", chatMembers.get(0));
		map.put("id2", chatMembers.get(1));
		
		ChatRoom cr = dao.existRoom(map);
		
		return cr;
	}

	@Override
	public ChatRoom insertRoom(List<String> chatMembers) {
		int result = dao.insertChatRoom(chatMembers.size());
		ChatRoom chatRoom = new ChatRoom();
		
		if (result == 1) {
			int lastChatRoomNum = dao.getLastChatRoomNum();
			chatRoom = dao.getChatRoomInfo(lastChatRoomNum);
			for (int i = 0; i < chatMembers.size(); i++) {
				ChatJoin cj = new ChatJoin();
				cj.setMember_id(chatMembers.get(i));
				cj.setChat_room_num(lastChatRoomNum);
				dao.insertChatJoin(cj);
			}
			
			ChatMessage cm = new ChatMessage();
			cm.setMessage(inviteMessage(chatMembers));
			cm.setMember_id("system");
			cm.setChat_room_num(lastChatRoomNum);
			dao.insertMessage(cm);
		}
		
		return chatRoom;
	}
	
	@Override
	public List<Map<String, Object>> roomList(String id) throws ParseException {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		List<ChatMessageJoin> chatJoinList = dao.roomList(id);
		
		for (int i = 0; i < chatJoinList.size(); i++) {
			Map <String, Object> map = new HashMap<String, Object>();
			int roomNum = chatJoinList.get(i).getChat_room_num();
			map.put("room_num", roomNum);
			map.put("last_message", chatJoinList.get(i).getMessage());
			
			String lastChatDate = chatJoinList.get(i).getChat_date();
			if (lastChatDate != null) {
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
				Date date = simpleDateFormat.parse(lastChatDate);
				String dateStr = date.getTime() + "";
				map.put("last_message_date", dateStr);
			}
			
			String roomMemberAllName = "";
			String roomMemberName = "";
			String roomMemberImage = "";
			List<ChatJoin> cjl = dao.roomMember(roomNum);
			for (int j = 0; j < cjl.size(); j++) {
				String roomMemberId = cjl.get(j).getMember_id();
				
				roomMemberAllName += ", " + dao.memberInfo(roomMemberId).getName();
				
				if (!roomMemberId.equals(id)) {
					
					String name = dao.memberInfo(roomMemberId).getName();
					roomMemberName += "," + name;
					
					if (j < 5) {
						String profile_img = dao.memberInfo(roomMemberId).getProfile_img();
						roomMemberImage += "," + profile_img;
					}
					
				}
				
			}
			roomMemberAllName = roomMemberAllName.substring(2);
			roomMemberName = roomMemberName.substring(1);
			roomMemberImage = roomMemberImage.substring(1);
			map.put("room_all_member", roomMemberAllName);
			map.put("room_member", roomMemberName);
			map.put("room_img", roomMemberImage);
			
			resultList.add(map);
		}
		
		return resultList;
	}

	@Override
	public int insertMessage(ChatMessage chatMessage) {
		return dao.insertMessage(chatMessage);
	}

	@Override
	public List<ChatMessage> messageList(int room_num) {
		return dao.messageList(room_num);
	}

	@Override
	public List<String> roomMember(int room_num) {
		List<String> resultList = new ArrayList<String>();
		List<ChatJoin> chatJoinList = dao.roomMember(room_num);
		for (int i = 0; i < chatJoinList.size(); i++) {
			resultList.add(chatJoinList.get(i).getMember_id());
		}
		return resultList;
	}
	
	public ChatRoom updateRoom(Map<String, Object> map) {
		@SuppressWarnings("unchecked")
		List<String> list = (List<String>) map.get("newMembers");
		int roomNum = (int)map.get("roomNum");
		
		list.removeAll(roomMember(roomNum));
		map.put("length", list.size());
		if (list.size() > 0) {
			dao.updateRoom(map);
			
			for (int i = 0; i < list.size(); i++) {
				ChatJoin chatJoin = new ChatJoin();
				chatJoin.setChat_room_num(roomNum);
				chatJoin.setMember_id(list.get(i));
				dao.insertChatJoin(chatJoin);
			}
			
			ChatMessage cm = new ChatMessage();
			list.add(0, (String) map.get("myId"));
			cm.setMessage(inviteMessage(list));
			cm.setMember_id("system");
			cm.setChat_room_num(roomNum);
			dao.insertMessage(cm);
		}
		
			
		return dao.getChatRoomInfo(roomNum);
	}
	
	public int updateRoomOut(String id, int room_num) {
		ChatJoin chatJoin = new ChatJoin();
		chatJoin.setChat_room_num(room_num);
		chatJoin.setMember_id(id);
		dao.deleteChatJoin(chatJoin);
		
		ChatMessage cm = new ChatMessage();
		cm.setMessage(dao.memberInfo(id).getName() + "님이 나가셨습니다.");
		cm.setMember_id("system");
		cm.setChat_room_num(room_num);
		dao.insertMessage(cm);
		
		return dao.updateRoomOut(room_num);
	}

	@Override
	public int insertChatInvisible(String id, int room_num) {
		ChatInvisible ci = new ChatInvisible();
		ci.setChat_room_num(room_num);
		ci.setMember_id(id);
		return dao.insertChatInvisible(ci);
	}

	@Override
	public int deleteChatInvisible(String id, int room_num) {
		ChatInvisible ci = new ChatInvisible();
		ci.setChat_room_num(room_num);
		ci.setMember_id(id);
		return dao.deleteChatInvisible(ci);
	}
	
	private String inviteMessage(List<String> list) {
		String systemMessage = "";
		
		for (int i = 0; i < list.size(); i++) {
			String name = dao.memberInfo(list.get(i)).getName();
			if (i == 0) {
				systemMessage += name + "님이 ";
			} else if (i > 0 && i < list.size()-1) {
				systemMessage += name + ", ";
			} else if (i == list.size()-1) {
				systemMessage += name + "님을 초대했습니다.";
			}

		}
		
		return systemMessage;
	}
	
}
