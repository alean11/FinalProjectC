package com.spring.wetre.chy.model;

import java.util.*;

import com.spring.wetre.model.AccVO;

public interface InterChyDAO {

	// #y2. 리스트 뷰단에 뿌려줄 지역명 및 코드를 불러옴.
	List<HashMap<String, String>> getRegionList();

	// #y3. 호텔 목록 뽑기: 검색어 포함
	List<AccVO> getAccList(HashMap<String, Object> optMap);

	// #y3. 호텔 목록 뽑기: 검색어 미포함(전부 뽑기)
	List<AccVO> getAccAllList();

}
