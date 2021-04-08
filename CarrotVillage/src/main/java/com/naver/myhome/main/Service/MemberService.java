package com.naver.myhome.main.Service;

import com.naver.myhome.main.domain.Member;

public interface MemberService {
        
    public int insert(Member member);
    int insertSocial(Member member);
    int memberChk(String field, String value, String login_type);
    int passwordChk(String email, String password);
	Member memberInfo(String field, String value, String login_type);
}
