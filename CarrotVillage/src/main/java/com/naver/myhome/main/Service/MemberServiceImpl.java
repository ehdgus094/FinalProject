package com.naver.myhome.main.Service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.naver.myhome.main.dao.MemberDAO;
import com.naver.myhome.main.domain.Member;
 
@Service
public class MemberServiceImpl implements MemberService {
    
	@Autowired
    MemberDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
    
	@Override
	public int insert(Member member) {
		return dao.insert(member);
	}
	
	@Override
	public int insertSocial(Member member) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", member.getEmail());
		map.put("name", member.getName());
		map.put("profile_img", member.getProfile_img());
		map.put("login_type", member.getLogin_type());
		return dao.insertSocial(map);
	}
	
	@Override
	public int memberChk(String field, String value, String login_type) {
		Member member = memberInfo(field, value, login_type);
		return (member == null) ? -1 : 1;
	}

	@Override
	public int passwordChk(String email, String password) {
		
		Member member = memberInfo("email", email, "normal");
		int result = -1;
		if (member != null) {
			if (passwordEncoder.matches(password, member.getPassword())) {
				result = 1;
			} else {
				result = 0;
			}
		}
		
		return result;
	}

	@Override
	public Member memberInfo(String field, String value, String login_type) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("field", field);
		map.put("value", value);
		map.put("login_type", login_type);
		return dao.memberInfo(map);
	}

}
