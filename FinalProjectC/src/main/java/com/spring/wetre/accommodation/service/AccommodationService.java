package com.spring.wetre.accommodation.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.wetre.accommodation.model.InterAccommodationDAO;
import com.spring.wetre.common.*;
import com.spring.wetre.model.*;


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


	
	
	
	// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
	@Override
	public AccVO getOneAccInfomation(int acc_idx) {
		
		AccVO avo = dao.getOneAccInfomation(acc_idx);
		return avo;
	}
	
	// 숙박시설 추가이미지 조회해오기
	@Override
	public List<HashMap<String,String>> getAddaccImg(int acc_idx) {
		List<HashMap<String,String>> addaccImgList = dao.getAddaccImg(acc_idx);
		return addaccImgList;
	}
			
	// 구글 지도 사용하기
	@Override
	public String getAccMapList(int acc_idx) {
		String accList = dao.getAccMapList(acc_idx);
		return accList;
	}

	
	// 객실 종류 및 요금 조회하기
	@Override
	public List<HashMap<String, String>> getRoomTypeAndPrice(HashMap<String, Object> paraMap) {
		
		List<String> ridx = dao.getRidx(paraMap);
		HashMap<String, Object> ridxMap = new HashMap<String, Object>();
		ridxMap.put("ridx", ridx);
		
		int n = dao.getBookingCheck(ridxMap);
		
		List<HashMap<String, String>> roomList = null;
		if(n != 0) {
			roomList = dao.getRoomTypeAndPrice(paraMap);
		}
		else {
			roomList = dao.getRoomTypeAndPriceNotBookDays(paraMap);			
		}
		return roomList;
	}
	

	// ajax를 이용해서 좋아요 갯수 가져오기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})  // READ_COMMITTED는  select는 commit 한 것만 읽어오겠다.
	public int like(HashMap<String, Object> paraMap) throws Throwable {
		int n = dao.insertLike(paraMap);
		int m = dao.deleteDislike(paraMap);
		return n*m;
	}
	
	
	// ajax를 이용해서 좋아요 갯수 가져오기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})  // READ_COMMITTED는  select는 commit 한 것만 읽어오겠다.
	public int disLike(HashMap<String, Object> paraMap) throws Throwable {
		int n = dao.insertDislike(paraMap);
		int m = dao.deleteLike(paraMap);
		return n*m;
	}

	
	// 댓글쓰기
	@Override
	public int addComment(CommentVO cmtvo) {
		int n = dao.addComment(cmtvo);
		return n;
	}

	// 댓글 보여주기 
	@Override
	public List<CommentVO> commentVOList(String acc_idx) {
		List<CommentVO> commentList = dao.commentVOList(acc_idx);
		return commentList;
	}

	// 좋아요 싫어요 갯수 구하기
	@Override
	public HashMap<String, Integer> getLikeDislikeCount(String acc_idx) {
		HashMap<String, Integer> likeDislikeMap = dao.getLikeDislikeCount(acc_idx);
		return likeDislikeMap;
	}
	
	// 지도 검색 페이지
	@Override
	public List<AccVO> getStoreMap() {
		List<AccVO> storemapList = dao.getStoreMap();
		return storemapList;
	}

	
	
	// 태그 테이블 인서트/업데이트
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int hoteltag(String acc_idx) throws Throwable {
		
		int n = dao.getAccTagListCnt(acc_idx);
		int m = 0;
		
		if (n != 0) {
			m = dao.updateHotelTagCnt(acc_idx);
		}		
		return n*m;
	}
	
	
	
	
	
}
