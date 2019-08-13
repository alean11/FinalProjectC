package com.spring.wetre.accommodation.model;

import java.util.*;

import com.spring.wetre.model.*;


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


	
	// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
	AccVO getOneAccInfomation(int acc_idx);

	// 숙박시설 추가이미지 조회해오기
	List<HashMap<String,String>> getAddaccImg(int acc_idx);
	
	// 구글 지도 사용하기
	String getAccMapList(int acc_idx);

	
	// 객실 종류 및 요금 조회하기
	List<HashMap<String, String>> getRoomTypeAndPrice(HashMap<String, Object> paraMap);
	List<String> getRidx(HashMap<String, Object> paraMap);
	int getBookingCheck(HashMap<String, Object> ridxMap);
	List<HashMap<String, String>> getRoomTypeAndPriceNotBookDays(HashMap<String, Object> paraMap);

	
	// ajax를 이용해서 좋아요 갯수 가져오기
	int insertLike(HashMap<String, Object> paraMap);
	int deleteDislike(HashMap<String, Object> paraMap);
	
	// ajax를 이용해서 싫어요 갯수 가져오기
	int insertDislike(HashMap<String, Object> paraMap);
	int deleteLike(HashMap<String, Object> paraMap);

	// 댓글쓰기
	int addComment(CommentVO cmtvo);

	// 댓글 보여주기
	List<CommentVO> commentVOList(String acc_idx);

	// 좋아요 싫어요 갯수 구하기
	HashMap<String, Integer> getLikeDislikeCount(String acc_idx);
	


	// 지도 검색 페이지
	List<AccVO> getStoreMap();
	
	// 태그 테이블 인서트
	int getAccTagListCnt(String acc_idx);
	int updateHotelTagCnt(String acc_idx);




}
