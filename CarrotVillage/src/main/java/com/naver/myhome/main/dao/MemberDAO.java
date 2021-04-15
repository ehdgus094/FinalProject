package com.naver.myhome.main.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.main.domain.ChatJoin;
import com.naver.myhome.main.domain.ChatRoom;
import com.naver.myhome.main.domain.Member;

@Repository
public class MemberDAO {
	 
	@Autowired
	private SqlSessionTemplate sqlSession;
	
    public int insert(Member member) {
    	return sqlSession.insert("member.insert", member);
    }
    
    public Member memberInfo(Map<String, String> map) {
		return sqlSession.selectOne("member.memberInfo", map);
	}
    
    public Member memberInfo(String id) {
    	return sqlSession.selectOne("member.memberInfoId", id);
    }

	public int memberUpdate(Member member) {
		return sqlSession.update("member.update", member);
	}

	public List<Member> memberSearch(Map<String, String> map) {
		return sqlSession.selectList("member.search", map);
	}

	public ChatRoom existRoom(Map<String, Object> map) {
		return sqlSession.selectOne("member.existRoom", map);
	}
	
	public int insertChatRoom(int numOf) {
		return sqlSession.insert("member.insertChatRoom", numOf);
	}
	
	public int getLastChatRoomNum() {
		return sqlSession.selectOne("member.getLastChatRoomNum");
	}
	
	public int insertChatJoin(ChatJoin cj) {
		return sqlSession.insert("member.insertChatJoin", cj);
	}
    
	public List<ChatJoin> roomList(String id) {
		return sqlSession.selectList("member.roomList", id);
	}
	
	public List<ChatJoin> roomMember(int roomNum) {
		return sqlSession.selectList("member.roomMember", roomNum);
	}
}
