package com.naver.myhome.meetup.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.myhome.meetup.domain.Review;

@Repository
public class ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int reviewAdd(Review review) {
		return sqlSession.insert("Reviews.reviewAdd", review);
	}

	public List<Review> getReviewList(Map<String, Integer> map) {
		return sqlSession.selectList("Reviews.getReviewList", map);
	}

	public int getReviewListCount(int review_groups_num) {
		return sqlSession.selectOne("Reviews.getReviewListCount", review_groups_num);
	}

	public int reviewUpdate(Review review) {
		return sqlSession.update("Reviews.reviewUpdate", review);
	}

	public int reviewDelete(int num) {
		return sqlSession.delete("Reviews.reviewDelete", num);
	}

	public int reviewReplyAdd(Review review) {
		return sqlSession.insert("Reviews.reviewReplyAdd", review);
	}

	public int reviewReplyupdate(Review review) {
		return sqlSession.update("Reviews.reviewReplyupdate", review);
	}
	
}
