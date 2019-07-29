package com.spring.wetre.lyg.model;

import java.util.HashMap;
import java.util.List;

import javax.activation.CommandMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.lyg.controller.RoomVO;
import com.spring.wetre.model.AccVO;


// === #32. DAO 선언 ===
@Repository
public class contactDAO implements InterContactDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired 
	private SqlSessionTemplate sqlsession;

	@Override
	public int hoteltag(String acc_idx) {
		int n = sqlsession.insert("lyg.hoteltag", acc_idx);
		return n;
	}
	
	
	@Override
	public List<RoomVO> roomedetail(String r_idx) {
		List<RoomVO> rmList = sqlsession.selectList("lyg.roomedetail", r_idx);
		return rmList;
	}

	@Override
	public boolean isUserExists(HashMap<String, String> paramap) {
		
		boolean isUserExists = false;
		
		int n = sqlsession.selectOne("lyg.isUserExists", paramap);
		System.out.println(n);
		if(n==1) {
			isUserExists = true;
			}
		else {
			isUserExists = false;
			}
		return isUserExists;
	}


	@Override
	public List<AccVO> getStoreMap() {
		List<AccVO> storemapList = sqlsession.selectList("lyg.getStoreMap");
		return storemapList;
	}




	@Override
	public int checkEmail(String email) {
		return sqlsession.selectOne("lyg.checkEmail", email);
	}

	
	
}
