package com.naver.myhome.market.Controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.naver.myhome.main.domain.Member;
import com.naver.myhome.market.Service.UsedItemService;
import com.naver.myhome.market.domain.UsedItem;

@Controller
@RequestMapping(value="/market")
public class MarketController {
	private static final Logger logger = LoggerFactory.getLogger(MarketController.class);
	
	@Autowired
	private UsedItemService usedItemService;
	
	@GetMapping(value = "/list")
	public ModelAndView list(HttpSession session, ModelAndView mv) {
		List<UsedItem> itemlist = usedItemService.select();
		mv.addObject("itemlist", itemlist);
		mv.setViewName("market/list");
		return mv;
	}
	
	@GetMapping("/sell")
	public ModelAndView sell(ModelAndView mv, HttpSession session) {
		Member member = (Member) session.getAttribute("user_info");
		mv.addObject("member", member);
		mv.setViewName("market/sell");
		return mv;
	}
	
	@PostMapping("/sellProcess")
	public String sellProcess(
			UsedItem usedItem, MultipartHttpServletRequest request, String delete_num) throws Exception {
		usedItem.setImagefolder("");
		usedItem.setThumbnail("");
		List<MultipartFile> uploadfiles = request.getFiles("uploadfile");
		//추가했다가 삭제한 이미지 정보 구하기
		String[] delete_num_arr = null;
		if(!delete_num.equals("")) {
			delete_num_arr = delete_num.split(";");
			for(int i=0; i<delete_num_arr.length; i++) {
			}
		}
		
		if(!uploadfiles.isEmpty()) {
			int size = 0;
			if(delete_num_arr != null) {
				size = delete_num_arr.length;
			}
			if(uploadfiles.size() > size) {
				//이미지 저장 폴더 생성
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
				usedItem.setImagefolder(num);
				//이미지 저장
				int img_name = 0;
				for(int i=0; i<uploadfiles.size(); i++) {
					if(size != 0) {
						if(!Arrays.asList(delete_num_arr).contains(Integer.toString(i))) {
							int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
							String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
							uploadfiles.get(i).transferTo(new File(path + num + "/" + img_name + "." + extension));
							if(img_name == 0) {
								usedItem.setThumbnail(img_name + "." + extension);
							}
							img_name++;
						}						
					} else {
						int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
						String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
						uploadfiles.get(i).transferTo(new File(path + num + "/" + img_name + "." + extension));
						if(img_name == 0) {
							usedItem.setThumbnail(img_name + "." + extension);
						}
						img_name++;
					}
				}
			}
		}
		usedItemService.insert(usedItem);
		return "redirect:list";
	}
}
