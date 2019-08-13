package com.spring.wetre.payment.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.CartVO;

@Repository
public class PaymentDAO implements InterPaymentDAO {

	
	@Autowired 
	private SqlSessionTemplate sqlsession;
	
	
	
	// #y8-1. 총 방 개수
	@Override
	public int getTotalRoomCnt(HashMap<String, String> reserveMap) {
		int totalRoomCnt = sqlsession.selectOne("payment.getTotalRoomCnt", reserveMap);
		return totalRoomCnt;
	}


	// #y8-1. 방 종류 테이블에서 해당 방의 개수를 줄임.
	@Override
	public int minusRoomCnt(HashMap<String, String> reserveMap) {
		int n = sqlsession.update("payment.minusRoomCnt", reserveMap);
		return n;
	}

	
	// #y8-2. 특정 방의 정보가 예약 테이블에 있는지 없는지 확인
	@Override
	public int getCheckBookInfo(HashMap<String, String> reserveMap) {
		int checkBookInfo = sqlsession.selectOne("payment.getCheckBookInfo", reserveMap);
		return checkBookInfo;
	}


	// #y8-2. 예약정보가 있을 경우, 특정 날짜에 예약이 가능한지를 확인
	@Override
	public int getAvailableRoom(HashMap<String, String> reserveMap) {
		int availableRoom = sqlsession.selectOne("payment.getAvailableRoom", reserveMap);
		return availableRoom;
	}

	
	// #y8-2. 예약 테이블에서 해당 방의 예약 날짜를 넣어줌.
	@Override
	public int insertBookDays(HashMap<String, String> reserveMap) {
		int m = sqlsession.insert("payment.insertBookDays", reserveMap);
		return m;
	}


	// #y8-3. 예약내용 저장 테이블에 해당 유저의 예약한 내용을 넣어줌.
	@Override
	public int insertReserveInfo(HashMap<String, String> reserveMap) {
		int i = sqlsession.insert("payment.insertReserveInfo", reserveMap);
		return i;
	}
	
	
	@Override
	public List<CartVO> selectCartList(String userid) {
		return sqlsession.selectList("payment.selectCartList", userid);
	}


	@Override
	public CartVO selectCartOne(HashMap<String, String> para) {
		return sqlsession.selectOne("payment.selectCartOne", para);
	}

}
