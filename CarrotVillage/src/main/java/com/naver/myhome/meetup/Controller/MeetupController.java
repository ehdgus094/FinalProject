package com.naver.myhome.meetup.Controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.myhome.main.domain.Member;
import com.naver.myhome.meetup.Service.GroupsService;
import com.naver.myhome.meetup.domain.Groups;
import com.naver.myhome.meetup.domain.Groups_join;
import com.naver.myhome.meetup.domain.Groups_like;

@Controller
@RequestMapping(value="/meetup")
public class MeetupController {
	
	private static final Logger logger = LoggerFactory.getLogger(MeetupController.class);
	
	@Autowired
	private GroupsService groupsService;
	
	@GetMapping(value = "/list") 
	public ModelAndView list(ModelAndView mv , String num, HttpServletRequest request , 
			       @RequestParam(value = "page_like", defaultValue = "1", required = false) int page_like ,
				   @RequestParam(value = "page_view", defaultValue = "1", required = false) int page_view,
				   @RequestParam(value = "search_word", defaultValue = "", required = false) String search_word) {
		List<Groups> list = groupsService.selectList(page_view, search_word);
		List<Groups> like = groupsService.selectListLike(page_like, search_word);
		//List<Groups> search_list = groupsService.getSearchList(page, limit ,search_word);

		
		int count = groupsService.getListCount();
		mv.addObject("list", list);//famous ??????
		mv.addObject("like", like); //?????? ?????? ?????? + ???????????? order by ?????? ????????????
	    mv.addObject("count", count);
	    mv.addObject("page_like", page_like); //????????? page??? ..
	    mv.addObject("page_view", page_view);
	   // mv.addObject("search_list", search_list);
		mv.addObject("search_word", search_word);
	    
		mv.setViewName("meetup/meetup_list");
		logger.info("?????? ????????? list()");
		return mv;
	}
	
	
	@GetMapping(value = "/detail")
	public ModelAndView getDetail(HttpServletRequest request, ModelAndView mv, int num
			,Groups_join groups_join, Groups_like groups_like) {
		 Member member = (Member) request.getSession().getAttribute("user_info");//???????????????
		 String address = (String) request.getSession().getAttribute("address");
		 String lat = (String) request.getSession().getAttribute("lat"); //??? ????????????
		 String lon = (String) request.getSession().getAttribute("lon");
		 
		/*
		 * HashMap<String, Object> hashMap = new HashMap<String, Object>();
		 * hashMap.put("num", num); hashMap.put("member", member); //name???
		 */
		 int viewCount = groupsService.getViewCount(num);
		 Groups groups = groupsService.getDetail(num);
		 List<Object> like_count = groupsService.getLikeCount(num);
		 List<Object> joined_count = groupsService.getJoinedMember(num);
		 
		 
		 //Like like = likeService.getDetail(hashMap);
		 
	 	mv.addObject("groups", groups);
	 	mv.addObject("member", member);
	 	mv.addObject("address", address);
	 	mv.addObject("lat", lat);
		mv.addObject("lon", lon);
		mv.addObject("like_count", like_count.size());
		mv.addObject("joined_count", joined_count.size());
		logger.info("detail address = " + address);
		logger.info("detail lat = " + lat);
		logger.info("detail lon = " + lon);
		 	
		//int count = commentService.getListCount(num);
		mv.setViewName("meetup/meetup_detail");
		//mv.addObject("count", count);
		logger.info("?????? ?????????????????? detail()");
		return mv;
	}
	
	@GetMapping(value = "/make") //???????????? ????????? ???????????? . . . 
	public ModelAndView meetupMake(HttpServletRequest request, ModelAndView mv) {
		 Member member = (Member) request.getSession().getAttribute("user_info");//???????????????
		 String address = (String) request.getSession().getAttribute("address");
		 String lat = (String) request.getSession().getAttribute("lat");
		 String lon = (String) request.getSession().getAttribute("lon");
		 
		 mv.addObject("member", member);
		 mv.addObject("address", address);
		 mv.addObject("latitude", lat);
		 mv.addObject("longitude", lon);
		 logger.info("make address = " + address);
		 logger.info("make latitude = " + lat);
		 logger.info("make longitude = " + lon);
		 
		 //String id = (String) request.getSession().getAttribute("user_info"); //???????????????
		 //logger.info("session id = " + id);
		 //Member member = memberService.memberInfo(id); //db?????? ????????? ??? ?????? ????????? ????????????
		 //member ????????? ?????????
		 
	     //mv.addObject("member", member); ??????VO???????????????
	     //mv.addObject("name", member.getName()); //???????????? ????????? ???????????? ?????????
		 mv.setViewName("meetup/meetup_make");
		logger.info("?????? ?????????????????? make()");
		return mv;
	}
	
	
	@PostMapping("/makeProcess") //addFile + @ResponseBody
	public String meetupMakeProcess (Groups groups, 
			RedirectAttributes rattr , HttpServletRequest request )throws Exception {
		System.out.println("insert getImg_file() = "  + groups.getImg_file());
		System.out.println("insert getImg_file_ori() = "  + groups.getImg_file_ori());
		MultipartFile uploadfile = groups.getUploadfile(); //?????????

		if (!uploadfile.isEmpty()) { 
			String fileName = uploadfile.getOriginalFilename(); // ???????????????
			groups.setImg_file_ori(fileName); //???????????? ????????????????????? ??????
			
			String saveFolder =  request.getSession().getServletContext().getRealPath("resources") + "/upload/meetup_groupsImg/"; //????????? ????????? ?????? 
			
			  String fileDBName = fileDBName(fileName, saveFolder);
			  logger.info("fileDBName = " + fileDBName);
			 // transferTo(File path) : ???????????? ????????? ??????????????? ????????? ??????
			uploadfile.transferTo(new File(saveFolder + fileDBName));

			// ????????????????????? ??????
			groups.setImg_file(fileDBName);
		} else {
			groups.setImg_file(""); //null??? ?????? ??????????????? ?????????(?????????????????? ??????????????????)
			groups.setImg_file_ori("");
		}
		
		int result = groupsService.make(groups);
		
		if (result == 1) {
			rattr.addFlashAttribute("result", "makeSuccess");
		}
 		return "redirect:list";
     }
	
   //?????? ????????? ????????? ????????? ??????????????? ????????? ????????? ??????..? -> ??????
	private String fileDBName(String fileName, String saveFolder) {

	    Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR); 
		int month = c.get(Calendar.MONTH) +1 ; 
		int date = c.get(Calendar.DATE);

		String homedir = saveFolder + year + "-" + month + "-" + date;
		logger.info(homedir);
		File path1 = new File(homedir);
		if (!(path1.exists())) {
			path1.mkdir(); 
			logger.info("??????????????????");
		}

		Random r = new Random();
		int random = r.nextInt(100000000);
		
		int index = fileName.lastIndexOf(".");
		
		logger.info("index = " + index);

		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);
		
		String refileName = "bbs" + year + month + date + random + "." + fileExtension;
		logger.info("refileName = " + refileName);
		
		String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;

		return fileDBName;
	} 
	
	
	@GetMapping("/modify")
	public ModelAndView meetupModify( int num, ModelAndView mv, HttpServletRequest request ) {
		Member member = (Member) request.getSession().getAttribute("user_info");//???????????????
		Groups groups = groupsService.getDetail(num);
		
		mv.addObject("member", member);
		mv.addObject("groups", groups);
		mv.setViewName("meetup/meetup_modify");
		return mv;
	}
	
	
	@PostMapping("/modifyProcess")
	public String meetupModifyProcess(Groups groups,  Model mv, String check,
				HttpServletRequest request, RedirectAttributes rattr) throws Exception {
		System.out.println("modify getImg_file() = "  + groups.getImg_file());
		System.out.println("modify getImg_file_ori() = "  + groups.getImg_file_ori());
		
		String saveFolder =  request.getSession().getServletContext().getRealPath("resources") + "/upload/meetup_groupsImg/"; //????????? ????????? ?????? 
		MultipartFile uploadfile = groups.getUploadfile(); //?????? ??? ?????????
		
		if (check != null && !check.equals("")) { // ??????????????? ?????? xx??????
			logger.info("???????????? ??????");
			groups.setImg_file_ori(check);
			logger.info("check = " + check);
		} else { //??????????????? ??????
			if(uploadfile != null && !uploadfile.isEmpty()) {
				logger.info("?????? ?????????");
				
				String fileName = uploadfile.getOriginalFilename();
				logger.info("???????????? fileName = " + fileName);
				groups.setImg_file_ori(fileName);
				
				String fileDBName = fileDBName(fileName, saveFolder);
				logger.info(saveFolder);
				logger.info(fileDBName);
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				groups.setImg_file(fileDBName);
				
			} else { //??????
				logger.info("????????? ?????? ?????? ?????????");
				groups.setImg_file("");
				groups.setImg_file_ori("");
			}
		}
		
		int result = groupsService.modify(groups);
		if(result == 1) {
			logger.info("??????????????? ??????");
			rattr.addAttribute("num", groups.getNum());
		}
		return "redirect:detail";
	}
	
	
	@GetMapping("/delete")
	public String meetupDelete(int num, RedirectAttributes rattr) {
		
		int result = groupsService.delete(num);
		
		if(result == 1) {
			logger.info("????????? ?????? ??????, result = " + result);
			rattr.addFlashAttribute("result", "deleteSuccess");
		}
		return "redirect:list";
	}
	
    //??????????????????
	@ResponseBody
	@PostMapping("/groups_join") //ajax r_body
	public Map<String, Object> groupsJoin(int groups_join_num, Groups_join groups_join) throws Exception {
							
		int result = -1; //1 : ??????????????? , 0 : ????????? ??????, -1 : ????????? ????????????
		Groups_join check = groupsService.id_check(groups_join);
		if(check == null) {
		    result = groupsService.groups_join(groups_join);
		} 
		List<Object> joined_count = groupsService.getJoinedMember(groups_join_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		map.put("joined_count", joined_count.size());
		System.out.println("join result=" + result);
		System.out.println("joined_count=" + joined_count);
		return map;
	}
	
	//?????????
	@ResponseBody
	@PostMapping("/groups_like") //ajax r_body
	public Map<String, Object> groups_like (int status, int groups_like_num, Groups_like groups_like) throws Exception {
		
		//?????????,status : -1
		int result = -1; //1 : ??????????????? , 0 : ????????? ??????, -1 : ????????? ????????????
		Groups_like check = groupsService.id_check2(groups_like);
		logger.info("check=" + check); //check != null  -> ???????????????, ????????? , ???????????? ??????
		logger.info("status="+status);
		if(check == null) {
		    result = groupsService.create(groups_like);
		    logger.info("????????? ??????, result = " + result);
		} else {
			if(status == -1) {
				result = groupsService.groups_like_delete(groups_like);
				result = 7;
				logger.info("????????? ??????, result = " + result);
			}
		}
		List<Object> like_count = groupsService.getLikeCount(groups_like_num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		map.put("like_count", like_count.size());
		logger.info("like result=" + result);
		logger.info("like_count=" + like_count.size());
		return map;
	}
	
 }
	
	
