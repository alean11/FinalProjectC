package com.spring.wetre.member.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.*;


@Repository
public class MemberDAO implements InterMemberDAO {

	
	// 의존객체 주입하기(DI)
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	
	// 개인회원 로그인 처리하기(트랜젝션)
	@Override
	public PersonalVO getLoginPrivateMember(HashMap<String, String> map) {
		PersonalVO loginuser = sqlsession.selectOne("member.getLoginPrivateMember", map);
		return loginuser;
	}
	
	
	@Override
	public void setLastPrivateMemberLoginDate(HashMap<String, String> map) {
		sqlsession.update("member.setLastPrivateMemberLoginDate", map);		
	}
	
	
	// 기업회원 로그인 처리하기
	@Override
	public CompanyVO getLoginCompanyMember(HashMap<String, String> map) {
		CompanyVO loginuser = sqlsession.selectOne("member.getLoginCompanyMember", map);
		return loginuser;
	}
	
	@Override
	public int idCheckEndP(String p_userid) {
		int n = sqlsession.selectOne("member.idCheckEndP",p_userid);
		return n;
	}

	@Override
	public int registerMember(PersonalVO pvo) {	
		int n = sqlsession.insert("member.registerMemberP",pvo);
		return n;
	}

	@Override
	public int updateMember(PersonalVO pvo) {
		int n = sqlsession.update("member.updateMemberP",pvo);
		return n;
	}

	@Override
	public PersonalVO selectPersonalInfo(String p_userid) {
		PersonalVO selectUserInfo =  sqlsession.selectOne("member.selectPersonalInfo",p_userid);
		return selectUserInfo;
	}
	
	
	
	
	
	/////////////////// 기업회원 & 호텔 등록 ///////////////////////
	@Override
	public int isUseUserid(String cp_id) {
		int n = sqlsession.selectOne("member.isUseUserid",cp_id);
		return n;
	}

	@Override
	public int registerMember(CompanyVO cvo) {	
		int n = sqlsession.insert("member.registerMember",cvo);
		return n;
	}

	// 회원정보 수정
	@Override
	public int updateMember(CompanyVO cvo) {
		int n = sqlsession.update("member.updateMember",cvo);
		return n;
	}

	@Override
	public CompanyVO selectUserInfo(String cp_id) {
		CompanyVO selectUserInfo =  sqlsession.selectOne("member.selectUserInfo",cp_id);
		return selectUserInfo;
	}

	// 호텔등록	
	@Override
	public int registerHotel(AccVO avo) {
		int n = sqlsession.insert("member.registerHotel",avo);
		return n;
	}

	@Override
	public List<AccVO> getHotelName(String cp_id) {
		List<AccVO> avo = sqlsession.selectList("member.getHotelName",cp_id);
		return avo;
	}

	@Override
	public AccVO selectHotel(String acc_idx) {
		return sqlsession.selectOne("member.selectHotel",acc_idx);
	}

	// 호텔수정
	@Override
	public int updateHotel(AccVO avo) {
		int n = sqlsession.update("member.updateHotel",avo);
		return n;
	}

	// 방종류 , 객실 수 , 브라메니티 
	@Override
	public int registerRtype(RtypeVO rtvo) {
		return sqlsession.insert("member.registerRtype",rtvo);
	}

	@Override
	public int registerRoom(RoomVO rvo) {
		return sqlsession.insert("member.registerRoom",rvo);
	}

	@Override
	public int registerBar(BarmenityVO bvo) {
		return sqlsession.insert("member.registerBar",bvo);
	}

	@Override
	public int get_r_idx(RoomVO rvo) {
		return sqlsession.selectOne("member.get_r_idx",rvo);
	}

	@Override
	public String get_FK_rtype_idx(RtypeVO rtypeVO) {
		return sqlsession.selectOne("member.get_FK_rtype_idx",rtypeVO);
	}

	@Override
	public int get_acc_idx(AccVO avo) {
		return sqlsession.selectOne("member.get_acc_idx",avo);
	}

	@Override
	public int updateRtype(RtypeVO rtypeVO) {
		return sqlsession.update("member.updateRtype",rtypeVO);
	}

	@Override
	public int updateRoom(RoomVO roomVO) {
		return sqlsession.update("member.updateRoom",roomVO);
	}

	@Override
	public int updateBar(BarmenityVO barmenityVO) {
		return sqlsession.update("member.updateBar",barmenityVO);
	}

	@Override
	public int getR_idx(int acc_idx) {
		return sqlsession.selectOne("member.getR_idx",acc_idx);
	}

	@Override
	public int insertAcc_tag(AccVO avo) {
		return sqlsession.insert("member.insertAcc_tag",avo);
	}

	@Override
	public int updateAcc_tag(AccVO avo) {
		return sqlsession.insert("member.updateAcc_tag",avo);
	}


	@Override
	public int insertImg(AddimgVO advo) {
		return sqlsession.insert("member.insertImg",advo) ;
	}
	
	
	
}
