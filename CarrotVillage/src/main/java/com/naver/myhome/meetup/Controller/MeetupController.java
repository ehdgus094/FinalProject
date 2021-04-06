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
		logger.info("landing()");
		return "/meetup/meetup_list";
	}

}
