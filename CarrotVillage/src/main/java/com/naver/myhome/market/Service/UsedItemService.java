package com.naver.myhome.market.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.market.dao.UsedItemDAO;
import com.naver.myhome.market.domain.UsedItem;

@Service
public class UsedItemService {
	@Autowired
	private UsedItemDAO dao;
	
	public int insert(UsedItem usedItem) {
		return dao.insert(usedItem);
	}
	
	public List<UsedItem> select(Map<String, Object> map) {
		return dao.select(map);
	}
	
	public UsedItem detail(int num) {
		return dao.detail(num);
	}
	
	public void addViewcount(int num) {
		dao.addViewcount(num);
	}
	
	public int delete(int num) {
		return dao.delete(num);
	}
	
	public void update(UsedItem usedItem) {
		dao.update(usedItem);
	}
	
	public void updateSold(Map<String, Object> map) {
		dao.updateSold(map);
	}
	
	public void setWinner(String winner, int num) {
		dao.setWinner(winner, num);
	}
	
	public UsedItem getWinner(Map<String, Object> map) {
		return dao.getWinner(map);
	}
	
	public void test1(Map<String, Object> map) {
		dao.test1(map);
	}
}
