package com.naver.myhome.market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.market.domain.UsedItem;

@Repository
public class UsedItemDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insert(UsedItem usedItem) {
		return sqlSession.insert("UsedItem.insert", usedItem);
	}
	
	public List<UsedItem> select() {
		return sqlSession.selectList("UsedItem.select");
	}
}
