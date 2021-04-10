package com.naver.myhome.meetup.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GroupsDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

}
