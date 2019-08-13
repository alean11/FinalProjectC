package com.spring.wetre.certification.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.wetre.certification.model.InterCertificationDAO;
import com.spring.wetre.common.AES256;



@Service
public class CertificationService implements InterCertificationService {

	
	@Autowired
	private InterCertificationDAO dao;
	
	@Autowired
	private AES256 aes;
	
	
	
	@Override
	public String idFind(HashMap<String, String> map) {
		return dao.idFind(map);
	}

	@Override
	public int pwdChange(HashMap<String, String> map) {
		return dao.pwdChange(map);
	}

	@Transactional
	@Override
	public int checkEmail(HashMap<String, String> paramap) {
	try {
			 paramap.put("email", aes.encrypt(paramap.get("email")));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return dao.checkEmail(paramap);
	}

	@Override
	public int telcheck(HashMap<String, String> paramap) {
		return dao.telcheck(paramap);
	}

}
