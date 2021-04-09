package com.naver.myhome.main.Service;

import com.naver.myhome.main.domain.Member;

public interface MemberService {
        
    public int insert(Member member);
    int memberChk(String field, String value, String login_type);
    int passwordChk(String id, String password);
    Member memberInfo(String id);
	Member memberInfo(String field, String value, String login_type);
}
