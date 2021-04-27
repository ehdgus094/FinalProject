package com.naver.myhome.meetup.Service;

import java.util.List;

import com.naver.myhome.meetup.domain.Review;


public interface ReviewService {
	
	public List<Review> getReviewList(int num, int page);
	
	public int getReviewListCount(int num);
	
	public int reviewAdd(Review review);

	public int reviewUpdate(Review review);

	public int reviewDelete(int num);

	public int reviewReplyAdd(Review review);

	public int reviewReplyupdate(Review review);

	
}
