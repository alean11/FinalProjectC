package com.spring.wetre.payment.model;

import java.util.HashMap;
import java.util.List;

import com.spring.wetre.model.CartVO;

public interface InterPaymentDAO {

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

	List<CartVO> selectCartList(String userid);

	CartVO selectCartOne(HashMap<String, String> para);
	
}
