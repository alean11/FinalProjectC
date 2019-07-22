package com.spring.wetre.chy.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.wetre.chy.model.InterChyDAO;
import com.spring.wetre.model.AccVO;

/// 서비스 선언 ///
@Service
public class ChyService implements InterChyService {

	/// DAO 의존객체 주입  ///
	@Autowired
	private InterChyDAO dao;

	/// 암호화/복호화 의존객체 주입 ///
	@Autowired
	private AES256 aes;

	
	
	
	
	// #y2. 리스트 뷰단에 뿌려줄 지역명 및 코드를 불러옴.
	@Override
	public List<HashMap<String, String>> getRegionList() {
		List<HashMap<String, String>> regionList = dao.getRegionList();
		return regionList;
	}


	// #y3. 호텔 목록 뽑기: 검색어 포함
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = dao.getAccList(optMap);
		return accList;
	}

	
	// #y3. 호텔 목록 뽑기: 검색어 미포함(전부 뽑기)
	@Override
	public List<AccVO> getAccAllList() {
		List<AccVO> accAllList = dao.getAccAllList();
		return accAllList;
	}
	
	
	
}
