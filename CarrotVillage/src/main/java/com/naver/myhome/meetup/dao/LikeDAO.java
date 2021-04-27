package com.naver.myhome.meetup.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.meetup.domain.Groups_like;

@Repository
public class LikeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	public int countbyLike(HashMap<String, Object> hashMap) {
		return sqlSession.selectOne("Groups_like.countbyLike" , hashMap);
	}

	public int create(HashMap<String, Object> hashMap) {
		return sqlSession.insert("Groups_like.create" , hashMap);
	}

	public int like_check(HashMap<String, Object> hashMap) {
		return sqlSession.update("Groups_like.like_check" , hashMap);
	}

	public int like_check_cancel(HashMap<String, Object> hashMap) {
		return sqlSession.update("Groups_like.like_check_cancel" , hashMap);
	}

	public Groups_like getDetail (HashMap<String, Object> hashMap) {
		return sqlSession.selectOne("Groups_like.getDetail" , hashMap);
	}

	public int deletebyGroupsNum(int groups_num) {
		return sqlSession.delete("Groups_like.deletebyGroupsNum" , groups_num);
	}

	public int deletebyMemId(int mem_id) {
		return sqlSession.delete("Groups_like.deletebyMemId" , mem_id);
	}
	
	
}
