package com.naver.myhome.main.dao;

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
		return sqlSession.selectOne("member.selectone", map);
	}
 
}
