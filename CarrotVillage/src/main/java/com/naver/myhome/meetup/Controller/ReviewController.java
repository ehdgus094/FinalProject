package com.naver.myhome.meetup.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.myhome.meetup.Service.ReviewService;
import com.naver.myhome.meetup.domain.Review;

@Controller
@RequestMapping(value = "/review")
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ReviewService reviewService;

	@ResponseBody // 리턴된값이 바디로 가는것...
	@RequestMapping(value = "/reviewList")
	public Map<String, Object> reviewList(int review_groups_num, int page) {
		logger.info("review_groups_num= " + review_groups_num);
		List<Review> list = reviewService.getReviewList(review_groups_num, page);
		int listcount = reviewService.getReviewListCount(review_groups_num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("listcount", listcount);
		return map;
	}

	@PostMapping("/reviewAdd")
	public void reviewAdd(Review review, HttpServletResponse response) throws Exception {
		int ok = reviewService.reviewAdd(review);
		response.getWriter().print(ok);
	}

	@GetMapping(value = "/reviewUpdate")
	public void reviewUpdate(Review review, HttpServletResponse response) throws Exception {

		int ok = reviewService.reviewUpdate(review);
		response.getWriter().print(ok);

		// void로 리턴값없이 그냥 응답을 바로하기...
	}

	@GetMapping(value = "/reviewDelete")
	public void reviewDelete(int num, HttpServletResponse response) throws Exception {
		int result = reviewService.reviewDelete(num);
		response.getWriter().print(result);
	}

	@PostMapping("/reviewReplyAdd")
	public void reviewReplyAdd(Review review, HttpServletResponse response) throws Exception {
		int ok = reviewService.reviewReplyAdd(review);
		response.getWriter().print(ok);
	}

	@PostMapping("/reviewReplyupdate")
	public void reviewReplyupdate(Review review, HttpServletResponse response) throws Exception {
		int ok = reviewService.reviewReplyupdate(review);
		response.getWriter().print(ok);
	}

}
