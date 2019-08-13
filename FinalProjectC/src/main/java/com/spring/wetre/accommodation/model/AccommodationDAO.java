package com.spring.wetre.accommodation.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.*;



/// DAO 선언 ///
@Repository
public class AccommodationDAO implements InterAccommodationDAO {

	/// myBatis(JDBC) sqlSessionTemplate 의존 객체 주입 ///
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	// #y3. 검색어 (미)포함 상품목록
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = sqlsession.selectList("accommodation.getAccList", optMap);
		/*for(AccVO accvo : accList) {System.out.println("호텔이름(dao임): "+accvo.getAcc_name());}*/
		return accList;
	}

	
	// #y3. 검색어 (미)포함 총 게시물 수
	@Override
	public int getAccListCount(HashMap<String, Object> optMap) {
		int totalAccCnt = sqlsession.selectOne("accommodation.getAccListCount", optMap);
		return totalAccCnt;
	}	

	// #y3. 호텔 등급별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accGradeCnt = sqlsession.selectList("accommodation.getAccGradeCnt", optMap);
		return accGradeCnt;
	}


	// #y3. 호텔 타입별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accTypeCnt = sqlsession.selectList("accommodation.getAccTypeCnt", optMap);
		return accTypeCnt;
	}

	
	// #y3. 태그 클라우드
	@Override
	public List<HashMap<String, Object>> getTagList() {
		List<HashMap<String, Object>> tagList = sqlsession.selectList("accommodation.getTagList");
		return tagList;
	}
	

	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	@Override
	public List<AccVO> getAutoSearchWord(HashMap<String, String> ajaxMap) {
		List<AccVO> weWordList = sqlsession.selectList("accommodation.getAutoSearchWord", ajaxMap);
		return weWordList;
	}
	
	
	// #y5. 호텔 위치한 지역 뽑아옴.
	@Override
	public List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap) {
		List<HashMap<String, String>> regionList = sqlsession.selectList("accommodation.getRegionList", ajaxMap);
		return regionList;
	}


	
	
	// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기(ex: 숙박시설 이름, 주소 등)
	@Override
	public AccVO getOneAccInfomation(int acc_idx) {
		AccVO avo = sqlsession.selectOne("accommodation.getOneAccInfomation", acc_idx);		
		return avo;
	}

	// 숙박시설 추가이미지 조회해오기
	@Override
	public List<HashMap<String,String>> getAddaccImg(int acc_idx) {
		List<HashMap<String,String>> addaccImgList = sqlsession.selectList("accommodation.getAddaccImg", acc_idx);		
		return addaccImgList;
	}
			
	// 구글 지도 사용하기
	@Override
	public String getAccMapList(int acc_idx) {
		String accList = sqlsession.selectOne("accommodation.getAccMapList", acc_idx);
		return accList;
	}

	// 객실 종류 및 요금 조회하기
	@Override
	public List<String> getRidx(HashMap<String, Object> paraMap) {
		List<String> ridx = sqlsession.selectList("accommodation.getRidx", paraMap);
		return ridx;
	}
	@Override
	public int getBookingCheck(HashMap<String, Object> ridxMap) {
		int n = sqlsession.selectOne("accommodation.getBookingCheck", ridxMap);
		return n;
	}
	@Override
	public List<HashMap<String, String>> getRoomTypeAndPrice(HashMap<String, Object> paraMap) {
		List<HashMap<String,String>> roomList = sqlsession.selectList("accommodation.getRoomTypeAndPrice", paraMap);
		return roomList;
	}
	@Override
	public List<HashMap<String, String>> getRoomTypeAndPriceNotBookDays(HashMap<String, Object> paraMap) {
		List<HashMap<String,String>> roomListNotBookDay = sqlsession.selectList("accommodation.getRoomTypeAndPriceNotBookDays", paraMap);
		return roomListNotBookDay;
	}
	


	// ajax를 이용해서 좋아요 갯수 가져오기
	@Override
	public int insertLike(HashMap<String, Object> paraMap) {
		int n = sqlsession.insert("accommodation.insertLike", paraMap);		
		return n;
	}
	@Override
	public int deleteDislike(HashMap<String, Object> paraMap) {
		int n = sqlsession.delete("accommodation.deleteDislike", paraMap);		
		return n;
	}
	
	// ajax를 이용해서 좋아요 갯수 가져오기
	@Override
	public int insertDislike(HashMap<String, Object> paraMap) {
		int n = sqlsession.insert("accommodation.insertDislike", paraMap);		
		return n;
	}
	@Override
	public int deleteLike(HashMap<String, Object> paraMap) {
		int n = sqlsession.delete("accommodation.deleteLike", paraMap);		
		return n;
	}

	// 댓글 쓰기
	@Override
	public int addComment(CommentVO cmtvo) {
		int n = sqlsession.insert("accommodation.addComment", cmtvo);
		return n;
	}

	// 댓글 보여주기
	@Override
	public List<CommentVO> commentVOList(String acc_idx) {
		List<CommentVO> commentList = sqlsession.selectList("accommodation.commentVOList", acc_idx);
		return commentList;
	}

	// 좋아요 싫어요 갯수 구하기
	@Override
	public HashMap<String, Integer> getLikeDislikeCount(String acc_idx) {
		HashMap<String, Integer> likeDislikeMap = sqlsession.selectOne("accommodation.getLikeDislikeCount", acc_idx);
		return likeDislikeMap;
	}
	
	// 태그 테이블 인서트
	@Override
	public int getAccTagListCnt(String acc_idx) {
		int n = sqlsession.insert("accommodation.getAccTagListCnt", acc_idx);
		return n;
	}
	@Override
	public int updateHotelTagCnt(String acc_idx) {
		int m = sqlsession.insert("accommodation.updateHotelTagCnt", acc_idx);
		return m;
	}	
	
	
	
	// 지도 검색 페이지
	@Override
	public List<AccVO> getStoreMap() {
		List<AccVO> storemapList = sqlsession.selectList("accommodation.getStoreMap");
		return storemapList;
	}





}
