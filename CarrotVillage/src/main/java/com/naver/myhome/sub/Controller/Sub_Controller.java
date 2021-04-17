package com.naver.myhome.sub.Controller;

import java.io.Console;
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

import com.naver.myhome.sub.Service.MartListService;
import com.naver.myhome.sub.domain.MartDetail;
import com.naver.myhome.sub.domain.MartList;

@Controller
@RequestMapping(value = "/sub")
public class Sub_Controller {
	private static final Logger logger = LoggerFactory.getLogger(Sub_Controller.class);

	@Autowired
	private MartListService martListService;



	@GetMapping(value = "/submarket")
	public ModelAndView submain(@RequestParam(value = "num", defaultValue = "1", required = false) int num,ModelAndView mv,MartList md) {
		

	
			
		
		List<MartList> result = martListService.listview(num);
		List<MartDetail> de = martListService.listDeta(num);
		
		mv.addObject("result", result);
		mv.addObject("de", de);
		mv.setViewName( "sub/submain");
		return mv;
		
		
	
	}
	

	@RequestMapping(value = "/loc")
	public String loc() {
		logger.info("loc도달");
		return "sub/loce";

	}

	@GetMapping("/detail")
	public ModelAndView detail(@RequestParam(value = "num", defaultValue = "1", required = false) int num,ModelAndView mv,MartDetail md) {
		
		List<MartDetail> result = martListService.detailview(num);
		
		mv.setViewName("sub/sub_detail");
		mv.addObject("result", result);
		return mv;
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
	public String addmart(MartList m, HttpServletRequest request, Model model, RedirectAttributes rattr) {
		int result = martListService.addmart(m);
		if (result == 1) {

			rattr.addFlashAttribute("result", "addmartsuccess");
			return "redirect:submarket";

		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "시장목록추가 실패입니다.");
			return "error/error";
		}
	}

	@ResponseBody
	@PostMapping("/martlist")
	public Map<String, Object> martlist(@RequestParam("si") String si,@RequestParam("gu") String gu, @RequestParam("martloc") String martloc) {
		logger.info(si);
		logger.info(gu);
		int resultcount = martListService.listupcount(martloc, si,gu);
		List<MartList> result = martListService.listup(martloc,si,gu);
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		map.put("c",resultcount);

		return map;

	}
	@ResponseBody
	@PostMapping("/martlist2")
	public Map<String, Object> martlist2() {
		int resultcount = martListService.listupcount2();
		List<MartList> result = martListService.listup2();
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		map.put("c",resultcount);

		return map;

	}
	@PostMapping("/subAdd")
	public String writeaction(MartDetail md,HttpServletRequest request) throws Exception {
	
		MultipartFile uploadfile = md.getUploadfile();
		MultipartFile uploadfile1 = md.getUploadfile1();
		MultipartFile uploadfile2 = md.getUploadfile2();
		MultipartFile uploadfile3 = md.getUploadfile3();
		MultipartFile uploadfile4 = md.getUploadfile4();
		
		String fileName = uploadfile.getOriginalFilename();
		String fileName1 = uploadfile1.getOriginalFilename();
		String fileName2 = uploadfile2.getOriginalFilename();
		String fileName3 = uploadfile3.getOriginalFilename();
		String fileName4 = uploadfile4.getOriginalFilename();
		
		md.setBoard_thumbnail_ori(fileName);
		md.setUpfile1_ori(fileName1);
		md.setUpfile2_ori(fileName2);
		md.setUpfile3_ori(fileName3);
		md.setUpfile4_ori(fileName4);
		
		String saveFolder = request.getSession().getServletContext().getRealPath("resources") + "/upload/sub_image/";
		
		String fileDBName = fileDBName(fileName, saveFolder);
		String fileDBName1 = fileDBName(fileName1, saveFolder);
		String fileDBName2 = fileDBName(fileName2, saveFolder);
		String fileDBName3 = fileDBName(fileName3, saveFolder);
		String fileDBName4 = fileDBName(fileName4, saveFolder);
		
		  uploadfile.transferTo(new File(saveFolder + fileDBName));
		  uploadfile1.transferTo(new File(saveFolder + fileDBName));
		  uploadfile2.transferTo(new File(saveFolder + fileDBName));
		  uploadfile3.transferTo(new File(saveFolder + fileDBName));
		  uploadfile4.transferTo(new File(saveFolder + fileDBName));
		
		  md.setBoard_thumbnail(fileDBName);
		  md.setUpfile1(fileDBName1);
		  md.setUpfile2(fileDBName2);
		  md.setUpfile3(fileDBName3);
		  md.setUpfile4(fileDBName4);
		
		  
		  
		  
		  martListService.insertsub(md);
		  
		return "redirect:submarket";

	}
	 private String fileDBName(String fileName, String saveFolder) {
	   
	      Calendar c = Calendar.getInstance();
	      int year = c.get(Calendar.YEAR);
	      int month = c.get(Calendar.MONTH) + 1;
	      int date = c.get(Calendar.DATE);

	      String homedir = saveFolder + year + "-" + month + "-" + date;
	      logger.info(homedir);
	      File path1 = new File(homedir);
	      if (!(path1.exists())) {
	         path1.mkdir(); 
	      }

	      Random r = new Random();
	      int random = r.nextInt(100000000);

	      int index = fileName.lastIndexOf(".");
	
	      String fileExtension = fileName.substring(index + 1);
	  
	      String refileName = "bbs" + year + month + date + random + "." + fileExtension;

	      String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
	      logger.info("fileDBName = " + fileDBName);
	      return fileDBName;

	   }
}
