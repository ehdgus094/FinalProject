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
	public int join(Member m) {
		return dao.insert(m);
	}
	
	@Override
	public int joinChk(String field, String value) {
		Member member = memberInfo(field, value);
		return (member == null) ? -1 : 1;
	}

	@Override
	public int passwordChk(String email, String password) {
		
		Member member = memberInfo("email", email);
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
	public Member memberInfo(String field, String value) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("field", field);
		map.put("value", value);
		return dao.memberInfo(map);
	}

}
