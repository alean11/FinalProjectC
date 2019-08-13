package com.spring.wetre.member;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wetre.common.*;
import com.spring.wetre.member.service.InterMemberService;
import com.spring.wetre.model.*;


// Controller 선언
@Component
@Controller
public class MemberController {
	
	
	
	// 의존객체 주입하기(DI)
	@Autowired 	// Type에 따라 알아서 bean을 주입해준다.
	private InterMemberService service;
		
			
	
    /////////////////////////////  개인회원 시작   ///////////////////////////////////
	
	
	// 개인회원 로그인 폼 페이지 요청
	@RequestMapping(value="/privateLogin.we", method= {RequestMethod.GET})
	public ModelAndView privateLogin(ModelAndView mv) {
				
		mv.setViewName("login/privateloginform");
		return mv;
	}
	
	
	// 개인회원 로그인 처리 하기
	@RequestMapping(value="/privateLoginEnd.we", method= {RequestMethod.POST})
	public ModelAndView privateLoginEnd(HttpServletRequest request, ModelAndView mv, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("password");
		String saveid = request.getParameter("saveid");
				
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", SHA256.encrypt(pwd)); // pwd를 암호화시켜야 한다.
		
		PersonalVO loginuser = service.getLoginPrivateMember(map);
				
		HttpSession session = request.getSession();
		
		if(loginuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			
			mv.setViewName("msg");
			// /FinalProjectC/src/main/webapp/WEB-INF/views/msg.jsp
		}
		else {
			
			if(loginuser.isIdleStatus() == true) { // 리턴 타입이 boolean 이면 VO 가면 이름이 is~ 라고 나온다.
				// 로그인 한지 1년이 지나서 휴면상태로 빠진 경우
				String msg = "로그인 한지 1년이 지나서 휴면처리 되었습니다. 관리자에게 문의 바랍니다.";
			}
			else {
				if(loginuser.isRequirePwdChange() == true) {
					// 암호를 최근 3개월 동안 변경하지 않은 경우
					String msg = "암호를 최근 3개월 동안 변경하지 않으셨습니다. 암호를 변경해주세요.";
					// String loc = "board/login/myinfo";
					String loc = request.getContextPath()+"/privateLogin.we";
					
					mv.addObject("msg", msg);
					mv.addObject("loc", loc);
					
					mv.setViewName("msg");
					
					session.setAttribute("loginuser", loginuser); // 위에 하든 아래에 하든 상관없다.
				}
				else {
					// 아무런 이상없이 로그인 하는 경우
					session.setAttribute("loginuser", loginuser);
					
					Cookie cookie = new Cookie("saveid", loginuser.getP_userid());
					
					if("on".equals(saveid)) {
						// 체크박스에 체크를 했을 경우
						cookie.setMaxAge(7*24*60*60);
					}
					else {
						// 체크박스에 체크를 해제했을 경우
						cookie.setMaxAge(0);
						// 쿠키의 생존기간을 0초로 설정한다. 즉, 이것이 쿠키삭제이다.
					}
					
					cookie.setPath("/");
					
					response.addCookie(cookie);
					
					if(session.getAttribute("gobackURL") != null) {
						// 세션에 저장된 돌아갈 페이지의 주소 (gobackURL)이 있다라면 
						
						String gobackURL = (String) session.getAttribute("gobackURL");
						mv.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
						
						session.removeAttribute("gobackURL"); // 세션에서 gobackURL을 삭제한다.						
					}
				
					
					mv.setViewName("login/privateloginEnd.tiles1");
					// /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/login/privateloginEnd.jsp
				}
			}
			
		}
		
		return mv;
	}
	
		
	// 개인회원 로그아웃 처리하기
	@RequestMapping(value="/privateLogout.we", method= {RequestMethod.GET})
	public ModelAndView privateLogout(HttpServletRequest request, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String msg = "로그아웃 하였습니다.";
		String loc = request.getContextPath()+"/accommodation/accList.we";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		
		mv.setViewName("msg"); 
		
		return mv;
	}
	
	
	
	/// 개인회원 회원가입 처리
	/// #36. 메인페이지 요청 ///
	@RequestMapping(value = "/personalRegister.we", method = { RequestMethod.GET })
	public ModelAndView personal(ModelAndView mv) {

		mv.setViewName("personal/personal.tiles1");
		// 위치: /FinalProjectC/src/main/webapp/WEB-INF/views/main/index.jsp

		return mv;
		
	} // end of 메인페이지 요청 ------

	
	/// ID 중복체크
	@RequestMapping(value = "/idCheckP.we", method = { RequestMethod.GET })
	public ModelAndView idCheckP(ModelAndView mv) {

		mv.setViewName("idcheckP.notiles");
		return mv;
	}

	@RequestMapping(value = "/idCheckEndP.we", method = { RequestMethod.POST })
	public ModelAndView idCheckEndP(HttpServletRequest request, ModelAndView mv) {

		String p_userid = request.getParameter("p_userid");
		int n = service.idCheckEndP(p_userid);

		mv.addObject("p_userid", p_userid);
		mv.addObject("isUseUserid", n);
		mv.setViewName("idcheckEndP.notiles");

		return mv;
	}

	
	// 회원가입 성공/실패
	@RequestMapping(value = "/joinInsertP.we", method = { RequestMethod.POST })
	public ModelAndView joinInsert(HttpServletRequest request, ModelAndView mv, PersonalVO pvo) {

		pvo.setP_pwd(SHA256.encrypt(pvo.getP_pwd()));

		int n = service.registerMember(pvo);
		String msg = "";
		String loc = "";
		if (n == 1) {
			msg = "회원가입에 성공했습니다.";
			loc = request.getContextPath() + "/accommodation/accList.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		} else {
			msg = "회원가입 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("msg");
		return mv;

	}

	
	// 회원 정보 수정
	@RequestMapping(value = "/personalEdit.we", method = { RequestMethod.GET })
	public ModelAndView requirePrivateLogin_personalmp(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {

		HttpSession session = request.getSession();
		PersonalVO personaluser = (PersonalVO) session.getAttribute("loginuser");
		String p_userid = personaluser.getP_userid();		
		PersonalVO selectUserInfo = service.selectPersonalInfo(p_userid);		

		mv.addObject("pvo", selectUserInfo);
		mv.setViewName("personal/personalEdit.tiles1");

		return mv;
	}

	
	
	
	
	
	
    /////////////////////////////  기업회원 시작   ///////////////////////////////////
	
	// 기업회원 로그인 폼 페이지 요청
	@RequestMapping(value="/companyLogin.we", method= {RequestMethod.GET})
	public ModelAndView companyLogin(ModelAndView mv) {
				
		mv.setViewName("login/companyloginform");
		return mv;
	} 
	
	
	// 기업회원 로그인 처리 하기
	@RequestMapping(value="/companyLoginEnd.we", method= {RequestMethod.POST})
	public ModelAndView companyLoginEnd(HttpServletRequest request, ModelAndView mv, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("password");
		String saveid = request.getParameter("saveid");
				
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", SHA256.encrypt(pwd)); // pwd를 암호화시켜야 한다.
		
		CompanyVO companyuser = service.getLoginCompanyMember(map);
		/////////////////////////////////////////////////////////////
				
		HttpSession session = request.getSession();
		
		if(companyuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			
			mv.setViewName("msg");
			// /FinalProjectC/src/main/webapp/WEB-INF/views/msg.jsp
		}
				
		else {
			
			// 아무런 이상없이 로그인 하는 경우
			session.setAttribute("companyuser", companyuser);
			
			Cookie cookie = new Cookie("saveid", companyuser.getCp_id());
			
			if("on".equals(saveid)) {
				// 체크박스에 체크를 했을 경우
				cookie.setMaxAge(7*24*60*60);
			}
			else {
				// 체크박스에 체크를 해제했을 경우
				cookie.setMaxAge(0);
				// 쿠키의 생존기간을 0초로 설정한다. 즉, 이것이 쿠키삭제이다.
			}
			
			cookie.setPath("/");
			
			response.addCookie(cookie);
						
			if(session.getAttribute("gobackURL") != null) {
				// 세션에 저장된 돌아갈 페이지의 주소 (gobackURL)이 있다라면 
				
				String gobackURL = (String) session.getAttribute("gobackURL");
				mv.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
				
				session.removeAttribute("gobackURL"); // 세션에서 gobackURL을 삭제한다.						
			}
				
					
			mv.setViewName("login/companyloginEnd.tiles1");
			// /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/login/companyloginEnd.jsp
								
		}
		
		return mv;
	}
	
	// 기업회원 로그아웃 처리하기
	@RequestMapping(value="/companyLogout.we", method= {RequestMethod.GET})
	public ModelAndView companyLogout(HttpServletRequest request, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String msg = "로그아웃 하였습니다.";
		String loc = request.getContextPath()+"/accommodation/accList.we";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		
		mv.setViewName("msg"); 
		
		return mv;
	}
	

	
	// 기업회원정보 수정 성공/실패
	@RequestMapping(value = "/mpjoinInsertP.we", method = { RequestMethod.POST })
	public ModelAndView mpjoinInsert(HttpServletRequest request, ModelAndView mv, PersonalVO pvo) {

		int n = service.updateMember(pvo);
		
		
		String msg = "";
		String loc = "";
		if (n == 0) {
			msg = "정보수정에 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		} else {
			msg = "정보수정에 성공했습니다.";
			loc = request.getContextPath() + "/accommodation/accList.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("msg");
		return mv;

	}
	
	
	
	//기업회원 정보 수정 & 호텔 등록
	
	// === #137. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) ===  
	@Autowired
	private FileManager fileManager;
	
	/// #36. 메인페이지 요청 ///
	// 기원회원가입
	@RequestMapping(value="/company.we", method= {RequestMethod.GET})
	public ModelAndView company(ModelAndView mv) {
		
		mv.setViewName("company/company.tiles1");
		return mv;
		// 위치는 여기: /FinalProjectC/src/main/webapp/WEB-INF/views/main/index.jsp
		// header랑 footer는 따로 있고, 이 index 파일은 content로 들어가는 것임.
	} // end of 메인페이지 요청 ------
	
	/// ID 중복체크
	@RequestMapping(value="/idCheck.we", method= {RequestMethod.GET})
	public ModelAndView idCheck(ModelAndView mv) {
		mv.setViewName("idcheck.notiles");
		return mv;
	}

	@RequestMapping(value="/idCheckEnd.we", method= {RequestMethod.GET})
	@ResponseBody
	public boolean idCheckB(HttpServletRequest request,  ModelAndView mv) {
		boolean bool = false;
		String cp_id = request.getParameter("cp_id");
		int n = service.isUseUserid(cp_id);
		if(n == 0) {
			bool = true;
		}
		
		return bool;
	}

	
	
	// 기업회원가입 성공/실패
	@RequestMapping(value="/joinInsert.we", method= {RequestMethod.POST})
	public ModelAndView joinInsert(HttpServletRequest request,  ModelAndView mv , CompanyVO cvo) {

		
		cvo.setCp_pwd(SHA256.encrypt(cvo.getCp_pwd()));
		
		int n = service.registerMember(cvo);
		String msg = "";
		String loc = "";
		if(n ==1) {
			msg = "회원가입에 성공했습니다.";
			loc = request.getContextPath()+"/index.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		}
		else {
			msg = "회원가입 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		
		
		mv.setViewName("msg");
		return mv;
	}
	
	
	// 기업회원 정보 수정
	@RequestMapping(value="/companymp.we", method= {RequestMethod.GET})
	public ModelAndView companymp(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		CompanyVO companyuser  = (CompanyVO) session.getAttribute("companyuser");
		
		String cp_id  = companyuser.getCp_id();
		
		CompanyVO selectUserInfo =  service.selectUserInfo(cp_id);
		
		mv.addObject("cvo",selectUserInfo);
		
		mv.setViewName("company/companymp.tiles1");
		
		return mv;		
	}
	
	
	
	// 기업회원정보 수정 성공/실패
	@RequestMapping(value="/mpjoinInsert.we", method= {RequestMethod.POST})
	public ModelAndView mpjoinInsert(HttpServletRequest request,  ModelAndView mv , CompanyVO cvo) {

		int n = service.updateMember(cvo);
		String msg = "";
		String loc = "";
		if(n ==1) {
			msg = "정보수정에 성공했습니다.";
			loc = request.getContextPath()+"/index.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		}
		else {
			msg = "정보수정에 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}
	
	
	// 호텔등록
	@RequestMapping(value="/hrregister.we", method= {RequestMethod.GET})
	public ModelAndView hrRegister(ModelAndView mv, HttpServletRequest request) {
		
		mv.setViewName("company/hrRegister.tiles1");
		return mv;
	} // end of 메인페이지 요청 ------
	
		
	// 호텔등록 성공/실패
	@RequestMapping(value="/hrInsert.we", method= {RequestMethod.POST})
	public ModelAndView hrInsert(ModelAndView mv, AccVO avo, AddimgVO advo, MultipartHttpServletRequest mrequest) {
		
			MultipartFile attach = avo.getAttach();
			/*MultipartFile attach1 = advo.getAttach1();
			MultipartFile attach2 = advo.getAttach2();
			MultipartFile attach3 = advo.getAttach3();
			MultipartFile attach4 = advo.getAttach4();
			MultipartFile attach5 = advo.getAttach5();*/
			
			//  WAS의 webapp 의 절대경로를 알아와야 한다.
		 	HttpSession session = mrequest.getSession();
		 	String root = session.getServletContext().getRealPath("/");
		 	String path = root + "resources" + File.separator + "files";
		 	
		 // == 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일올리기 ==
		 	String newFileName = "";
		 	// WAS(톰캣)의 디스크에 저장될 파일명
		 	
		 	byte[] bytes = null;
		 	// 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		 	
		 	try {
				bytes = attach.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				avo.setAcc_img(newFileName);
				/*bytes = attach1.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach1.getOriginalFilename(), path);
				advo.setAd_img1(newFileName);
				bytes = attach2.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach2.getOriginalFilename(), path);
				advo.setAd_img2(newFileName);
				bytes = attach3.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach3.getOriginalFilename(), path);
				advo.setAd_img3(newFileName);
				bytes = attach4.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach4.getOriginalFilename(), path);
				advo.setAd_img4(newFileName);
				bytes = attach5.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach5.getOriginalFilename(), path);
				advo.setAd_img5(newFileName);*/
				
			} catch (Exception e) {
				e.printStackTrace();
			}

			int fK_acc_idx = avo.getAcc_idx();
			int rtypeCount = Integer.parseInt(mrequest.getParameter("rtypeCount"));
			
			List<RoomVO> rvoList = new ArrayList<RoomVO>();
			List<RtypeVO> rtvoList = new ArrayList<RtypeVO>();
			List<BarmenityVO> bavoList = new ArrayList<BarmenityVO>();
			
			for (int i = 0; i < rtypeCount; i++) {
				String rtype_Name = mrequest.getParameter("rtype_Name"+i);
				int rtype_cnt = Integer.parseInt(mrequest.getParameter("rtype_cnt"+i));
				String r_text = mrequest.getParameter("r_text"+i);
				int ay_fee = Integer.parseInt(mrequest.getParameter("ay_fee"+i));
				int k_fee = Integer.parseInt(mrequest.getParameter("k_fee"+i));
				String bm_br_addfee = mrequest.getParameter("bm_br_addfee"+i);
				String bm_amenity = mrequest.getParameter("bm_amenity"+i);
				String bm_device = mrequest.getParameter("bm_device"+i);
				RtypeVO rtvo = new RtypeVO(fK_acc_idx, rtype_Name, rtype_cnt);
				rtvoList.add(rtvo);
				RoomVO rvo = new RoomVO(fK_acc_idx, r_text, ay_fee, k_fee);
				rvoList.add(rvo);
				BarmenityVO bavo = new BarmenityVO(bm_br_addfee, bm_amenity, bm_device);
				bavoList.add(bavo);
				String rtext = rvo.getR_text();
				rtext = rtext.replaceAll("\r\n", "<br/>");
				
				rvo.setR_text(rtext);
				
			}
						 	
			String text = avo.getAcc_text();
		 	text = text.replaceAll("\r\n", "<br/>");
		 	
		 	avo.setAcc_text(text);
			
		 	
		 int n = 0;
		try {
			n = service.registerHotelAll(avo, advo, rvoList, rtvoList, bavoList);
		} catch (Throwable e) {

			e.printStackTrace();
		}
		
		
		String msg = "";
		String loc = "";
		if(n ==1) {
			msg = "호텔등록에 성공했습니다.";
			loc = mrequest.getContextPath()+"/index.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		}
		else {
			msg = "호텔등록 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		
		
		mv.setViewName("msg");
		return mv;
	}
	
		

	// 호텔정보 수정	
	@RequestMapping(value="/hrmp.we", method= {RequestMethod.GET})
	public ModelAndView hrmp(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		
		String acc_idx = request.getParameter("acc_idx");
		HttpSession session = request.getSession();
		CompanyVO companyuser  = (CompanyVO) session.getAttribute("companyuser");
		
		String cp_id  = companyuser.getCp_id();
		
		List<AccVO> avoList = service.getHotelName(cp_id);
		
		if(acc_idx==null) {
			mv.addObject("avo", avoList.get(0));
		}
		else {
			AccVO avo =  service.selectHotel(acc_idx);
			mv.addObject("avo", avo);
		}
		
		mv.addObject("avoList", avoList);
		mv.setViewName("company/hrmp.tiles1");
		
		return mv;		
	}
		
				
		
	// 호텔정보 수정 성공/실패
	@RequestMapping(value="/hrmpjoinInsert.we", method= {RequestMethod.POST})
	public ModelAndView hrmpjoinInsert(ModelAndView mv , AccVO avo, AddimgVO advo, BarmenityVO bvo, RtypeVO rtvo, RoomVO rvo, MultipartHttpServletRequest mrequest) {

	 System.out.println(advo.getAcc_idx());	
		
			MultipartFile attach = avo.getAttach();
			MultipartFile attach1 = advo.getAttach1();
			MultipartFile attach2 = advo.getAttach2();
			MultipartFile attach3 = advo.getAttach3();
			MultipartFile attach4 = advo.getAttach4();
			MultipartFile attach5 = advo.getAttach5();
			
			
			
			//  WAS의 webapp 의 절대경로를 알아와야 한다.
		 	HttpSession session = mrequest.getSession();
		 	String root = session.getServletContext().getRealPath("/");
		 	String path = root + "resources" + File.separator + "img/hotel_img";
		 	
		 // == 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일올리기 ==
		 	String newFileName = "";
		 	// WAS(톰캣)의 디스크에 저장될 파일명
		 	
		 	byte[] bytes = null;
		 	// 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		 	
		 	
		 	try {
				bytes = attach.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				avo.setAcc_img(newFileName);
				bytes = attach1.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach1.getOriginalFilename(), path);
				advo.setAd_img1(newFileName);
				bytes = attach2.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach2.getOriginalFilename(), path);
				advo.setAd_img2(newFileName);
				bytes = attach3.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach3.getOriginalFilename(), path);
				advo.setAd_img3(newFileName);
				bytes = attach4.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach4.getOriginalFilename(), path);
				advo.setAd_img4(newFileName);
				bytes = attach5.getBytes();
				newFileName = fileManager.doFileUpload(bytes, attach5.getOriginalFilename(), path);
				advo.setAd_img5(newFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			int fK_acc_idx = avo.getAcc_idx();
			int rtypeCount = Integer.parseInt(mrequest.getParameter("rtypeCount"));
			
			List<RoomVO> rvoList = new ArrayList<RoomVO>();
			List<RtypeVO> rtvoList = new ArrayList<RtypeVO>();
			List<BarmenityVO> bavoList = new ArrayList<BarmenityVO>();
			
			for (int i = 0; i < rtypeCount; i++) {
				
				String rtype_Name = mrequest.getParameter("rtype_Name"+i);
				int rtype_cnt = Integer.parseInt(mrequest.getParameter("rtype_cnt"+i));
				String r_text = mrequest.getParameter("r_text"+i);
				int ay_fee = Integer.parseInt(mrequest.getParameter("ay_fee"+i));
				int k_fee = Integer.parseInt(mrequest.getParameter("k_fee"+i));
				String bm_br_addfee = mrequest.getParameter("bm_br_addfee"+i);
				String bm_amenity = mrequest.getParameter("bm_amenity"+i);
				String bm_device = mrequest.getParameter("bm_device"+i);
				rtvo = new RtypeVO(fK_acc_idx, rtype_Name, rtype_cnt);
				rtvoList.add(rtvo);
				rvo = new RoomVO(fK_acc_idx, r_text, ay_fee, k_fee);
				rvoList.add(rvo);
				BarmenityVO bavo = new BarmenityVO(bm_br_addfee, bm_amenity, bm_device);
				bavoList.add(bavo);
				
				String rtext = rvo.getR_text();
				rtext = rtext.replaceAll("\r\n", "<br/>");
				
				rvo.setR_text(rtext);
			}
			
		 	
			String text = avo.getAcc_text();
		 	text = text.replaceAll("\r\n", "<br/>");
		 	
		 	avo.setAcc_text(text);
			
		int n = 0;
		try {
			n = service.updateHotelAll(avo, advo, rvoList, rtvoList, bavoList);
			/*n = service.updateHotelAll(avo, rvoList, rtvoList, bavoList);*/
		} catch (Throwable e) {

			e.printStackTrace();
		}				 	
		
		String msg = "";
		String loc = "";
		if(n ==1) {
			msg = "정보수정에 성공했습니다.";
			loc = mrequest.getContextPath()+"/index.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		}
		else {
			msg = "정보수정에 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}

	
	
	
	
	
}
