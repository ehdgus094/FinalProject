package com.naver.myhome.market.Controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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
import com.naver.myhome.market.Service.CandidateService;
import com.naver.myhome.market.Service.UsedItemService;
import com.naver.myhome.market.domain.Candidate;
import com.naver.myhome.market.domain.UsedItem;

@Controller
@RequestMapping(value="/market")
public class MarketController {
	private static final Logger logger = LoggerFactory.getLogger(MarketController.class);
	
	@Autowired
	private UsedItemService usedItemService;
	
	@Autowired
	private CandidateService candidateService;
	
	@Autowired
	private FreeItemThread freeItemThread;
	
	@GetMapping(value = "/list")
	public ModelAndView list(String search, ModelAndView mv) {
		mv.addObject("search", search);
		mv.setViewName("market/list");
		return mv;
	}
	
	@ResponseBody
	@GetMapping(value = "/loadList")
	public List<UsedItem> loadList(String page, String search, HttpSession session) {
		String address = (String) session.getAttribute("address");
		String[] arr = address.split(" ");
		String neighborhood = arr[arr.length-2];
		int showcount = 16;
		int num = Integer.parseInt(page);
		int start = (num-1)*showcount+1;
		int end = num*showcount;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		map.put("neighborhood", neighborhood);
		map.put("location", address);
		return usedItemService.select(map);
	}
	
	@GetMapping("/write")
	public ModelAndView write(ModelAndView mv, HttpSession session) {
		Member member = (Member) session.getAttribute("user_info");
		String lat = (String) session.getAttribute("lat");
		String lon = (String) session.getAttribute("lon");
		String addr = (String) session.getAttribute("address");
		mv.addObject("latitude", lat);
		mv.addObject("longitude", lon);
		mv.addObject("address", addr);
		mv.addObject("member", member);
		mv.setViewName("market/writeForm");
		return mv;
	}
	
	@PostMapping("/writeProcess")
	public String writeProcess(
			UsedItem usedItem, MultipartHttpServletRequest request, String delete_num, String date, String time) throws Exception {
		usedItem.setImagefolder("");
		usedItem.setThumbnail("");
		usedItem.setDeadline("");

		if(date != null) {
			usedItem.setDeadline(date + " " + time + ":00");
		}
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
				int img_name = 10;
				for(int i=0; i<uploadfiles.size(); i++) {
					if(size != 0) {
						if(!Arrays.asList(delete_num_arr).contains(Integer.toString(i))) {
							int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
							String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
							uploadfiles.get(i).transferTo(new File(path + num + "/" + img_name + "." + extension));
							if(img_name == 10) {
								usedItem.setThumbnail(img_name + "." + extension);
							}
							img_name++;
						}						
					} else {
						int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
						String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
						uploadfiles.get(i).transferTo(new File(path + num + "/" + img_name + "." + extension));
						if(img_name == 10) {
							usedItem.setThumbnail(img_name + "." + extension);
						}
						img_name++;
					}
				}
			}
		}
		int item_num = usedItemService.insert(usedItem);
		if(date != null) {
			//추첨 마감시간 되면 마감하는 쓰레드 생성
			freeItemThread.setMilliSecond(getDeadline(date + " " + time + ":00"));
			freeItemThread.setNum(item_num);
			freeItemThread.start();
		}
		return "redirect:list";
	}
	
	private long getDeadline(String date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		long milliSeconds = 0;
		try {
			Date end_date = format.parse(date);
			Date today = new Date();
			milliSeconds = end_date.getTime() - today.getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return milliSeconds;
	}
	
	@GetMapping("/detail")
	public ModelAndView detail(String num, ModelAndView mv, HttpServletRequest request) {
		Member member = (Member) request.getSession().getAttribute("user_info");
		String lat = (String) request.getSession().getAttribute("lat");
		String lon = (String) request.getSession().getAttribute("lon");
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
		mv.addObject("latitude", lat);
		mv.addObject("longitude", lon);
		mv.addObject("usedItem", usedItem);
		mv.addObject("imglist", imglist);
		mv.setViewName("market/detail");
		return mv;
	}
	
	@ResponseBody
	@GetMapping(value = "/addCandidate")
	public int addCandidate(String num, String id) {
		int result = 0;
		Candidate candidate = candidateService.select(Integer.parseInt(num), id);
		if(candidate == null) {
			System.out.println("신청자 조회 없음");
			result = candidateService.insert(Integer.parseInt(num), id);
		} else {
			System.out.println("신청자 조회 있음");
			result = -1;
		}
		return result;
	}
	
	@ResponseBody
	@GetMapping(value = "/checkWinner")
	public int checkWinner(String num, String id) {
		int result = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", Integer.parseInt(num));
		map.put("id", id);
		UsedItem usedItem = usedItemService.getWinner(map);
		if(usedItem != null) {
			result = 1;
		}
		return result;
	}
	
	@GetMapping("/change_loc")
	public ModelAndView change_loc(ModelAndView mv, HttpSession session) {
		String lat = (String) session.getAttribute("lat");
		String lon = (String) session.getAttribute("lon");
		mv.addObject("latitude", lat);
		mv.addObject("longitude", lon);
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
			UsedItem usedItem, MultipartHttpServletRequest request, String delete_num, String delete_num_new,
			String imagecount, String date, String time, String original_date, String original_time) throws Exception {
		String path = request.getSession().getServletContext().getRealPath("resources") + "/upload/market_image/";
		List<MultipartFile> uploadfiles = request.getFiles("uploadfile");
		//추가했다가 삭제한 이미지 정보 구하기
		String[] delete_num_arr = null;
		if(!delete_num.equals("")) {
			delete_num_arr = delete_num.split(";");
		}
		String[] delete_num_new_arr = null;
		if(!delete_num_new.equals("")) {
			delete_num_new_arr = delete_num_new.split(";");
		}
		
		//새로 추가된 이미지 업로드
		if(!uploadfiles.isEmpty()) {
			int size = 0;
			if(delete_num_new_arr != null) {
				size = delete_num_new_arr.length;
			}
			if(uploadfiles.size() > size) {
				if(usedItem.getImagefolder().equals("")) {
					//이미지 저장 폴더 생성
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
				}
				//이미지 저장
				int img_name = Integer.parseInt(imagecount) + 10;
				for(int i=0; i<uploadfiles.size(); i++) {
					if(size != 0) {
						if(!Arrays.asList(delete_num_new_arr).contains(Integer.toString(i))) {
							int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
							String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
							uploadfiles.get(i).transferTo(new File(path + usedItem.getImagefolder() + "/" + img_name + "." + extension));
							if(img_name == 10) {
								usedItem.setThumbnail(img_name + "." + extension);
							}
							img_name++;
						}						
					} else {
						int index = uploadfiles.get(i).getOriginalFilename().lastIndexOf(".");
						String extension = uploadfiles.get(i).getOriginalFilename().substring(index+1);
						uploadfiles.get(i).transferTo(new File(path + usedItem.getImagefolder() + "/" + img_name + "." + extension));
						if(img_name == 10) {
							usedItem.setThumbnail(img_name + "." + extension);
						}
						img_name++;
					}
				}
			}
		}
		
		//기존 이미지 삭제 시
		int size = 0;
		if(delete_num_arr != null) {
			size = delete_num_arr.length;
		}
		//삭제할 이미지 존재 시
		if(size>0) {
			File folder = new File(path+usedItem.getImagefolder());
			
			try {
				File[] folder_list = folder.listFiles(); //파일리스트 얻어오기
				
				for (int j = 0; j < folder_list.length; j++) {
					if(Arrays.asList(delete_num_arr).contains(Integer.toString(j))) {
						folder_list[j].delete(); //파일 삭제 						
					}
				}
				File[] new_folder_list = folder.listFiles(); //파일리스트 얻어오기
				//남은 이미지 파일들 이름 수정
				if(new_folder_list.length != 0) {
					for(int i=0; i<new_folder_list.length; i++) {
						int index = new_folder_list[i].getName().lastIndexOf(".");
						String extension = new_folder_list[i].getName().substring(index+1);
						File newFileName = new File(path+usedItem.getImagefolder()+"/"+(i+10)+"."+extension);
						new_folder_list[i].renameTo(newFileName);
						if(i == 0) {
							usedItem.setThumbnail("10."+extension);
						}
					}
				} else {
					//이미지 파일 없을 시 폴더 삭제
					folder.delete();
					usedItem.setImagefolder("");
					usedItem.setThumbnail("");
				}
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		usedItem.setDeadline("");
		if(date != null) {
			if(time.length() == 5) {
				time += ":00";
			}
			if(!original_date.equals(date) || !original_time.equals(time)) {
				//추첨 마감시간 되면 마감하는 쓰레드 생성
				freeItemThread.setMilliSecond(getDeadline(date + " " + time + ":00"));
				freeItemThread.setNum(usedItem.getNum());
				freeItemThread.start();
			}
			usedItem.setDeadline(date + " " + time);
		}
		
		usedItemService.update(usedItem);
		return "redirect:list";
	}
	
	@GetMapping("/updateSold")
	public String updateSold(String num, String sold) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("sold", sold);
		usedItemService.updateSold(map);
		return "redirect:detail?num="+num;
	}
}
