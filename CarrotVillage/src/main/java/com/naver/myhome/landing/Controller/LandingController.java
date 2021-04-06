package com.naver.myhome.landing.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LandingController {
	
	private static final Logger logger = LoggerFactory.getLogger(LandingController.class);

	@RequestMapping(value = "/landing")
	public String landing() {
		logger.info("landing()");
		return "landing/landingpage";
	}
}