package com.naver.myhome.main.Controller;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.myhome.main.Service.MemberService;
import com.naver.myhome.main.domain.Cart;
import com.naver.myhome.main.domain.Member;

@Controller
@RequestMapping(value="main")
public class MainController {
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
    MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value="mainPage")
	public String main() {
		return "main/main_page";
	}
	
	@ResponseBody
	@RequestMapping(value="saveLoc")
	public void saveLoc(HttpSession session,
						@RequestParam(value = "address") String address,
						@RequestParam(value = "lat") String lat,
						@RequestParam(value = "lon") String lon) {
		session.setAttribute("address", address);
		session.setAttribute("lat", lat);
		session.setAttribute("lon", lon);
	}
	
	
	@RequestMapping(value="login")
	public String login() {
		return "main/member-login";
	}
	
	@ResponseBody
	@RequestMapping(value="keepLogin")
	public void keepLogin(HttpSession session,
						  HttpServletResponse response,
						  @CookieValue(value="saveLogin", required=false) Cookie readCookie) {
		logger.info("keepLogin readCookie value : " + readCookie.getValue());
		Member member = null;
		if (readCookie != null) {
			String id = readCookie.getValue();
			member = memberService.memberInfo(id);
			session.setAttribute("user_info", member);
			readCookie.setPath("/myhome");
			readCookie.setMaxAge(60*60*24*7);
			response.addCookie(readCookie);
		}
	}
	
	@RequestMapping(value="/loginProcess")
	public String loginProcess(Member member, String login_chk, Model model,
							   HttpServletResponse response,
							   HttpSession session,
							   RedirectAttributes rattr,
							   HttpServletRequest request) {
		
		logger.info("loginProcess id = " + member.getId());
		logger.info("login_chk = " + login_chk);
		logger.info("loginProcess login_type : " + member.getLogin_type());
		int result = 0;
		Member lmember = new Member();

		switch (member.getLogin_type()) {
		case "normal":
			result = memberService.passwordChk(member.getId(), member.getPassword());
			break;
		case "naver":
			result = memberService.memberChk("id", member.getId(), "naver");
			break;
		case "kakao":
			result = memberService.memberChk("id", member.getId(), "kakao");
			break;
		}
		
		logger.info("loginProcess result = " + result);
		
		if (result == 1) {
			lmember = memberService.memberInfo(member.getId());
			
			for (Cart cart : EchoHandler.sessionList) {
				if (cart.getId().equals(lmember.getId())) {
					rattr.addFlashAttribute("result", "already");
					return "redirect:login";
				}
			}
			
			session.setAttribute("user_info", lmember);
			
			String requestURL = request.getRequestURL().toString();
			logger.info(requestURL);
			int start = requestURL.indexOf("//");
			//int end = requestURL.lastIndexOf("/");
			String url = requestURL.substring(start, 28);
			
			logger.info("url = " + url);
			session.setAttribute("url", url);
		}
	
		if (member.getLogin_type().equals("normal") && "1".equals(login_chk)) {
			Cookie cookie = new Cookie("saveLogin", lmember.getId());
			cookie.setPath("/myhome");
			cookie.setMaxAge(60*60*24*7);
			response.addCookie(cookie);
		}
		
		rattr.addFlashAttribute("result", result);
		rattr.addFlashAttribute("id", member.getId());
		rattr.addFlashAttribute("password", member.getPassword());
		return "redirect:login";
	}
	
	@RequestMapping(value="naverLogin")
	public String naverLogin() {
		return "main/member-naver_login";
	}
	
	@RequestMapping(value="kakaoLogin")
	public String kakaoLogin() {
		return "main/member-kakao_login";
	}
	
	@ResponseBody
	@RequestMapping(value="socialLoginProcess")
	public Map<String, Object> naverLoginProcess( @RequestParam(value = "id") String id,
												  @RequestParam(value = "email") String email,
								  				  @RequestParam(value = "name") String name,
								  				  @RequestParam(value = "profile_image", required=false) String profile_image,
								  				  @RequestParam(value = "login_type") String login_type) {
		Member member = new Member();
		int result = memberService.memberChk("email", email, login_type);
		
		if (result == -1) {
			member.setId(login_type + id);
			member.setEmail(email);member.setLogin_type(login_type);
			member.setName(name);member.setProfile_img(profile_image);
			memberService.insert(member);
		} else {
			member = memberService.memberInfo(login_type + id);
			member.setEmail(email);
			member.setName(name);
			member.setProfile_img(profile_image);
			memberService.memberUpdate(member);
		}
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", member.getId());
		return map;
	}
	
	@RequestMapping(value="joinTerms")
	public String joinTerms() {
		return "main/member-join_terms";
	}
	
	@RequestMapping(value="join")
	public String join() {
		return "main/member-join";
	}
	
	@RequestMapping(value="joinMore")
	public String joinMore(Member member, HttpServletRequest request) {
		request.setAttribute("id", member.getId());
		request.setAttribute("password", member.getPassword());
		request.setAttribute("email", member.getEmail());
		return "main/member-join_more";
	}
	
	@ResponseBody
	@RequestMapping(value="joinCheck") 
	public Map<String, String> joinCheck(@RequestParam(value = "field", required = false) String field,
									   @RequestParam(value = "value", required = false) String value) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", memberService.memberChk(field, value, "normal")+"");
		return map;
	}
	
	@RequestMapping(value="joinProcess")
	public String joinProcess(Member member, HttpServletRequest request, RedirectAttributes rattr) throws IllegalStateException, IOException {

		MultipartFile uploadfile = member.getUploadfile();
		
		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();
			member.setProfile_img_ori(fileName);
			String saveFolder = request.getSession().getServletContext().getRealPath("resources") + "\\upload\\member_image\\";
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName = " + fileDBName);

			uploadfile.transferTo(new File(saveFolder + fileDBName));
			member.setProfile_img(fileDBName);
		}

		String encPassword = passwordEncoder.encode(member.getPassword());
		logger.info(encPassword);
		member.setPassword(encPassword);
		
		memberService.insert(member);
		return "redirect:login";

	}
	
	@ResponseBody
	@RequestMapping(value="logout")
	public void logout(HttpSession session,
					   HttpServletResponse response,
					   @CookieValue(value="saveLogin", required=false) Cookie readCookie) {
		Member member = null;
		if (session.getAttribute("user_info") != null) {
			member = (Member) session.getAttribute("user_info");
			logger.info("logout member id : " + member.getId());
		}
		
		if (member.getLogin_type().equals("normal")) {
			if (readCookie != null) {
				readCookie.setPath("/myhome");
				readCookie.setMaxAge(0);
				response.addCookie(readCookie);
			}
		}
		
		session.invalidate();
	}
	
	@ResponseBody
	@RequestMapping(value = "memberSearch")
	public Map<String, Object> memberSearch(@RequestParam(value="search") String search) {
		if (search.equals("")) {
			search = " ";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		List<Member> list = memberService.memberSearch(search);
        map.put("memberList", list);
        return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "emailAuth")
    public Map<String,Object> mailSend(@RequestParam(value="email") String email) throws IOException {
        Random random = new Random();
        int authKey = random.nextInt(4589362) + 49311;
        
        StringBuffer sb = new StringBuffer();
        sb.append("<!DOCTYPE html><html>"
        		+ "<head>"
        		+ "<meta charset='UTF-8'>"
        		+ "</head>"
        		+ "<body>"
        		+ "<div style='width: 540px; height: 600px; border-top: 4px solid orange;"
        		+ "margin: 100px auto; padding: 30px 0; box-sizing: border-box;'>"  
        		
        		+ "	<h1 style='margin: 0; padding: 0 5px; font-size: 28px; font-weight: 400;'>"
        		+ "		<span style='font-size: 15px; margin: 0 0 10px 3px;'>당근빌리지</span>"
        		+ "		<br>"
        		+ "		<span style='color:orange;'>이메일 인증번호가 발급되었습니다.</span>"
        		+ "	</h1>"
        		
        		+ "	<p style='font-size: 16px; line-height: 26px; margin-top: 50px; padding: 0 5px;'>안녕하세요.<br>"
        		+ "		요청하신 이메일 인증번호가 생성되었습니다.<br>"
        		+ "		아래 <b style='color:orange;'>이메일 인증번호</b>를 회원가입 창의 입력란에 입력해 주세요.<br>"
        		+ "		감사합니다."
        		+ "	</p>"

        		+ "	<p style='font-size: 16px; margin: 40px 5px 20px; line-height: 28px;'>이메일 인증번호<br>"
        		+ "		<input style='font-size:24px;width: 150px;text-align:center;"
        		+ "					  border: #585858 1px solid;border-radius: 5px;background: #ffefdb;'"
        		+ "			   id='auth_key' value='" + authKey + "' readonly>"
        		+ "	</p>"
        		+ "<br><br><br>"
        		+ "	<hr>"
        		+ "</div>"
        		+ "</body>"
        		+ "</html>");
        
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom("project.sender.21@gamil.com");
            messageHelper.setTo(email);
            messageHelper.setSubject("회원가입 인증 이메일 입니다.");
            messageHelper.setText(sb.toString(), true);
            
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("authKey", authKey);
        
        return map;  
    }
	
	@RequestMapping(value="myPage")
	public String myPage() {
		return "main/member-my_page";
	}
	
	@RequestMapping(value="sellerPage")
	public String sellerPage() {
		return "main/member-seller_page";
	}
	
	@RequestMapping(value="/serviceCenter")
	public String serviceCenter() {
		return "main/service_center";
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

		/**** 확장자 구하기 시작 ****/
		int index = fileName.lastIndexOf(".");
		// 문자열에서 특정 문자열의 위치 값을 반환한다.
		// indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
		// lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
		// (파일명에 점이 여러개 있을 경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다.)
		logger.info("index = " + index);

		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);

		String refileName = "bbs" + year + month + date + random + "." + fileExtension;
		logger.info("refileName = " + refileName);

		String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
		logger.info("fileDBName = " + fileDBName);
		return fileDBName;
	}
	
}
