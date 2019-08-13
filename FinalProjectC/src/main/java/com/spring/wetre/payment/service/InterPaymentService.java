package com.spring.wetre.payment.service;

import java.util.HashMap;
import java.util.List;

import com.spring.wetre.model.CartVO;


public interface InterPaymentService {
	
	// #y8-3. 예약내용 저장 테이블에 해당 유저의 예약한 내용을 넣어줌.
	int insertReserveInfo(HashMap<String, String> reserveMap) throws Throwable;
	
	List<CartVO> selectCartList(String userid);

	CartVO selectCartOne(HashMap<String, String> para);
	
	
}
