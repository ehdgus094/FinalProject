package com.naver.myhome.main.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.naver.myhome.main.dao.MemberDAO;
import com.naver.myhome.main.domain.ChatJoin;
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
	public List<Member> memberSearch(Map<String, String> map) {
		return dao.memberSearch(map);
	}

	@Override
	public int existRoom(List<String> chatMembers) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("length", chatMembers.size());
		map.put("myId", chatMembers.get(0));
		chatMembers.remove(chatMembers.get(0));
		map.put("chatMembers", chatMembers);
		System.out.println("service myId = " + map.get("myId"));
		System.out.println("service chatMembers = " + map.get("chatMembers"));
		System.out.println("service length = " + map.get("length"));
		ChatRoom cr = dao.existRoom(map);
		chatMembers.add(0, (String) map.get("myId"));
		return (cr == null) ? 0 : 1;
	}

	@Override
	public int insertRoom(List<String> chatMembers) {
		for (int i = 0; i < chatMembers.size(); i++) {
			System.out.println("service insertRoom chatMembers = " + chatMembers.get(i));
		}
		int result = dao.insertChatRoom(chatMembers.size());
		
		if (result == 1) {
			int lastChatRoomNum = dao.getLastChatRoomNum();
			for (int i = 0; i < chatMembers.size(); i++) {
				ChatJoin cj = new ChatJoin();
				cj.setMember_id(chatMembers.get(i));
				cj.setChat_room_num(lastChatRoomNum);
				result = dao.insertChatJoin(cj);
			}
		}
		
		return result;
	}
	
	@Override
	public List<Map<String, Object>> roomList(String id) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		List<ChatJoin> chatJoinList = dao.roomList(id);
		
		for (int i = 0; i < chatJoinList.size(); i++) {
			Map <String, Object> map = new HashMap<String, Object>();
			int roomNum = chatJoinList.get(i).getChat_room_num();
			map.put("room_num", roomNum);
			
			String roomMemberName = "";
			List<ChatJoin> cjl = dao.roomMember(roomNum);
			for (int j = 0; j < cjl.size(); j++) {
				String roomMemberId = cjl.get(j).getMember_id();
				if (!roomMemberId.equals(id)) {
					String name = dao.memberInfo(roomMemberId).getName();
					roomMemberName += "," + name;
				}
			}
			
			roomMemberName = roomMemberName.substring(1);
			map.put("room_member", roomMemberName);
			resultList.add(map);
		}
		
		return resultList;
	}
	
}
