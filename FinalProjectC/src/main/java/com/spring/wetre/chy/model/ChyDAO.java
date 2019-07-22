package com.spring.wetre.chy.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.AccVO;


/// DAO 선언 ///
@Repository
public class ChyDAO implements InterChyDAO {

	/// myBatis(JDBC) sqlSessionTemplate 의존 객체 주입 ///
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	
	
	
	// #y2. 리스트 뷰단에 뿌려줄 지역명 및 코드를 불러옴.
	@Override
	public List<HashMap<String, String>> getRegionList() {
		List<HashMap<String, String>> regionList = sqlsession.selectList("chy.getRegionList");
		return regionList;
	}
	
	
	// #y3. 호텔 목록 뽑기: 검색어 포함
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = sqlsession.selectList("chy.getAccList", optMap);
		return accList;
	}

	
	// #y3. 호텔 목록 뽑기: 검색어 미포함(전부 뽑기)
	@Override
	public List<AccVO> getAccAllList() {
		List<AccVO> accAllList = sqlsession.selectList("chy.getAccAllList");
		return accAllList;
	}

	
	
	
	
	
	
	
}
