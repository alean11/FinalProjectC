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

	
	
	
	
	
	
	// #y3. 검색어 (미)포함 상품목록
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = sqlsession.selectList("chy.getAccList", optMap);
		for(AccVO accvo : accList) {System.out.println("호텔이름(dao임): "+accvo.getAcc_name());}
		return accList;
	}

	
	// #y3. 검색어 (미)포함 총 게시물 수
	@Override
	public int getAccListCount(HashMap<String, Object> optMap) {
		int totalAccCnt = sqlsession.selectOne("chy.getAccListCount", optMap);
		return totalAccCnt;
	}	

	// #y3. 호텔 등급별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accGradeCnt = sqlsession.selectList("chy.getAccGradeCnt", optMap);
		return accGradeCnt;
	}


	// #y3. 호텔 타입별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accTypeCnt = sqlsession.selectList("chy.getAccTypeCnt", optMap);
		return accTypeCnt;
	}

	
	// #y3. 태그 클라우드
	@Override
	public List<HashMap<String, Object>> getTagList() {
		List<HashMap<String, Object>> tagList = sqlsession.selectList("chy.getTagList");
		return tagList;
	}
	

	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	@Override
	public List<AccVO> getAutoSearchWord(HashMap<String, String> ajaxMap) {
		List<AccVO> weWordList = sqlsession.selectList("chy.getAutoSearchWord", ajaxMap);
		return weWordList;
	}
	
	
	// #y5. 호텔 위치한 지역 뽑아옴.
	@Override
	public List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap) {
		List<HashMap<String, String>> regionList = sqlsession.selectList("chy.getRegionList", ajaxMap);
		return regionList;
	}

	
	// #y8-1. 총 방 개수
	@Override
	public int getTotalRoomCnt(HashMap<String, String> reserveMap) {
		int totalRoomCnt = sqlsession.selectOne("chy.getTotalRoomCnt", reserveMap);
		return totalRoomCnt;
	}

	// #y8-1. 방 종류 테이블에서 해당 방의 개수를 줄임.
	@Override
	public int minusRoomCnt(HashMap<String, String> reserveMap) {
		int n = sqlsession.update("chy.minusRoomCnt", reserveMap);
		return n;
	}

	
	// #y8-2. 특정 방의 정보가 예약 테이블에 있는지 없는지 확인
	@Override
	public int getCheckBookInfo(HashMap<String, String> reserveMap) {
		int checkBookInfo = sqlsession.selectOne("chy.getCheckBookInfo", reserveMap);
		return checkBookInfo;
	}

	// #y8-2. 예약정보가 있을 경우, 특정 날짜에 예약이 가능한지를 확인
	@Override
	public int getAvailableRoom(HashMap<String, String> reserveMap) {
		int availableRoom = sqlsession.selectOne("chy.getAvailableRoom", reserveMap);
		return availableRoom;
	}

	// #y8-2. 예약 테이블에서 해당 방의 예약 날짜를 넣어줌.
	@Override
	public int insertBookDays(HashMap<String, String> reserveMap) {
		int m = sqlsession.insert("chy.insertBookDays", reserveMap);
		return m;
	}

	
	// #y8-3. 예약내용 저장 테이블에 해당 유저의 예약한 내용을 넣어줌.
	@Override
	public int insertReserveInfo(HashMap<String, String> reserveMap) {
		int i = sqlsession.insert("chy.insertReserveInfo", reserveMap);
		return i;
	}




	
	
}
