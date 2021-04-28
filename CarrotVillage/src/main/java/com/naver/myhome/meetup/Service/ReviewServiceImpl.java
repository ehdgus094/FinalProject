package com.naver.myhome.meetup.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.myhome.meetup.dao.ReviewDAO;
import com.naver.myhome.meetup.domain.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDAO dao;

	
	@Override
	public List<Review> getReviewList(int review_groups_num, int page) {
		int startrow = 1;
		int endrow = page * 4;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("review_groups_num", review_groups_num);
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getReviewList(map);
	}

	@Override
	public int getReviewListCount(int review_groups_num) {
		return dao.getReviewListCount(review_groups_num);
	}

	@Override
	public int reviewAdd(Review review) {
		 return dao.reviewAdd(review); 
	}


	@Override
	public int reviewUpdate(Review review) {
		 return dao.reviewUpdate(review); 

	}

	@Override
	public int reviewDelete(int num) {
		return dao.reviewDelete(num);

	}

	@Override
	public int reviewReplyAdd(Review review) {
		return dao.reviewReplyAdd(review);
	}

	@Override
	public int reviewReplyupdate(Review review) {
		return dao.reviewReplyupdate(review);
	}

	
	

}
