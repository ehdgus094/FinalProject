package com.naver.myhome.meetup.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.meetup.dao.GroupsDAO;
import com.naver.myhome.meetup.domain.Groups;

@Service
public class GroupsServiceImpl implements GroupsService{
	
	@Autowired
	private GroupsDAO dao;

	@Override
	public int make(Groups groups) {
		return dao.make(groups);
	}
	
	@Override
	public List<Groups> selectList(int page) {
		int startrow = 1;
		int endrow = page * 8;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.selectList(map);
	}
	
	@Override
	public List<Groups> selectListLike(int page) {
		int startrow = 1;
		int endrow = page * 8;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.selectListLike(map);
	}
	
	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Groups> getGroupsList(int page, int limit) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getGroupsList(map);
	}

	@Override
	public Groups getDetail(int num) {
		return dao.getDetail(num);
	}

	@Override
	public int getViewCount(int num) {
		return dao.getViewCount(num);
	}

	
	

}
