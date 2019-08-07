package com.spring.wetre.chy.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.common.AES256;
import com.spring.wetre.chy.model.InterAccommodationDAO;
import com.spring.wetre.model.AccVO;

/// 서비스 선언 ///
@Service
public class AccommodationService implements InterAccommodationService {

	/// DAO 의존객체 주입  ///
	@Autowired
	private InterAccommodationDAO dao;

	/// 암호화/복호화 의존객체 주입 ///
	@Autowired
	private AES256 aes;

	
	
	
	

	// #y3. 검색어 (미)포함 상품목록
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = dao.getAccList(optMap);
		return accList;
	}
	
	// #y3. 검색어 (미)포함 총 게시물 수
	@Override
	public int getAccListCount(HashMap<String, Object> optMap) {
		int totalAccCnt = dao.getAccListCount(optMap);
		return totalAccCnt;
	}

	// #y3. 호텔 등급별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accGradeCnt = dao.getAccGradeCnt(optMap);
		return accGradeCnt;
	}

	// #y3. 호텔 타입별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accTypeCnt = dao.getAccTypeCnt(optMap);
		return accTypeCnt;
	}
	
	// #y3. 태그 클라우드
	@Override
	public List<HashMap<String, Object>> getTagList() {
		List<HashMap<String, Object>> tagList = dao.getTagList();
		return tagList;
	}

	
	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	@Override
	public List<AccVO> autoSearchWord(HashMap<String, String> ajaxMap) {
		List<AccVO> weWordList = dao.getAutoSearchWord(ajaxMap);
		return weWordList;
	}


	// #y5. 호텔 위치한 지역 뽑아옴.
	@Override
	public List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap) {
		List<HashMap<String, String>> regionList = dao.getRegionList(ajaxMap);
		return regionList;
	}

	
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

	
	
}
