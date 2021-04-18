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
	public List<Member> memberSearch(Map<String, String> map);
	public Map<String, Object> existRoom(List<String> chatMembers);
	public ChatRoom insertRoom(List<String> chatMembers);
	public List<Map<String, Object>> roomList(String id) throws ParseException;
	public int insertMessage(ChatMessage chatMessage);
	public List<ChatMessage> messageList(int room_num);
}
