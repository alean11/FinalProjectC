package com.spring.wetre.chy.service;

import java.util.*;

import com.spring.wetre.model.AccVO;

public interface InterAccommodationService {

	// #y2. 리스트 뷰단에 뿌려줄 지역명 및 코드를 불러옴.
	List<HashMap<String, String>> getRegionList();

	// #y2. 호텔 목록 뽑기: 검색어 포함
	List<AccVO> getAccList(HashMap<String, Object> optMap);

	// #y2. 뷰단 옵션에 뿌려줄 호텔 등급별 개수 가져옴.
	List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap);

	// #y2. 뷰단 옵션에 뿌려줄 호텔 타입별 개수 가져옴.
	List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap);

	

}
