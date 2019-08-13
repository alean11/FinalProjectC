package com.spring.wetre.member.model;

import java.util.*;

import com.spring.wetre.model.*;

public interface InterMemberDAO {

	// 개인회원 로그인 처리하기
	PersonalVO getLoginPrivateMember(HashMap<String, String> map);

	// 마지막으로 로그인 한 날짜시간 변경(기록)하기
	 void setLastPrivateMemberLoginDate(HashMap<String, String> map);

	// 기업회원 로그인 처리하기
	CompanyVO getLoginCompanyMember(HashMap<String, String> map);
	
	int idCheckEndP(String p_userid);

	int registerMember(PersonalVO pvo); // 개인회원가입

	int updateMember(PersonalVO pvo); // 개인정보수정

	PersonalVO selectPersonalInfo(String p_userid); // 유저정보 조회
	
	
	
	
	/////////////////// 기업회원 & 호텔 등록 ///////////////////////
	int isUseUserid(String cp_id);

	int registerMember(CompanyVO cvo); // 기업회원가입

	int updateMember(CompanyVO cvo); // 기업회원 정보수정

	CompanyVO selectUserInfo(String cp_id);
	
	int registerHotel(AccVO avo); // 호텔등록

	List<AccVO> getHotelName(String cp_id);

	AccVO selectHotel(String acc_idx);

	int registerRtype(RtypeVO rtvo);

	int registerRoom(RoomVO rvo);

	int registerBar(BarmenityVO bvo);

	int get_r_idx(RoomVO rvo);

	String get_FK_rtype_idx(RtypeVO rtypeVO);

	int get_acc_idx(AccVO avo);

	int updateHotel(AccVO avo); // 호텔 업데이트

	int updateRtype(RtypeVO rtypeVO);

	int updateRoom(RoomVO roomVO);

	int updateBar(BarmenityVO barmenityVO);

	int getR_idx(int acc_idx);
	
	int insertAcc_tag(AccVO avo);

	int updateAcc_tag(AccVO avo);

	int insertImg(AddimgVO advo);	
	
	 
}
