package com.naver.myhome.main.Service;

import java.util.Map;
import java.text.ParseException;
import java.util.List;

import com.naver.myhome.main.domain.ChatMessage;
import com.naver.myhome.main.domain.ChatRoom;
import com.naver.myhome.main.domain.Member;

public interface MemberService {
        
    public int insert(Member member);
    public int memberChk(String field, String value, String login_type);
    public int passwordChk(String id, String password);
    public Member memberInfo(String id);
	public Member memberInfo(String field, String value, String login_type);
	public int memberUpdate(Member member);
	public int memberDelete(String id);
	public List<Member> memberSearch(Map<String, String> map);
	public ChatRoom existRoom(List<String> chatMembers);
	public ChatRoom insertRoom(List<String> chatMembers);
	public List<Map<String, Object>> roomList(String id) throws ParseException;
	public int insertMessage(ChatMessage chatMessage);
	public List<ChatMessage> messageList(int room_num);
	public List<String> roomMember(int room_num);
	public ChatRoom updateRoom(Map<String, Object> map);
	public int updateRoomOut(String id, int room_num);
	public int insertChatInvisible(String id, int room_num);
	public int deleteChatInvisible(String id, int room_num);
}
