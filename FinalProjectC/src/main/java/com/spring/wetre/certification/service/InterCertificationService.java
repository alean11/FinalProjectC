package com.spring.wetre.certification.service;

import java.util.HashMap;


public interface InterCertificationService {

	// 아이디 찾기
	String idFind(HashMap<String, String> map);

	// 비번 찾기
	int pwdChange(HashMap<String, String> map);
	
	// 이메일 인증 시 이메일 찾기
	int checkEmail(HashMap<String, String> paramap);
	
	// 폰번호 인증 시 폰번호 찾기
	int telcheck(HashMap<String, String> paramap);
	
}
