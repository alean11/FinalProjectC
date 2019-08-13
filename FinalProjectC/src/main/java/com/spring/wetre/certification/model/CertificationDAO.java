package com.spring.wetre.certification.model;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class CertificationDAO implements InterCertificationDAO {

	
	
	@Autowired 
	private SqlSessionTemplate sqlsession;
	
	
	
	@Override
	public String idFind(HashMap<String, String> map) {
		String result = "";
		if("1".equals(map.get("type")))
			result = sqlsession.selectOne("certification.idFindPer", map);
		else if("2".equals(map.get("type")))
			result = sqlsession.selectOne("certification.idFindCom", map);
		return result;
	}

	@Override
	public int pwdChange(HashMap<String, String> map) {
		int n = 0;
		if("1".equals(map.get("type")))
			n = sqlsession.update("certification.pwdChangePer", map);
		else if("2".equals(map.get("type")))
			n = sqlsession.update("certification.pwdChangeCom", map);
		return n;
	}

	@Override
	public int checkEmail(HashMap<String, String> paramap) {
		int n = 0;
		if("2".equals(paramap.get("type")))
			n =sqlsession.selectOne("certification.checkEmailCom", paramap);
		else
			n =sqlsession.selectOne("certification.checkEmailPer", paramap);			
		return n;
	}

	@Override
	public int telcheck(HashMap<String, String> paramap) {
		int telcheck = 0;
		
		if (paramap.get("userType").equals("personal_mbr")) {
			telcheck = (int) sqlsession.selectOne("certification.perTelCheck", paramap);			
		}
		else if (paramap.get("userType").equals("company_mbr")) {
			telcheck = (int) sqlsession.selectOne("certification.comTelCheck", paramap);						
		}
		
		return telcheck;
		
	}

}
