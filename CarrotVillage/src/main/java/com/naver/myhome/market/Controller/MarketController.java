package com.naver.myhome.market.Controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseBody;
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
	public ModelAndView list(String search, ModelAndView mv) {
		mv.addObject("search", search);
		mv.setViewName("market/list");
		return mv;
	}
	
	@ResponseBody
	@GetMapping(value = "/loadList")
	public List<UsedItem> loadList(String page, String search) {
		int num = Integer.parseInt(page);
		int start = (num-1)*16+1;
		int end = num*16;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		return usedItemService.select(map);
	}
	
	@GetMapping("/write")
	public ModelAndView write(ModelAndView mv, HttpSession session) {
		Member member = (Member) session.getAttribute("user_info");
		mv.addObject("latitude", 37.6899422);
		mv.addObject("longitude", 126.7199836);
		mv.addObject("member", member);
		mv.setViewName("market/writeForm");
		return mv;
	}
	
	@PostMapping("/writeProcess")
	public String writeProcess(
			UsedItem usedItem, MultipartHttpServletRequest request, String delete_num) throws Exception {
		usedItem.setImagefolder("");
		usedItem.setThumbnail("");
		List<MultipartFile> uploadfiles = request.getFiles("uploadfile");
		//추가했다가 삭제한 이미지 정보 구하기
		String[] delete_num_arr = null;
		if(!delete_num.equals("")) {
			delete_num_arr = delete_num.split(";");
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
	
	@GetMapping("/detail")
	public ModelAndView detail(String num, ModelAndView mv, HttpServletRequest request) {
		Member member = (Member) request.getSession().getAttribute("user_info");
		usedItemService.addViewcount(Integer.parseInt(num));
		UsedItem usedItem = usedItemService.detail(Integer.parseInt(num));
		String path = request.getSession().getServletContext().getRealPath("resources") + "/upload/market_image/"+usedItem.getImagefolder();
		File f = new File(path);
		File[] files = f.listFiles();
		List<String> imglist = new ArrayList<String>();
		if(files != null) {
			for(int i=0; i<files.length; i++) {
				imglist.add(files[i].getName());
			}			
		}
		mv.addObject("member", member);
		mv.addObject("latitude", 37.6899422);
		mv.addObject("longitude", 126.7199836);
		mv.addObject("usedItem", usedItem);
		mv.addObject("imglist", imglist);
		mv.setViewName("market/detail");
		return mv;
	}
	
	@GetMapping("/change_loc")
	public ModelAndView change_loc(ModelAndView mv) {
		mv.addObject("latitude", 37.6899422);
		mv.addObject("longitude", 126.7199836);
		mv.setViewName("market/change_loc");
		return mv;
	}
	
	@GetMapping("/delete")
	public ModelAndView delete(String num, ModelAndView mv, String imagefolder, HttpServletRequest request) {
		int result = usedItemService.delete(Integer.parseInt(num));
		if(result != 1) {
			mv.addObject("message", "삭제 실패");
			mv.setViewName("error/error");
		} else {
			if(!imagefolder.equals("")) {
				String path = request.getSession().getServletContext().getRealPath("resources") + "/upload/market_image/";
				File folder = new File(path+imagefolder);
				
				try {
					while(folder.exists()) {
						File[] folder_list = folder.listFiles(); //파일리스트 얻어오기
						
						for (int j = 0; j < folder_list.length; j++) {
							folder_list[j].delete(); //파일 삭제 
						}
						
						if(folder_list.length == 0 && folder.isDirectory()){ 
							folder.delete(); //대상폴더 삭제
						}
					}
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			mv.setViewName("redirect:list");
		}
		return mv;
	}
	
	@GetMapping("/modify")
	public ModelAndView modify(ModelAndView mv, String num, HttpServletRequest request) {
		UsedItem usedItem = usedItemService.detail(Integer.parseInt(num));
		String path = request.getSession().getServletContext().getRealPath("resources") + "/upload/market_image/"+usedItem.getImagefolder();
		File f = new File(path);
		File[] files = f.listFiles();
		List<String> imglist = new ArrayList<String>();
		if(files != null) {
			for(int i=0; i<files.length; i++) {
				imglist.add(files[i].getName());
			}			
		}
		mv.addObject("imglist", imglist);
		mv.addObject("usedItem", usedItem);
		mv.setViewName("market/modifyForm");
		return mv;
	}
	
	@PostMapping("/modifyProcess")
	public String modifyProcess(
			UsedItem usedItem, MultipartHttpServletRequest request, String delete_num) throws Exception {
		usedItem.setImagefolder("");
		usedItem.setThumbnail("");
		List<MultipartFile> uploadfiles = request.getFiles("uploadfile");
		//추가했다가 삭제한 이미지 정보 구하기
		String[] delete_num_arr = null;
		if(!delete_num.equals("")) {
			delete_num_arr = delete_num.split(";");
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
