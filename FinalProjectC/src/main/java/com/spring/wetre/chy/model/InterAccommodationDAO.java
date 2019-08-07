package com.spring.wetre.chy.model;

import java.util.*;

import com.spring.wetre.model.AccVO;

public interface InterAccommodationDAO {


	// #y3. 검색어 (미)포함 상품목록
	List<AccVO> getAccList(HashMap<String, Object> optMap);

	// #y3. 검색어 (미)포함 총 게시물 수
	int getAccListCount(HashMap<String, Object> optMap);

	// #y3. 호텔 등급별 개수 뽑기
	List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap);

	// #y3. 호텔 타입별 개수 뽑기
	List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap);

	// #y3. 태그 클라우드
	List<HashMap<String, Object>> getTagList();
	
	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	List<AccVO> getAutoSearchWord(HashMap<String, String> ajaxMap);

	// #y5. 호텔 위치한 지역 뽑아옴.
	List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap);

	// #y8-1. 총 방 개수
	int getTotalRoomCnt(HashMap<String, String> reserveMap);

	// #y8-1. 방 종류 테이블에서 해당 방의 개수를 줄임.
	int minusRoomCnt(HashMap<String, String> reserveMap);

	// #y8-2. 특정 방의 정보가 예약 테이블에 있는지 없는지 확인
	int getCheckBookInfo(HashMap<String, String> reserveMap);

	// #y8-2. 예약정보가 있을 경우, 특정 날짜에 예약이 가능한지를 확인
	int getAvailableRoom(HashMap<String, String> reserveMap);

	// #y8-2. 예약 테이블에서 해당 방의 예약 날짜를 넣어줌.
	int insertBookDays(HashMap<String, String> reserveMap);

	// #y8-3. 예약내용 저장 테이블에 해당 유저의 예약한 내용을 넣어줌.
	int insertReserveInfo(HashMap<String, String> reserveMap);



	



}
