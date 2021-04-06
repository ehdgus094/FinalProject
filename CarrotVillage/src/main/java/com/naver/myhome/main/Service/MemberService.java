package com.naver.myhome.main.Service;

import com.naver.myhome.main.domain.Member;

public interface MemberService {
        
    public int join (Member member);
    int joinChk(String field, String value);
    int passwordChk(String email, String password);
	Member memberInfo(String field, String value);
}
