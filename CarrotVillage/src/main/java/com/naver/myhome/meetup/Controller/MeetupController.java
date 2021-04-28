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
		mv.addObject("list", list);//famous 목록
		mv.addObject("like", like); //내가 찜한 목록 + 쿼리문도 order by 해서 각각부름
	    mv.addObject("count", count);
	    mv.addObject("page_like", page_like); //각각의 page임 ..
	    mv.addObject("page_view", page_view);
	   // mv.addObject("search_list", search_list);
		mv.addObject("search_word", search_word);
	    
		mv.setViewName("meetup/meetup_list");
		logger.info("밋업 리스트 list()");
		return mv;
	}
	
	
	@GetMapping(value = "/detail")
	public ModelAndView getDetail(HttpServletRequest request, ModelAndView mv, int num) {
		 Member member = (Member) request.getSession().getAttribute("user_info");//세션부르기
		 String address = (String) request.getSession().getAttribute("address");
		 String lat = (String) request.getSession().getAttribute("lat"); //내 현재위치
		 String lon = (String) request.getSession().getAttribute("lon");
		 
		/*
		 * HashMap<String, Object> hashMap = new HashMap<String, Object>();
		 * hashMap.put("num", num); hashMap.put("member", member); //name값
		 */
		 int viewCount = groupsService.getViewCount(num);
		 Groups groups = groupsService.getDetail(num);
		 //Like like = likeService.getDetail(hashMap);
		 
	 	mv.addObject("groups", groups);
	 	mv.addObject("member", member);
	 	mv.addObject("address", address);
	 	mv.addObject("lat", lat);
		mv.addObject("lon", lon);
		logger.info("detail address = " + address);
		logger.info("detail lat = " + lat);
		logger.info("detail lon = " + lon);
		 	
		//int count = commentService.getListCount(num);
		mv.setViewName("meetup/meetup_detail");
		//mv.addObject("count", count);
		logger.info("밋업 글읽기페이지 detail()");
		return mv;
	}
	
	@GetMapping(value = "/make") //큰거부터 작은거 순서대로 . . . 
	public ModelAndView meetupMake(HttpServletRequest request, ModelAndView mv) {
		 Member member = (Member) request.getSession().getAttribute("user_info");//세션부르기
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
		 
		 //String id = (String) request.getSession().getAttribute("user_info"); //세션부르기
		 //logger.info("session id = " + id);
		 //Member member = memberService.memberInfo(id); //db에서 가져온 한 로우 전체값 그룹객체
		 //member 객체를 넘겨줌
		 
	     //mv.addObject("member", member); 멤버VO전부가져옴
	     //mv.addObject("name", member.getName()); //멤버에서 네임만 추출해서 가져옴
		 mv.setViewName("meetup/meetup_make");
		logger.info("밋업 글쓰기페이지 make()");
		return mv;
	}
	
	
	@PostMapping("/makeProcess") //addFile + @ResponseBody
	public String meetupMakeProcess (Groups groups, 
			RedirectAttributes rattr , HttpServletRequest request )throws Exception {
		System.out.println("insert getImg_file() = "  + groups.getImg_file());
		System.out.println("insert getImg_file_ori() = "  + groups.getImg_file_ori());
		MultipartFile uploadfile = groups.getUploadfile(); //빈배열

		if (!uploadfile.isEmpty()) { 
			String fileName = uploadfile.getOriginalFilename(); // 원래파일명
			groups.setImg_file_ori(fileName); //글수정때 이름불러오려고 저장
			
			String saveFolder =  request.getSession().getServletContext().getRealPath("resources") + "/upload/meetup_groupsImg/"; //슬래시 앞뒤로 주의 
			
			  String fileDBName = fileDBName(fileName, saveFolder);
			  logger.info("fileDBName = " + fileDBName);
			 // transferTo(File path) : 업로드한 파일을 매개변수으 경로에 저장
			uploadfile.transferTo(new File(saveFolder + fileDBName));

			// 바뀐파일명으로 저장
			groups.setImg_file(fileDBName);
		} else {
			groups.setImg_file(""); //null이 아닌 빈문자열을 넣어줌(객체가없어서 오류나지않게)
			groups.setImg_file_ori("");
		}
		
		int result = groupsService.make(groups);
		
		if (result == 1) {
			rattr.addFlashAttribute("result", "makeSuccess");
		}
 		return "redirect:list";
     }
	
   //굳이 이름을 바꿔서 디비와 파일경로에 넣어줄 필요가 있나..? -> 중복
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
			logger.info("폴더생성잘됨");
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
		Member member = (Member) request.getSession().getAttribute("user_info");//세션부르기
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
		
		String saveFolder =  request.getSession().getServletContext().getRealPath("resources") + "/upload/meetup_groupsImg/"; //슬래시 앞뒤로 주의 
		MultipartFile uploadfile = groups.getUploadfile(); //아직 빈 껍데기
		
		if (check != null && !check.equals("")) { // 업로드파일 수정 xx일때
			logger.info("기존파일 유지");
			groups.setImg_file_ori(check);
			logger.info("check = " + check);
		} else { //새로운걸로 수정
			if(uploadfile != null && !uploadfile.isEmpty()) {
				logger.info("파일 변경됨");
				
				String fileName = uploadfile.getOriginalFilename();
				logger.info("변경한뒤 fileName = " + fileName);
				groups.setImg_file_ori(fileName);
				
				String fileDBName = fileDBName(fileName, saveFolder);
				logger.info(saveFolder);
				logger.info(fileDBName);
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				groups.setImg_file(fileDBName);
				
			} else { //삭제
				logger.info("선택된 파일 없음 삭제됨");
				groups.setImg_file("");
				groups.setImg_file_ori("");
			}
		}
		
		int result = groupsService.modify(groups);
		if(result == 1) {
			logger.info("게시판수정 성공");
			rattr.addAttribute("num", groups.getNum());
		}
		return "redirect:detail";
	}
	
	
	@GetMapping("/delete")
	public String meetupDelete(int num, RedirectAttributes rattr) {
		
		int result = groupsService.delete(num);
		
		if(result == 1) {
			logger.info("게시글 삭제 성공, result = " + result);
			rattr.addFlashAttribute("result", "deleteSuccess");
		}
		return "redirect:list";
	}
	
    //그룹참여하기
	@ResponseBody
	@PostMapping("/groups_join") //ajax r_body
	public Map<String, Object> groupsJoin(int groups_join_num, Groups_join groups_join) throws Exception {
							
		int result = -1; //1 : 인서트성공 , 0 : 인서트 실패, -1 : 아이디 이미존재
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
	
	//좋아요
	@ResponseBody
	@PostMapping("/groups_like") //ajax r_body
	public Map<String, Object> groups_like (int status, int groups_like_num, Groups_like groups_like) throws Exception {
		
		//좋아요,status : -1
		int result = -1; //1 : 인서트성공 , 0 : 인서트 실패, -1 : 아이디 이미존재
		Groups_like check = groupsService.id_check2(groups_like);
		logger.info("check=" + check); //check != null  -> 데이터존재, 삭제함 , 빈하트로 바뀜
		logger.info("status="+status);
		if(check == null) {
		    result = groupsService.create(groups_like);
		    logger.info("좋아요 등록, result = " + result);
		} else {
			if(status == -1) {
				result = groupsService.groups_like_delete(groups_like);
				result = 7;
				logger.info("좋아요 삭제, result = " + result);
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
	
	
