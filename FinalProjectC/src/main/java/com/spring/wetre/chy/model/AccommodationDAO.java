package com.spring.wetre.chy.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.AccVO;


/// DAO 선언 ///
@Repository
public class AccommodationDAO implements InterAccommodationDAO {

	/// myBatis(JDBC) sqlSessionTemplate 의존 객체 주입 ///
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	
	
	
	// #y2. 리스트 뷰단에 뿌려줄 지역명 및 코드를 불러옴.
	@Override
	public List<HashMap<String, String>> getRegionList() {
		List<HashMap<String, String>> regionList = sqlsession.selectList("chy.getRegionList");
		return regionList;
	}
	
	
	// #y2. 호텔 목록 뽑기: 검색어 포함
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = sqlsession.selectList("chy.getAccList", optMap);
		for(AccVO accvo : accList) {
			System.out.println("호텔이름(dao임): "+accvo.getAcc_name());
		}
		return accList;
	}


	// #y2. 호텔 등급별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accGradeCnt = sqlsession.selectList("chy.getAccGradeCnt", optMap);
		return accGradeCnt;
	}


	// #y2. 호텔 타입별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accTypeCnt = sqlsession.selectList("chy.getAccTypeCnt", optMap);
		return accTypeCnt;
	}
	
	
	
	
	
}
