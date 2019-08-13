package com.spring.wetre.payment.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.wetre.model.CartVO;
import com.spring.wetre.payment.model.InterPaymentDAO;


@Service
public class PaymentService implements InterPaymentService {

	
	
	@Autowired
	private InterPaymentDAO dao;

	
	// #y8. 결제 후 유저 장바구니(예약정보 넣는 곳) 테이블에 정보 넣기: 트랜잭션
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertReserveInfo(HashMap<String, String> reserveMap) throws Throwable {
		
		int result = 0;
		
		/// #y8-1. 방 종류 테이블에서 해당 방의 개수를 줄임: 총 방 개수 - 유저가 예약한 방 개수 < 0 이라면 update DB 못 돌리게 해야함.
		// 유저가 예약한 방 개수
		int userRoomCnt = Integer.parseInt(reserveMap.get("cart_cnt"));
		// 총 방 개수
		int totalRoomCnt = dao.getTotalRoomCnt(reserveMap); 
		int n = 0;
		if( (totalRoomCnt - userRoomCnt ) > 0 ) {
			n = dao.minusRoomCnt(reserveMap);
		}
						
					
		/// #y8-2. 예약 테이블에서 해당 방의 예약 날짜를 넣어줌: 예약 테이블에 시작날짜 & 끝날짜 넣고, 반환되는 값이 null 또는 ""이 아니라면, 넣어줌.
		int checkBookInfo = dao.getCheckBookInfo(reserveMap); // 우선 특정 방의 정보가 예약 테이블에 있는지 없는지 확인
		
		int availableRoom = 0;
		int m = 0;
		
		if(checkBookInfo != 0) { // 특정 방의 예약정보가 있는 경우
			availableRoom = dao.getAvailableRoom(reserveMap); // 예약정보가 있을 경우, 특정 날짜에 예약이 가능한지를 확인
			if(availableRoom != 0) { // 특정 날짜에 예약이 가능하다면, 예약 테이블에 insert
				m = dao.insertBookDays(reserveMap);
			}
		}
		else { // 특정방의 예약정보가 없는 경우: 바로 insert를 함.
			m = dao.insertBookDays(reserveMap);			
		}
		
		
		/// #y8-3. 위의 사항이 다 맞았으면, 예약내용 저장 테이블에 해당 유저의 예약한 내용을 넣어줌.
		int i = 0;
		if(n*m != 0) {
			i = dao.insertReserveInfo(reserveMap);
		}
				
		result = n*m*i;
		return result; // 0만 아니면 성공
		
	} // end of 결제 후 유저 장바구니(예약정보 넣는 곳) 테이블에 정보 넣기 ----------	
	
	
	
	@Override
	public List<CartVO> selectCartList(String userid) {
		return dao.selectCartList(userid);
	}

	@Override
	public CartVO selectCartOne(HashMap<String, String> para) {
		return dao.selectCartOne(para);
	}

	
	
	
}
