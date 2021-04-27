package com.naver.myhome.meetup.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.meetup.dao.GroupsDAO;
import com.naver.myhome.meetup.domain.Groups;
import com.naver.myhome.meetup.domain.Groups_join;
import com.naver.myhome.meetup.domain.Groups_like;
import com.naver.myhome.meetup.domain.Review;

@Service
public class GroupsServiceImpl implements GroupsService{
	
	@Autowired
	private GroupsDAO dao;

	@Override
	public int make(Groups groups) {
		return dao.make(groups);
	}
	
	@Override
	public List<Groups> selectList(int page_view, String search_word) {
		int startrow = 1;
		int endrow = page_view * 8;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("search_word", "%" + search_word + "%");
		return dao.selectList(map);
	}
	
	@Override
	public List<Groups> selectListLike(int page_like, String search_word) {
		int startrow = 1;
		int endrow = page_like * 8;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("search_word", "%" + search_word + "%");
		return dao.selectListLike(map);
	}
	
	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	/*
	 * @Override public List<Groups> getSearchList(int page, int limit , String
	 * search_word) { Map<String, Object> map = new HashMap<String, Object>(); int
	 * startrow = (page-1)*limit+1; int endrow = startrow+limit-1; map.put("start",
	 * startrow); map.put("end", endrow); map.put("search_word", "%" + search_word +
	 * "%"); return dao.getSearchList(map); }
	 */

	@Override
	public Groups getDetail(int num) {
		return dao.getDetail(num);
	}

	@Override
	public int getViewCount(int num) {
		return dao.getViewCount(num);
	}


	@Override
	public int modify(Groups groups) {
		return dao.modify(groups);
	}

	@Override
	public int delete(int num) {
		return dao.delete(num);
	}
	
	/*그룹참여하기*/
	@Override
	public int groups_join(Groups_join groups_join) {
		return dao.groups_join(groups_join);
	}

	@Override
	public List<Object> getJoinedMember(int groups_join_num) {
		return dao.getJoinedMember(groups_join_num);
	}

	@Override
	public Groups_join id_check(Groups_join groups_join) {
		return dao.id_check(groups_join);
	}

	/*좋아요*/
	@Override
	public Groups_like id_check2(Groups_like groups_like) {
		return dao.id_check2(groups_like);
	}

	@Override
	public int create(Groups_like groups_like) {
		return dao.create(groups_like);
	}

	@Override
	public List<Object> getLikeCount(int groups_like_num) {
		return dao.getLikeCount(groups_like_num);
	}

	@Override
	public int groups_like_delete(Groups_like groups_like) {
		return dao.groups_like_delete(groups_like);
	}
	
}
