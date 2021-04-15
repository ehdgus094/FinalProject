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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.myhome.main.Service.MemberService;
import com.naver.myhome.main.domain.Member;
import com.naver.myhome.meetup.Service.GroupsService;
import com.naver.myhome.meetup.domain.Groups;

@Controller
@RequestMapping(value="/meetup")
public class MeetupController {
	
	private static final Logger logger = LoggerFactory.getLogger(MeetupController.class);
	
	@Autowired
	private GroupsService groupsService;
	
	@Autowired
	private MemberService memberService;
	
	/*
	 * @Value("${savefoldername}") private String saveFolder;
	 */

	
	@GetMapping(value = "/list") 
	public ModelAndView list(ModelAndView mv , String num, 
			     @RequestParam(value = "page_like", defaultValue = "1", required = false) int page_like ,
				@RequestParam(value = "page_view", defaultValue = "1", required = false) int page_view) {
		List<Groups> list = groupsService.selectList(page_view);
		List<Groups> like = groupsService.selectListLike(page_like);
		
		int count = groupsService.getListCount();
		mv.addObject("list", list);//famous 목록
		mv.addObject("like", like); //내가 찜한 목록 + 쿼리문도 order by 해서~ 각각부름
	    mv.addObject("count", count);
	    mv.addObject("page_like", page_like); //그냥 page임 이름다르..
	    mv.addObject("page_view", page_view);
		mv.setViewName("meetup/meetup_list");
		logger.info("밋업 리스트 list()");
		return mv;
	}
	
	
	@GetMapping(value = "/detail")
	public ModelAndView getDetail(HttpServletRequest request, ModelAndView mv, String num) {
		 Member member = (Member) request.getSession().getAttribute("user_info");//세션부르기
		 int viewCount = groupsService.getViewCount(Integer.parseInt(num));
		 Groups groups = groupsService.getDetail(Integer.parseInt(num));
		 	mv.addObject("groups", groups);
		 	mv.addObject("member", member);
			//int count = commentService.getListCount(num);
			mv.setViewName("meetup/meetup_detail");
			//mv.addObject("count", count);
		logger.info("밋업 글읽기페이지 detail()");
		return mv;
	}
	
	@GetMapping(value = "/make") //큰거부터 작은거 순서대로 . . . 
	public ModelAndView meetupMake(HttpServletRequest request, ModelAndView mv) {
		 Member member = (Member) request.getSession().getAttribute("user_info");//세션부르기
		 mv.addObject("member", member);
		 
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
		
		MultipartFile uploadfile = groups.getUploadfile();

		if (!uploadfile.isEmpty()) { 
			String fileName = uploadfile.getOriginalFilename(); // 원래파일명
			
			String saveFolder =  request.getSession().getServletContext().getRealPath("resources") + "/upload/meetup_groupsImg/"; //슬래시 앞뒤로 주의 
			
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName = " + fileDBName);

			// transferTo(File path) : 업로드한 파일을 매개변수으 경로에 저장
			uploadfile.transferTo(new File(saveFolder + fileDBName));

			// 바뀐파일명으로 저장
			groups.setImg_file(fileDBName);
		}
		
		int result = groupsService.make(groups);
		
		if (result == 1) {
			rattr.addFlashAttribute("result", "makeSuccess");
		}
 		return "redirect:list";
     }
	
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
}
