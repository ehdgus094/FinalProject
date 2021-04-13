package com.naver.myhome.main.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
    
}
