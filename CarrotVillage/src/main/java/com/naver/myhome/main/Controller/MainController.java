package com.naver.myhome.main.Controller;

import java.io.IOException;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.myhome.main.Service.MemberService;
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
		return "main/main";
	}
	
	@RequestMapping(value="login")
	public String login() {
		return "main/login";
	}
	
	@RequestMapping(value="/loginProcess")
	public String loginProcess(String email, String password,
							   @RequestParam(value="remember", defaultValue="", required=false) String remember,
							   HttpServletResponse response,
							   HttpSession session,
							   RedirectAttributes rattr) {
		
		int result = memberService.passwordChk(email, password);
		logger.info("결과 : " + result);
		logger.info("remember : " + remember);
		
		if (result == 1) {
			session.setAttribute("user_info", memberService.memberInfo("email", email));
			/*Cookie saveCookie = new Cookie("saveid", id);
			if(!remember.equals("")) {
				saveCookie.setPath("/myhome");
				saveCookie.setMaxAge(60*60);
				logger.info("쿠키저장 : 60*60");
			} else {
				logger.info("쿠키저장 : 0");
				saveCookie.setPath("/myhome");
				saveCookie.setMaxAge(0);
			}
			response.addCookie(saveCookie);*/
		} 
		rattr.addFlashAttribute("result", result);
		return "redirect:login";
	}
	
	@RequestMapping(value="naverLogin")
	public String naverLoginProcess() {
		return "main/naverLogin";
	}
	
	@ResponseBody
	@RequestMapping(value="naverLoginProcess")
	public void NaverLoginProcess(HttpSession session,
								  @RequestParam(value = "email") String email,
								  @RequestParam(value = "name") String name,
								  @RequestParam(value = "profile_image") String profile_image) {
		logger.info("email = " + email + ", name = " + name + ", profile_image = " + profile_image);
		session.setAttribute("naver_email", email);
		session.setAttribute("naver_name", name);
		session.setAttribute("naver_profile_image", profile_image);
	}
	
	@RequestMapping(value="joinTerms")
	public String joinTerms() {
		return "main/join_terms";
	}
	
	@RequestMapping(value="join")
	public String join() {
		return "main/join";
	}
	
	@ResponseBody
	@RequestMapping(value="joinCheck") 
	public Map<String, String> joinCheck(@RequestParam(value = "field", required = false) String field,
									   @RequestParam(value = "value", required = false) String value) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", memberService.joinChk(field, value)+"");
		return map;
	}
	
	@RequestMapping(value="joinProcess")
	public String joinProcess(Member member, Model model, HttpServletRequest request) {
		String encPassword = passwordEncoder.encode(member.getPassword());
		logger.info(encPassword);
		member.setPassword(encPassword);
		
		int result = memberService.join(member);
		if (result == 1) {
			return "redirect:login";
		} else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "회원 가입 실패");
			return "error/error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="logout")
	public void logout(HttpSession session) throws IOException {
		session.invalidate();
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
	
	/*@ResponseBody
	@RequestMapping(value = "emailAuth")
    public Map<String,Object> mailSend(@RequestParam(value="email") String email) throws IOException {
        Random random = new Random();
        int authKey = random.nextInt(4589362) + 49311;
        
        String title = "회원가입 인증 이메일 입니다.";
        String content = "인증번호 = " + authKey;
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            logger.info(message.toString());
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom("project.sender.21@gamil.com");
            messageHelper.setTo(email);
            messageHelper.setSubject(title);
            messageHelper.setText(content);
            
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("authKey", authKey);
        
        return map;  
    }
    */
	
}
