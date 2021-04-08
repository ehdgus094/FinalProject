package com.naver.myhome.sub.Controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.myhome.sub.Service.MartListService;
import com.naver.myhome.sub.domain.MartList;



@Controller
@RequestMapping(value = "/sub")
public class Sub_Controller {
	private static final Logger logger = LoggerFactory.getLogger(Sub_Controller.class);

	
	@Autowired
	private MartListService martListService;
	
	
	@GetMapping(value = "/submarket")
	public String submain() {
		logger.info("sub_main도달");
		return "sub/submain";
	}

	@RequestMapping(value = "/loc")
	public String loc() {
		logger.info("loc도달");
		return "sub/loce";

	}

	@GetMapping("/detail")
	public String detail() {
		logger.info("detail도달");
		return "sub/sub_detail";
	}

	@GetMapping("/sub_report")
	public String report() {
		logger.info("report도달");
		return "sub/sub_report";
	}

	@GetMapping("/sub_sub")
	public String sub() {
		logger.info("sub도달");
		return "sub/sub_sub";
	}
	@GetMapping("/wishlist")
	public String wish() {
		return "sub/wishlist";
	}
	
	@GetMapping("/my-order")
	public String order() {
		return "sub/myorder";
	}
	@GetMapping("/addmart")
	public String martp() {
		return "sub/addmart";
		
	}
	@GetMapping("/subwrite")
	public String write() {
		return "sub/sub_write";
	}
	@PostMapping("/addmartPro")
	public String addmart(MartList m,HttpServletRequest request, Model model,RedirectAttributes rattr ) {
		int result = martListService.addmart(m);
		if (result == 1) {
		
			rattr.addFlashAttribute("result", "시장목록추가성공");
			return "redirect:submart";

		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "시장목록추가 실패입니다.");
			return "error/error";
		}
	}
}
