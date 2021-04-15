package com.naver.myhome.main.Service;

import java.util.Map;
import java.util.List;

import com.naver.myhome.main.domain.Member;

public interface MemberService {
        
    public int insert(Member member);
    public int memberChk(String field, String value, String login_type);
    public int passwordChk(String id, String password);
    public Member memberInfo(String id);
	public Member memberInfo(String field, String value, String login_type);
	public int memberUpdate(Member member);
	public List<Member> memberSearch(Map<String, String> map);
	public int existRoom(List<String> chatMembers);
	public int insertRoom(List<String> chatMembers);
	public List<Map<String, Object>> roomList(String id);
}
