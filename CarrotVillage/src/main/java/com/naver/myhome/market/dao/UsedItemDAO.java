package com.naver.myhome.market.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.market.domain.UsedItem;

@Repository
public class UsedItemDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insert(UsedItem usedItem) {
		sqlSession.insert("UsedItem.insert", usedItem);
		return usedItem.getNum();
	}
	
	public List<UsedItem> select(Map<String, Object> map) {
		return sqlSession.selectList("UsedItem.select", map);
	}
	
	public UsedItem detail(int num) {
		return sqlSession.selectOne("UsedItem.detail", num);
	}
	
	public void addViewcount(int num) {
		sqlSession.update("UsedItem.addViewcount", num);
	}
	
	public int delete(int num) {
		return sqlSession.delete("UsedItem.delete", num);
	}
	
	public void update(UsedItem usedItem) {
		sqlSession.update("UsedItem.update", usedItem);
	}
	
	public void updateSold(Map<String, Object> map) {
		sqlSession.update("UsedItem.updateSold", map);
	}
	
	public void setWinner(String winner, int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("winner", winner);
		map.put("num", num);
		sqlSession.update("UsedItem.setWinner", map);
	}
	
	public UsedItem getWinner(Map<String, Object> map) {
		return sqlSession.selectOne("UsedItem.getWinner", map);
	}
}
