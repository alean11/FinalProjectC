package com.spring.wetre.member.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.wetre.common.AES256;
import com.spring.wetre.member.model.InterMemberDAO;
import com.spring.wetre.model.*;


// Service 선언
@Service
public class MemberService implements InterMemberService {
	
	// 의존객체 주입하기(DI)
	@Autowired
	private InterMemberDAO dao;
	
	// 양방향 암호화 알고리즘인 AES256 를 사용하여 암호화/복호화 하기위한 클래스 의존객체 주입하기
	@Autowired
	private AES256 aes;

	
	// 개인회원 로그인 처리하기
	@Override
	public PersonalVO getLoginPrivateMember(HashMap<String, String> map) {
		
		// 로그인 시 마지막 로그인 날짜 오늘로 수정하기(트렌젝션 처리)
		PersonalVO loginuser = dao.getLoginPrivateMember(map);
		
		
		// aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일주소를 복호화해서 보여준다.
		if(loginuser != null) {
			
			if( loginuser.getLastlogindategap() >= 12) {
				// 마지막으로 로그인 한 날짜가 현재일로부터 1년(12개월)이 지났으면 해당 로그인 계정을 비활성화(휴면) 처리한다.
				
				loginuser.setIdleStatus(true);
				
				//// 아래는  로그인 한지 1년이 지났지만 정상적으로 로그인 처리를 해주는 것 ////
				//// 정상적으로 로그인 처리를 허락하지 않으려면 아래부분은 삭제해야 한다.
				
				dao.setLastPrivateMemberLoginDate(map);  // 마지막으로 로그인 한 날짜시간 변경(기록)하기
				
				try {
					loginuser.setP_email(aes.decrypt(loginuser.getP_email())); // 빨간말이 나오면 try/catch를 해주어야 한다.
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} 
				
				///////////////////////////////////////////////////////////////
			}
			else {
				
				if(loginuser.getPwdchangegap() > 3) {
					// 마지막으로 암호를 변경한 날짜가 현재 시각으로부터 3개월이 지났으면 true
					loginuser.setRequirePwdChange(true);
				}
				
				
				dao.setLastPrivateMemberLoginDate(map);  // 마지막으로 로그인 한 날짜시간 변경(기록)하기
							
				try {
					loginuser.setP_email(aes.decrypt(loginuser.getP_email())); // 빨간말이 나오면 try/catch를 해주어야 한다.
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} 
			}
					
		}
		
		return loginuser;
	}

	// 기업회원 로그인 처리하기
	@Override
	public CompanyVO getLoginCompanyMember(HashMap<String, String> map) {
		// 로그인 시 마지막 로그인 날짜 오늘로 수정하기(트렌젝션 처리)
		CompanyVO companyuser = dao.getLoginCompanyMember(map);
			
			
			// aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일주소를 복호화해서 보여준다.
			if(companyuser != null) {
									
				try {
					companyuser.setCp_email(aes.decrypt(companyuser.getCp_email())); // 빨간말이 나오면 try/catch를 해주어야 한다.
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} 
				
				///////////////////////////////////////////////////////////////
			}	
										
			return companyuser;
	}
	
	
	@Override
	public int idCheckEndP(String p_userid) {
		int n = dao.idCheckEndP(p_userid);
		return n;
	}

	
	// 회원가입 (, email 암호화)
	@Override
	public int registerMember(PersonalVO pvo ) {
		String p_pwd = "";
		String email = "";
		try {				
			email = aes.encrypt(pvo.getP_email());
			p_pwd = aes.encrypt(pvo.getP_pwd());
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {			
			e.printStackTrace();
		}
		pvo.setP_pwd(p_pwd);
		pvo.setP_email(email);	
		int n = dao.registerMember(pvo);
		return n;
	}


	@Override
	public int updateMember(PersonalVO pvo) {
		String p_pwd = "";
		try {				
			p_pwd = aes.encrypt(pvo.getP_pwd());
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {			
			e.printStackTrace();
		}
		pvo.setP_pwd(p_pwd);
		int n = dao.updateMember(pvo);
		return n;
	}


	@Override
	public PersonalVO selectPersonalInfo(String p_userid) {
		PersonalVO selectUserInfo = dao.selectPersonalInfo(p_userid);
		try {
			selectUserInfo.setP_email(aes.decrypt(selectUserInfo.getP_email()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		
		return selectUserInfo;
	}

	

	
	
	
	
	////////////////////// 기업회원 & 호텔 등록 ////////////////////////////
	
	@Override
	public int isUseUserid(String cp_id) {
		int n = dao.isUseUserid(cp_id);
		return n;
	}

	
	// 회원가입 (, email 암호화)
	@Override
	public int registerMember(CompanyVO cvo ) {
		String email = "";
		try {				
			email = aes.encrypt(cvo.getCp_email());
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {			
			e.printStackTrace();
		}
		cvo.setCp_email(email);	
		int n = dao.registerMember(cvo);
		return n;
	}

	// 회원수정
	@Override
	public int updateMember(CompanyVO cvo) {
	
		int n = dao.updateMember(cvo);
		return n;
	}


	@Override
	public CompanyVO selectUserInfo(String cp_id) {
		CompanyVO selectUserInfo = dao.selectUserInfo(cp_id);
		try {
			selectUserInfo.setCp_email(aes.decrypt(selectUserInfo.getCp_email()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			
			e.printStackTrace();
		}
		
		
		return selectUserInfo;
	}

	// 호텔등록
	@Override
	public int registerHotel(AccVO avo) {
		
		int n = dao.registerHotel(avo);
		return n;
	}

	
	@Override
	public List<AccVO> getHotelName(String cp_id) {
		List<AccVO> avo = dao.getHotelName(cp_id);
		return avo;
	}
	
	
	@Override
	public AccVO selectHotel(String acc_idx) {
		return dao.selectHotel(acc_idx);
	}
	
	
	
	
	@Override
	public int registerRtype(RtypeVO rtvo) {
		return dao.registerRtype(rtvo);
	}
	
	
	@Override
	public int registerRoom(RoomVO rvo) {
		return dao.registerRoom(rvo);
	}
	
	
	@Override
	public int registerBar(BarmenityVO bvo) {
		return dao.registerBar(bvo);
	}
	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class}) 
	public int registerHotelAll(AccVO avo, AddimgVO advo, List<RoomVO> rvoList, List<RtypeVO> rtvoList, List<BarmenityVO> bavoList) throws Throwable {
		
		int result=0;
		int n = dao.registerHotel(avo);		
		/*int g = dao.insertImg(advo);*/
		
		int s = dao.get_acc_idx(avo);
		avo.setAcc_idx(s);
		for (int i = 0; i < rvoList.size(); i++) {
			rtvoList.get(i).setFK_acc_idx(s);
			int m = dao.registerRtype(rtvoList.get(i));
			String rtype_idx = dao.get_FK_rtype_idx(rtvoList.get(i));
			rvoList.get(i).setFK_rtype_idx(rtype_idx);
			rvoList.get(i).setFK_acc_idx(s);
			int a = dao.registerRoom(rvoList.get(i));
			
			int r_idx = dao.get_r_idx(rvoList.get(i));
			bavoList.get(i).setR_idx(r_idx);
			
			int b = dao.registerBar(bavoList.get(i));
			int r = dao.insertAcc_tag(avo);
			result = n*m*a*b;
		}
		
		
		
		return result;
	}
	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int updateHotelAll(AccVO avo, AddimgVO advo, List<RoomVO> rvoList, List<RtypeVO> rtvoList, List<BarmenityVO> bavoList)  throws Throwable {
		

		if(advo.getAd_img1()==null) {
			advo.setAd_img1("NONE");
		}
		if(advo.getAd_img2()==null) {
			advo.setAd_img2("NONE");
		}
		if(advo.getAd_img3()==null) {
			advo.setAd_img3("NONE");
		}
		if(advo.getAd_img4()==null) {
			advo.setAd_img4("NONE");
		}
		if(advo.getAd_img5()==null) {
			advo.setAd_img5("NONE");
		}
		
		int result = 0;
		int n = dao.updateHotel(avo);
		int g = dao.insertImg(advo);
		for (int i = 0; i < rvoList.size(); i++) {
			rtvoList.get(i).setFK_acc_idx(avo.getAcc_idx());
			int m = dao.updateRtype(rtvoList.get(i));
			String rtype_idx = dao.get_FK_rtype_idx(rtvoList.get(i));
			rvoList.get(i).setFK_rtype_idx(rtype_idx);
			rvoList.get(i).setFK_acc_idx(avo.getAcc_idx());
			
			int r_idx = dao.getR_idx(avo.getAcc_idx());
			rvoList.get(i).setR_idx(r_idx);
			int a = dao.updateRoom(rvoList.get(i));
			bavoList.get(i).setR_idx(r_idx);
			
			
			int b = dao.updateBar(bavoList.get(i));
			int r = dao.updateAcc_tag(avo);
			
			
			result = n*m*a*b;
		}
		
		return n*g;
	}

	
	
	
	
	
	

}
