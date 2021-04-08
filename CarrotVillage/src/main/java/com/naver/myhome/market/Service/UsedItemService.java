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
	
	public List<UsedItem> select(Map<String,Integer> range) {
		return dao.select(range);
	}
}
