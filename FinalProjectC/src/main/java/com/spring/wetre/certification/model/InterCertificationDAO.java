package com.spring.wetre.certification.model;

import java.util.HashMap;

public interface InterCertificationDAO {

	String idFind(HashMap<String, String> map);
	
	int pwdChange(HashMap<String, String> map);
	
	int checkEmail(HashMap<String, String> paramap);
	
	int telcheck(HashMap<String, String> paramap);
}
