package com.naver.myhome.sub.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.sub.dao.MartListDAO;
import com.naver.myhome.sub.domain.MartDetail;
import com.naver.myhome.sub.domain.MartList;


@Service
public class MartListServiceImpl implements MartListService{
	private static final Logger logger = LoggerFactory.getLogger(MartListServiceImpl.class);
	
	@Autowired
	private MartListDAO dao;
	@Override
	public int addmart(MartList m) {

		return dao.addmart(m);
	}
	@Override
	public List<MartList> listup(String martloc, String si , String gu) {
		Map<String, Object> map = new  HashMap<String, Object>();
		map.put("martloc",martloc);
		map.put("si", si);
		map.put("gu", gu);
		return dao.listup(map);
	}
	@Override
	public int listupcount(String martloc, String si , String gu) {
		Map<String, Object> map = new  HashMap<String, Object>();
		map.put("martloc",martloc);
		map.put("si", si);
		map.put("gu", gu);
		
		return dao.listupcount(map);
	}
	@Override
	public void insertsub(MartDetail md) {
		
		dao.insertsub(md);
	}
	@Override
	public List<MartList> listview(int num) {
		
		return dao.listDetail(num);
	}
	@Override
	public List<MartDetail> listDeta(int num) {
		String m_na = dao.listname(num);
		logger.info("m_na = "+m_na);
		if(m_na==null) {
			return null;
		}else {
			return dao.martDetail(m_na);
		}
		
	}
	@Override
	public List<MartList> listup2() {
	
		return dao.listup2();
	}
	@Override
	public int listupcount2() {
		
		return dao.listupcount2();
	}
	@Override
	public List<MartDetail> detailview(int num) {
	
		return dao.detailview(num);
	}
	@Override
	public int listDetaco(int num) {
		// TODO Auto-generated method stub
	
		String m_na = dao.listname(num);
		logger.info("m_na = "+m_na);
		
			return dao.detailviewco(m_na);
		
		
	}
	@Override
	public List<MartDetail> prinfo(int num) {
	
		return dao.priceinfo(num);
	}
	@Override
	public int del(int num) {
	 return	dao.del(num);
		
	}
	
}
