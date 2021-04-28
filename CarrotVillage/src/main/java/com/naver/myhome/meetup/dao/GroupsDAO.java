package com.naver.myhome.meetup.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.meetup.domain.Groups;
import com.naver.myhome.meetup.domain.Groups_join;
import com.naver.myhome.meetup.domain.Groups_like;

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

	public List<Groups> selectList(Map<String, Object> map) {
		return sqlSession.selectList("Groups.selectList", map);
	}
	
	public List<Groups> selectListLike(Map<String, Object> map) {
		return sqlSession.selectList("Groups.selectListLike", map);
	}

	/*
	 * public List<Groups> getSearchList(Map<String, Object> map) { return
	 * sqlSession.selectList("Groups.getSearchList", map); }
	 */

	public Groups getDetail(int num) {
		return sqlSession.selectOne("Groups.detail", num);
	}

	public int getListCount() {
		return sqlSession.selectOne("Groups.count");
	}

	public int getViewCount(int num) {
		return sqlSession.update("Groups.getViewCount", num);
	}

	public int modify(Groups groups) {
		return sqlSession.update("Groups.modify", groups);
	}
	
	public int delete(int num) {
		return sqlSession.delete("Groups.delete", num);
	}

	/*그룹참여하기*/
	public int groups_join(Groups_join groups_join) {
		return sqlSession.insert("Groups_join.groups_join", groups_join);
	}
	
	public List<Object> getJoinedMember(int groups_join_num) {
		return sqlSession.selectList("Groups_join.getJoinedMember", groups_join_num);
	}

	public Groups_join id_check(Groups_join groups_join) { //리턴타입다름
		return sqlSession.selectOne("Groups_join.id_check", groups_join);
	}

	/*좋아요*/
	public Groups_like id_check2(Groups_like groups_like) {
		//return sqlSession.selectOne("Groups_like.id_check2", groups_like);
		Groups_like r =sqlSession.selectOne("Groups_like.id_check2", groups_like);
		System.out.println(r);
		return r;
	}

	public int create(Groups_like groups_like) {
		return sqlSession.insert("Groups_like.create", groups_like);
	}

	public List<Object> getLikeCount(int groups_like_num) {
		return sqlSession.selectList("Groups_like.getLikeCount", groups_like_num);
	}

	public int groups_like_delete(Groups_like groups_like) {
		return sqlSession.delete("Groups_like.groups_like_delete", groups_like);
	}
	
}
