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
import org.springframework.web.bind.annotation.CookieValue;
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
		return "main/main_page";
	}
	
	
	@RequestMapping(value="login")
	public String login() {
		return "main/login";
	}
	
	@ResponseBody
	@RequestMapping(value="keepLogin")
	public void keepLogin(@RequestParam(value = "email") String email,
										  HttpSession session,
										  HttpServletResponse response) {
		Member member = memberService.memberInfo("email", email, "normal");
		session.setAttribute("user_info", member);
		Cookie cookie = new Cookie("saveLogin", email);
		cookie.setPath("/myhome");
		cookie.setMaxAge(60*60*24*7);
		
		response.addCookie(cookie);
	}
	
	@RequestMapping(value="/loginProcess")
	public String loginProcess(Member member, String login_chk,
							   HttpServletResponse response,
							   HttpSession session,
							   RedirectAttributes rattr) {
		
		logger.info("login_chk = " + login_chk);
		int result = 0;
		Member lmember = new Member();

		switch (member.getLogin_type()) {
		case "normal":
			result = memberService.passwordChk(member.getEmail(), member.getPassword());
			break;
		case "naver":
			result = memberService.memberChk("email", member.getEmail(), "naver");
			break;
		case "kakao":
			result = memberService.memberChk("email", member.getEmail(), "kakao");
			break;
		}
		
		if (result == 1) {
			lmember = memberService.memberInfo("email", member.getEmail(), member.getLogin_type());
			session.setAttribute("user_info", lmember);
			Cookie cookie = new Cookie("saveLogin", lmember.getEmail());
			if (member.getLogin_type() == "normal") {
				if (login_chk == "1") {
					cookie.setPath("/myhome");
					cookie.setMaxAge(60*60*24*7);
				} else {
					cookie.setPath("/myhome");
					cookie.setMaxAge(0);
				}
			}
			
			response.addCookie(cookie);
		}
		
		rattr.addFlashAttribute("result", result);
		rattr.addFlashAttribute("email", member.getEmail());
		rattr.addFlashAttribute("password", member.getPassword());
		return "redirect:login";
	}
	
	@RequestMapping(value="naverLogin")
	public String naverLogin() {
		return "main/naver_login";
	}
	
	@RequestMapping(value="kakaoLogin")
	public String kakaoLogin() {
		return "main/kakao_login";
	}
	
	@ResponseBody
	@RequestMapping(value="socialLoginProcess")
	public Map<String, Object> naverLoginProcess( @RequestParam(value = "email") String email,
								  				  @RequestParam(value = "name") String name,
								  				  @RequestParam(value = "profile_image", required=false) String profile_image,
								  				  @RequestParam(value = "login_type") String login_type) {
		System.out.println(login_type);
		Member member = new Member();
		int result = memberService.memberChk("email", email, login_type);
		if (result == -1) {
			if (profile_image == null)
				profile_image = "default.png";
			member.setEmail(email);member.setLogin_type(login_type);
			member.setName(name);member.setProfile_img(profile_image);
			memberService.insertSocial(member);
		}
		
		member = memberService.memberInfo("email", email, login_type);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", member.getEmail());
		return map;
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
		map.put("result", memberService.memberChk(field, value, "normal")+"");
		return map;
	}
	
	@RequestMapping(value="joinProcess")
	public String joinProcess(Member member, HttpServletRequest request, RedirectAttributes rattr) {
		
		String encPassword = passwordEncoder.encode(member.getPassword());
		logger.info(encPassword);
		member.setPassword(encPassword);
		member.setLogin_type("normal");
		
		int result = memberService.insert(member);
		if (result == 1) {
			rattr.addAttribute("result", "joinSuccess");
			return "redirect:login";
		} else {
			return "redirect:login";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="logout")
	public void logout(HttpSession session,
					   HttpServletResponse response,
					   HttpServletRequest request,
					   @CookieValue(value="saveLogin", required=false) Cookie readCookie) {
		Member member = (Member) session.getAttribute("user_info");
		
		if (member.getLogin_type() == "normal") {
			if (readCookie != null) {
				readCookie.setMaxAge(0);
			}
		}
		
		response.addCookie(readCookie);
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
	
	@RequestMapping(value="/serviceCenter")
	public String serviceCenter() {
		return "main/service_center";
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
