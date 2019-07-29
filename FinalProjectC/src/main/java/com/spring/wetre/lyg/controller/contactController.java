package com.spring.wetre.lyg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.activation.CommandMap;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
/*
import com.google.code.geocoder.*;
import com.google.code.geocoder.model.*;*/
import com.spring.wetre.lyg.service.InterContactService;
import com.spring.wetre.model.AccVO;

/// #30. 컨트롤러 선언 ///
@Component
/* - XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   - 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
*/
@Controller
public class contactController {
	@Autowired
	private InterContactService service;

	
	// 지도페이지
	@RequestMapping(value="/contact.we", method= {RequestMethod.GET})
	public ModelAndView contact(ModelAndView mv) {
		/*List<AccVO> storemapList = service.getStoreMap();
		mv.addObject("storemapList", storemapList);*/
		/*String address = "서울";
		geoCodeController geo = new geoCodeController();
		float[] geoArr = geo.getAddress(address);
		
		System.out.println("geo1 : " + geoArr[0]);
		System.out.println("geo2 : " + geoArr[1]);*/
		mv.setViewName("wetre/contact.tiles1");
		
		return mv;
	}
	// 예약페이지
	@RequestMapping(value="/map.we", method= {RequestMethod.GET})
	public ModelAndView map(HttpServletRequest request, ModelAndView mv) {
		List<AccVO> storemapList = service.getStoreMap();
		for (AccVO accVO : storemapList) {
			System.out.println(accVO.getAcc_addr1());
		}
		System.out.println(storemapList.size());
		mv.addObject("storemapList", storemapList);
		mv.setViewName("map2");
		
		return mv;
		
	}
	@RequestMapping(value="/gmail.we", method= {RequestMethod.POST})
	public void gmail(HttpServletRequest request, ModelAndView mv) {
		String email = request.getParameter("email");
		int n = 0;
		GoogleMail mail = new GoogleMail();
		
		// 인증키를 랜덤하게 생성하도록 한다. 
		Random rnd = new Random();
		
		String certificationCode = "";
		// certificationCode ==> "sfwte0983154"
		
		char randchar = ' ';
		for(int i=0; i<5; i++) {
		/*
		   min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
		   int rndnum = rnd.nextInt(max - min + 1) + min;
		      영문 소문자 'a' 부터 'z' 까지 중 랜덤하게 1개를 만든다.	  
		*/
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			certificationCode += randchar;
		}
		
		int randnum = 0;
		for(int i=0; i<7; i++) {
			randnum = rnd.nextInt(9-0+1)+0;
			certificationCode += randnum;
		}
		
		// 랜덤하게 생성한 인증코드를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
		HttpSession session = request.getSession();
		try {
			email="djfzms02@naver.com";
			mail.sendmail(email, certificationCode);
			
			session.setAttribute("certificationCode", certificationCode);
			// 자바에서 발급한 인증코드를 세션에 저장
			
			request.setAttribute("email", email);
		} catch(Exception e) {
			e.printStackTrace();
			
			n = -1; 
			request.setAttribute("sendMailFailMsg", "메일 발송이 실패했습니다.");
		}
		String msg = "인증번호가 발송되었습니다.";
		String loc = "javascript:history.back()";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		
		mv.setViewName("msg");
	}
	
		@RequestMapping(value="/reserve.we", method= {RequestMethod.GET})
		public ModelAndView reserve(HttpServletRequest request, ModelAndView mv) {
		//String r_idx = request.getParameter("r_idx");
		//List<RoomVO> roList = service.roomedetail(r_idx);
		//mv.addObject("roList", roList);

			mv.addObject("emailOK", false);
		mv.setViewName("wetre/reserve.tiles1");
		
		return mv;
	}
	
		@RequestMapping(value="/email.we", method= {RequestMethod.GET})
		public ModelAndView email(ModelAndView mv, HttpServletRequest request) throws Exception{
				
			mv.setViewName("email.notiles");
			return mv;
		}
		@RequestMapping(value="/emailFrm.we", method= {RequestMethod.GET})
		public ModelAndView emailFrm(ModelAndView mv, HttpServletRequest request) throws Exception{
			String userid = request.getParameter("userid");
			userid="admin";
			String email = request.getParameter("email");
			email="C/P74ewdLIh2ZJh1XD/vexaP+UsG9zKVXye7TBpMsQ8=";
			HashMap<String, String> paramap = new HashMap<String, String>();
			paramap.put("userid", userid);
			paramap.put("email", email);
			System.out.println(email);
			System.out.println("확인용~~if밖");
			boolean isUserExists = service.isUserExists(paramap);

			System.out.println("확인용~~sql후");
			
			
			int n = 0;
			if(isUserExists) {
				System.out.println("확인용~~if안");
				// 회원으로 존재하는 경우 
				n = 1;
				
				GoogleMail mail = new GoogleMail();
				
				// 인증키를 랜덤하게 생성하도록 한다. 
				Random rnd = new Random();
				
				String certificationCode = "";
				// certificationCode ==> "sfwte0983154"
				
				char randchar = ' ';
				for(int i=0; i<5; i++) {
				/*
				   min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
				   int rndnum = rnd.nextInt(max - min + 1) + min;
				      영문 소문자 'a' 부터 'z' 까지 중 랜덤하게 1개를 만든다.	  
				*/
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certificationCode += randchar;
				}
				
				int randnum = 0;
				for(int i=0; i<7; i++) {
					randnum = rnd.nextInt(9-0+1)+0;
					certificationCode += randnum;
				}
				
				// 랜덤하게 생성한 인증코드를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
				HttpSession session = request.getSession();
				try {
					email="djfzms02@naver.com";
					mail.sendmail(email, certificationCode);
					
					session.setAttribute("certificationCode", certificationCode);
					// 자바에서 발급한 인증코드를 세션에 저장
					
					request.setAttribute("email", email);
					
				} catch(Exception e) {
					e.printStackTrace();
					
					n = -1; 
					request.setAttribute("sendMailFailMsg", "메일 발송이 실패했습니다.");
				}
			
			}//end of if------------------
			
			else {
				// 회원으로 존재하지 않는 경우
				n = 0;
			}// end of else------------------ 
			
			request.setAttribute("userid", userid);
			request.setAttribute("email", email);
			request.setAttribute("n", n);
			mv.setViewName("emailFrm.notiles");
			return mv;
		}
		@RequestMapping(value="/verifyCertification.we", method= {RequestMethod.POST})
		public ModelAndView verifyCertification(ModelAndView mv, HttpServletRequest request) throws Exception{
			String userCertificationCode = request.getParameter("userCertificationCode"); 
			
			HttpSession session = request.getSession();
			String certificationCode = (String) session.getAttribute("certificationCode");
			
			String msg = "";
			String loc = "";
			
			if(certificationCode.equals(userCertificationCode)) {
				msg = "인증성공 되었습니다.";
				loc=request.getContextPath()+"/emailEnd.we";
				
				request.setAttribute("s", 1);
				System.out.println("확인용 if");
			}
			else {
				msg = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
				loc = request.getContextPath()+"/email.we";
				System.out.println("else 확인용");
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			// !!! 중요 !!! //
			// 세션에 저장된 인증코드 삭제하기!!!!
			session.removeAttribute("certificationCode");
			System.out.println(loc);
			mv.setViewName("msg.notiles");
			return mv;
			
		}
		
		@RequestMapping(value="/emailEnd.we", method= {RequestMethod.GET})
		public ModelAndView emailEnd(ModelAndView mv, HttpServletRequest request) throws Exception{
			mv.addObject("emailOK", true);
			mv.setViewName("emailEnd.notiles");
			return mv;
		}
		
	@RequestMapping(value="/reserveEnd.we", method= {RequestMethod.POST})
	public ModelAndView ModelAndView(ModelAndView mv, HttpServletRequest request) throws Exception{
		String tel = request.getParameter("tel");
		
		mv.setViewName("wetre/reserveEnd.tiles1");
		return mv;
	}
	
	@RequestMapping(value="/jusoPopup.we", method= {RequestMethod.GET})
	public ModelAndView jusoPopup(ModelAndView mv) {
		
		mv.setViewName("wetre/map/jusoPopup.tiles1");
		
		return mv;
	}
	
	@RequestMapping(value="/naver.we", method= {RequestMethod.GET})
	public ModelAndView naver(ModelAndView mv) {
		
		mv.setViewName("wetre/reserve2.tiles1");
		
		return mv;
	}

	
	@RequestMapping(value="/latLan.we", method= {RequestMethod.GET})
	public ModelAndView latLan(HttpServletRequest request, ModelAndView mv) throws Exception{

		 int n = service.hoteltag("as");
		request.setAttribute("loc", "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&sensor=false&address=서울");
		mv.setViewName("msg.notiles");
		
		return mv;
		
	}
	
	 @RequestMapping(value="/hotel.we", method= {RequestMethod.GET})
	    public void hotel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		 String acc_idx = request.getParameter("acc_idx");
		 int n = service.hoteltag(acc_idx);
		 
	    }
	 
	 @RequestMapping(value = "/test.we", method = RequestMethod.GET)
	 public ModelAndView test(ModelAndView mv) throws Exception {
		 
		 mv.setViewName("test.tiles1");
		return mv;
		 
	 }
	
	 @RequestMapping(value="/checkEmail.we", method= {RequestMethod.POST})
	 @ResponseBody
	  public int checkEmail(HttpServletRequest request) throws Exception {
		 String email = request.getParameter("email");
		 System.out.println(email);
		 int n = 0;
		 n = service.checkEmail(email);
			GoogleMail mail = new GoogleMail();
			
			// 인증키를 랜덤하게 생성하도록 한다. 
			Random rnd = new Random();
			
			String certificationCode = "";
			// certificationCode ==> "sfwte0983154"
			
			char randchar = ' ';
			for(int i=0; i<5; i++) {
			/*
			   min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
			   int rndnum = rnd.nextInt(max - min + 1) + min;
			      영문 소문자 'a' 부터 'z' 까지 중 랜덤하게 1개를 만든다.	  
			*/
				randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
				certificationCode += randchar;
			}
			
			int randnum = 0;
			for(int i=0; i<7; i++) {
				randnum = rnd.nextInt(9-0+1)+0;
				certificationCode += randnum;
			}
			
			// 랜덤하게 생성한 인증코드를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
			HttpSession session = request.getSession();
			try {
				email="djfzms02@naver.com";
				mail.sendmail(email, certificationCode);
				
				session.setAttribute("certificationCode", certificationCode);
				// 자바에서 발급한 인증코드를 세션에 저장
				
				request.setAttribute("email", email);
			} catch(Exception e) {
				e.printStackTrace();
				
				n = -1;
			}
		 
	   return n;
	  }
	 @RequestMapping(value="/EmailverifyCertification.we", method= {RequestMethod.POST})
	 @ResponseBody
		public boolean EmailverifyCertification(HttpServletRequest request) throws Exception{
			String emailConfirm = request.getParameter("emailConfirm"); 
			
			HttpSession session = request.getSession();
			String certificationCode = (String) session.getAttribute("certificationCode");

			boolean bool = certificationCode.equals(emailConfirm);
			
			// !!! 중요 !!! //
			// 세션에 저장된 인증코드 삭제하기!!!!
			session.removeAttribute("certificationCode");
			
			return bool;
		}
	 
	 
	 
	 
}
