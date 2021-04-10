package com.naver.myhome.meetup.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/meetup")
public class MeetupController {
	
	private static final Logger logger = LoggerFactory.getLogger(MeetupController.class);

	@RequestMapping(value = "/list")
	public String landing() {
		logger.info("밋업 리스트 list()");
		return "/meetup/meetup_list";
	}
	
	@RequestMapping(value = "/detail")
	public String detailPage() {
		logger.info("밋업 글읽기페이지 detail()");
		return "/meetup/meetup_detail";
	}
	
	@RequestMapping(value = "/make")
	public String meetupMakePage() {
		logger.info("밋업 글쓰기페이지 make()");
		return "/meetup/meetup_make";
	}

}
