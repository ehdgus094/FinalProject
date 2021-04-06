package com.naver.myhome.market.Controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.naver.myhome.market.Service.UsedItemService;
import com.naver.myhome.market.domain.UsedItem;

@Controller
@RequestMapping(value="/market")
public class MarketController {
	private static final Logger logger = LoggerFactory.getLogger(MarketController.class);
	
	@Autowired
	private UsedItemService usedItemService;
	
	@GetMapping(value = "/list")
	public String list() {
		return "market/list";
	}
	
	@GetMapping("/sell")
	public String sell() {
		return "market/sell";
	}
	
	@PostMapping("/sellProcess")
	public ModelAndView sellProcess(
			ModelAndView mv, UsedItem usedItem, MultipartHttpServletRequest request) throws Exception {

		String path = request.getSession().getServletContext().getRealPath("resources") + "/upload/market_image/";
		String num = "";
		while(true) {
			Random random = new Random();
			int n = random.nextInt(10000001);
			File folder = new File(path+n);
			if(!folder.exists()) {
				try {
					folder.mkdir();
					num += n;
					break;
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		int result = 0;
		if(!num.equals("")) {
			usedItem.setImage(num);
			result = usedItemService.insert(usedItem);
			if(result == 1) {
				//이미지 저장
				List<MultipartFile> uploadfiles = request.getFiles("uploadfile");
				if(!uploadfiles.isEmpty()) {
					for(int i=0; i<uploadfiles.size(); i++) {
						int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
						String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
						uploadfiles.get(i).transferTo(new File(path + num + "/" + i + "." + extension));						
					}					
				}
			}
		}
		if(result == 1) {
			//등록 성공
		} else {
			//실패
		}
		
		mv.setViewName("redirect:list");
		return mv;
	}
}
