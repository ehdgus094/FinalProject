package com.naver.myhome.market.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.market.domain.Candidate;

@Repository
public class CandidateDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public Candidate select(int num, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("id", id);
		return sqlSession.selectOne("Candidate.select", map);
	}
	
	public int insert(int num, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("id", id);
		return sqlSession.insert("Candidate.insert", map);
	}
	
	public List<Candidate> selectList(int num) {
		return sqlSession.selectList("Candidate.selectList", num);
	}
	
	public void delete(int num) {
		sqlSession.delete("Candidate.delete", num);
	}
}