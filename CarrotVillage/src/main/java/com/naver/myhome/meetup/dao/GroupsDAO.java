package com.naver.myhome.meetup.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.meetup.domain.Groups;

@Repository
public class GroupsDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int make(Groups groups) {
		return sqlSession.insert("Groups.insert" , groups);
	}

	public Groups selectOne(String id) {
		return sqlSession.selectOne("Groups.selectOne" , id);
	}

	public List<Groups> selectList(Map<String, Integer> map) {
		return sqlSession.selectList("Groups.selectList", map);
	}
	
	public List<Groups> selectListLike(Map<String, Integer> map) {
		return sqlSession.selectList("Groups.selectListLike", map);
	}

	public List<Groups> getGroupsList(HashMap<String, Integer> map) {
		return sqlSession.selectList("Groups.list", map);
	}

	public Groups getDetail(int num) {
		return sqlSession.selectOne("Groups.detail", num);
	}

	public int getListCount() {
		return sqlSession.selectOne("Groups.count");
	}

	public int getViewCount(int num) {
		return sqlSession.update("Groups.getViewCount", num);
	}
	
}
