package com.naver.myhome.meetup.Service;

import java.util.List;

import com.naver.myhome.meetup.domain.Groups;


public interface GroupsService {
	
	public int make(Groups groups);

	public List<Groups> selectList(int page);
	
	public List<Groups> selectListLike(int page);
	
	public int getListCount();
	
	public List<Groups> getGroupsList(int page, int limit);

	public Groups getDetail(int num);

	public int getViewCount(int num);




	
}
