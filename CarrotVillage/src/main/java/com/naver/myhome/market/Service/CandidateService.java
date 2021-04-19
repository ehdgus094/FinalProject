package com.naver.myhome.market.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.market.dao.CandidateDAO;
import com.naver.myhome.market.domain.Candidate;

@Service
public class CandidateService {
	@Autowired
	private CandidateDAO dao;
	
	public Candidate select(int num, String id) {
		return dao.select(num, id);
	}
	
	public int insert(int num, String id) {
		return dao.insert(num, id);
	}
	
	public List<Candidate> selectList(int num) {
		return dao.selectList(num);
	}
	
	public void delete(int num) {
		dao.delete(num);
	}
}
