package com.naver.myhome.sub.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.sub.dao.MartListDAO;
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

}
