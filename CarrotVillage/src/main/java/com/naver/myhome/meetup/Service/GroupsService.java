package com.naver.myhome.meetup.Service;

import java.util.List;

import com.naver.myhome.meetup.domain.Groups;
import com.naver.myhome.meetup.domain.Groups_join;
import com.naver.myhome.meetup.domain.Groups_like;


public interface GroupsService {
	
	public int make(Groups groups);

	public List<Groups> selectList(int page_view,String search_word);
	
	public List<Groups> selectListLike(int page_like,String search_word);
	
	public int getListCount();
	
	//public List<Groups> getSearchList(int page, int limit , String search_word );

	public Groups getDetail(int num);

	public int getViewCount(int num);

	public int modify(Groups groups);
	
	public int delete(int num);
	
	/*그룹참여하기*/
	public int groups_join(Groups_join groups_join);

	public List<Object> getJoinedMember(int num);

	public Groups_join id_check(Groups_join groups_join); 
	
	
	/*좋아요*/
	public Groups_like id_check2(Groups_like groups_like);

	public int create(Groups_like groups_like);

	public List<Object> getLikeCount(int groups_like_num);

	public int groups_like_delete(Groups_like groups_like);
	
}
