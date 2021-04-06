package com.naver.myhome.main.security;

import java.util.ArrayList;
import java.util.Collection;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.naver.myhome.main.domain.Member;

/*
 * 1. UserDetailService 인터페이스는 DB에서 유저 정보를 불러오는 loadUserByUsername()이 존재합니다.
 * 		이를 구현하는 클래스는 DB에서 유저의 정보를 가져와서 UserDetails 타입으로 리턴해주는 작업을 합니다.
 * 2. UserDetails는 인터페이스로 Security에서 사용자의 정보를 담는 인터페이스입니다.
 * 3. UserDetails 인터페이스를 구현한 클래스는 실제로 사용자의 정보와 사용자가 가진 권한의 정보를 처리해서 반환하게 됩니다.
 * 	예) UserDetails user = new User(username, users.getPassword(), roles);
 */

@Service
public class CustomUserDetailsService implements UserDetailsService {
	private static final Logger logger
	= LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		logger.info("username은 로그인시 입력한 값 : " + username);
		Member users = sqlSession.selectOne("member.idcheck", username);
		if (users == null) {
			logger.info("username " + username + " not found");
			throw new UsernameNotFoundException("username " + username + " not found") ;
		}
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		roles.add(new SimpleGrantedAuthority(users.getAuth()));
		UserDetails user = new User(username, users.getPassword(), roles);
		return user;
	}
}
