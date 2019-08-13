package com.spring.wetre.member.service;

import java.util.*;
import com.spring.wetre.model.*;

public interface InterMemberService {

	// 개인회원 로그인 처리하기
	PersonalVO getLoginPrivateMember(HashMap<String, String> map);

	// 기업회원 로그인 처리하기
	CompanyVO getLoginCompanyMember(HashMap<String, String> map);

	// 개인회원 아이디 체크
	int idCheckEndP(String p_userid);

	int registerMember(PersonalVO pvo); // 개인회원가입

	int updateMember(PersonalVO pvo); // 개인정보수정

	PersonalVO selectPersonalInfo(String p_userid); // 유저정보 조회

	
	
	// 기업회원 & 호텔 등록
	int isUseUserid(String cp_id);

	int registerMember(CompanyVO cvo); // 기업회원가입

	int updateMember(CompanyVO cvo); // 기업회원 정보수정

	CompanyVO selectUserInfo(String cp_id); // 유저정보 조회

	int registerHotel(AccVO avo); // 호텔등록

	List<AccVO> getHotelName(String cp_id);

	AccVO selectHotel(String acc_idx);

	int registerRtype(RtypeVO rtvo);

	int registerRoom(RoomVO rvo);

	int registerBar(BarmenityVO bvo);

	int registerHotelAll(AccVO avo, AddimgVO advo, List<RoomVO> rvoList, List<RtypeVO> rtvoList, List<BarmenityVO> bavoList) throws Throwable;

	int updateHotelAll(AccVO avo, AddimgVO advo, List<RoomVO> rvoList, List<RtypeVO> rtvoList, List<BarmenityVO> bavoList) throws Throwable;

	

	

	
	

}
