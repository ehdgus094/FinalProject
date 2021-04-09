package com.naver.myhome.sub.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.sub.domain.MartList;

@Repository
public class MartListDAO {

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int addmart(MartList m) {
		return sqlSession.insert("sub.insert", m);
		
	}

}
