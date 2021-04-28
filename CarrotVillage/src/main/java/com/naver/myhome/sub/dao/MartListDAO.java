package com.naver.myhome.sub.dao;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.sub.Service.MartListServiceImpl;
import com.naver.myhome.sub.domain.MartDetail;
import com.naver.myhome.sub.domain.MartList;

@Repository
public class MartListDAO {

	private static final Logger logger = LoggerFactory.getLogger(MartListDAO.class);
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int addmart(MartList m) {
		return sqlSession.insert("Sub.insert", m);
		
	}

	public List<MartList> listup(Map<String, Object> map) {

	
		return sqlSession.selectList("Sub.listup", map);
	}

	public int listupcount(Map<String, Object> map) {
		
		return sqlSession.selectOne("Sub.listupcount", map);
	}

	public void insertsub(MartDetail md) {
		
		 sqlSession.insert("SubD.insert", md);
	}

	public List<MartList> listDetail(int num) {
		
		return sqlSession.selectList("Sub.listDetail", num);
	}

	public String listname(int num) {
	
		return sqlSession.selectOne("Sub.listname", num);
	}

	public List<MartDetail> martDetail(String m_na) {
		
		return sqlSession.selectList("SubD.martdetail", m_na);
	}

	public List<MartList> listup2() {
		
		return sqlSession.selectList("Sub.listup2");
	}

	public int listupcount2() {
		
		return sqlSession.selectOne("Sub.listupcount2");
	}

	public List<MartDetail> detailview(int num) {
	
		return sqlSession.selectList("SubD.detailview",num);
	}

	public int detailviewco(String m_na) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("SubD.detailcount", m_na);
	}

	public List<MartDetail> priceinfo(int num) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("SubD.detailview",num);
	}

	public int del(int num) {
		return sqlSession.delete("SubD.del",num);
		
	}


}
