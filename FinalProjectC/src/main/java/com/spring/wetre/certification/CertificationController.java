package com.spring.wetre.certification;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wetre.certification.service.InterCertificationService;
import com.spring.wetre.common.GoogleMail;
import com.spring.wetre.common.SHA256;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class CertificationController {

	
	@Autowired
	private InterCertificationService service;
	
	
	///////////////////////////// 아이디 & 비번 찾기 ///////////////////////////////////////

	@RequestMapping(value = "/idFind.we", method = { RequestMethod.GET })
	public ModelAndView idFind(ModelAndView mv, HttpServletRequest request) {

		mv.setViewName("idFind.notiles");
		return mv;
	}
	
	
	@RequestMapping(value = "/pwdFind.we", method = { RequestMethod.GET })
	public ModelAndView pwdFind(ModelAndView mv, HttpServletRequest request) {
		
		mv.setViewName("pwdFind.notiles");
		return mv;
		
	}
	
	
	@RequestMapping(value = "/idFindEnd.we", method = { RequestMethod.POST})
	@ResponseBody
	public String idFindEnd(ModelAndView mv, HttpServletRequest request) {
		
		String type = request.getParameter("type");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("mobile", mobile);
		map.put("type", type);
		
		String userid = service.idFind(map);
		
		if(userid==null)
			userid = "null";
		
		return userid;
	}
	
	
	@RequestMapping(value = "/pwdChange.we", method = { RequestMethod.POST})
	@ResponseBody
	public int pwdChange(ModelAndView mv, HttpServletRequest request) {
		
		String type = request.getParameter("type");
		
		int n = 0;
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		pwd = SHA256.encrypt(pwd);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", pwd);
		map.put("type", type);
		
		n = service.pwdChange(map);
		
		return n;
	}
	
	
	
	
	
	///////////////////////////// 이메일 & 핸드폰 인증 ///////////////////////////////////////
	
	@RequestMapping(value = "/emailPage.we", method = { RequestMethod.GET })
	public String emailPage(HttpServletRequest request) throws Exception {
		return "emailPage.notiles";
	}

	
	@RequestMapping(value = "/phonePage.we", method = { RequestMethod.GET })
	public String phonePage(HttpServletRequest request) throws Exception {
		return "phonePage.notiles";
	}

	
	@RequestMapping(value = "/checkEmail.we", method = { RequestMethod.POST })
	@ResponseBody
	public int checkEmail(HttpServletRequest request) throws Exception {
		
		String type = request.getParameter("type");
		String email = request.getParameter("email");
		
		String p_userid = "";
		HttpSession session = request.getSession();
		PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
		if(loginuser!=null)
			p_userid = loginuser.getP_userid();
		else
			p_userid = request.getParameter("userid");
	
		
		HashMap<String, String> paramap = new HashMap<String, String>();
		paramap.put("email", email);
		paramap.put("type", type);
		paramap.put("p_userid", p_userid);
		
		int n = 0;
		n = service.checkEmail(paramap);
		
		if(n == 1) {
		
			GoogleMail mail = new GoogleMail();
	
			// 인증키를 랜덤하게 생성하도록 한다.
			Random rnd = new Random();
			
			String certificationCode = "";
			// certificationCode ==> "sfwte0983154"
	
			char randchar = ' ';
			for (int i = 0; i < 5; i++) {
				randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
				certificationCode += randchar;
			}
	
			int randnum = 0;
			for (int i = 0; i < 7; i++) {
				randnum = rnd.nextInt(9 - 0 + 1) + 0;
				certificationCode += randnum;
			}
	
			// 랜덤하게 생성한 인증코드를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
			try {
				mail.sendmail(email, certificationCode);
				session.setAttribute("certificationCode", certificationCode);
				// 자바에서 발급한 인증코드를 세션에 저장
				request.setAttribute("email", email);
			} catch (Exception e) {
				e.printStackTrace();
				n = -1;
			}
				
		}
		return n;
	}

	
	
	@RequestMapping(value = "/emailVerifyCertification.we", method = { RequestMethod.POST })
	@ResponseBody
	public boolean EmailverifyCertification(HttpServletRequest request) throws Exception {
		
		String emailConfirm = request.getParameter("emailConfirm");

		HttpSession session = request.getSession();
		String certificationCode = (String) session.getAttribute("certificationCode");

		boolean bool = certificationCode.equals(emailConfirm);
			session.setAttribute("okok", bool);
		
		// !!! 중요 !!! //
		// 세션에 저장된 인증코드 삭제하기!!!!
		session.removeAttribute("certificationCode");

		return bool;
	}
	
	
	
	@RequestMapping(value = "/checkPhone.we", method = RequestMethod.POST)
	public int checkPhone(HttpServletRequest request) throws Exception {
		
		int n = 0;
		String userType = "";
		String idx = "";
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser")!=null) {
			userType = "personal_mbr";
			PersonalVO pervo = (PersonalVO) session.getAttribute("loginuser");
			idx = Integer.toString(pervo.getIdx());
		}
		else if(session.getAttribute("companyuser")!=null) {
			userType = "company_mbr";
			CompanyVO comvo = (CompanyVO) session.getAttribute("companyuser");
			idx = Integer.toString(comvo.getIdx());
		}
		String tel = request.getParameter("phone");
		
		HashMap<String, String> paramap = new HashMap<String, String>();
		paramap.put("userType", userType);
		paramap.put("idx", idx);
		paramap.put("tel", tel);
		
		n = service.telcheck(paramap);
		if(n==1) {
			String api_key = "NCS8LAOMSUNBE4L2";
		    String api_secret = "DHYVGBJ14OQK9CGPKJBGOU6CKCKAYDCM";
		    Message coolsms = new Message(api_key, api_secret);
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
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", tel); // 수신번호
		    params.put("from", "01046657830"); // 발신번호
		    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
		    params.put("text", "OO을 위한 인증코드입니다. 인증코드란에 아래의 인증코드를 입력해주세요. 인증코드는 ["+certificationCode+"] 입니다."); // 문자내용    
		    params.put("app_version", "JAVA SDK v2.2"); // application name and version
		    /*params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.*/
		    
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      session.setAttribute("certificationCode", certificationCode);
		    } catch (CoolsmsException e) {
		    	n = -1;
		    }
		}
		return n;
	}
	
	
	// 인증결과
	@RequestMapping(value = "/phoneVerifyCertification.we", method = RequestMethod.POST)
	public boolean phoneVerifyCertification(HttpServletRequest request) throws Exception {
		
		String emailConfirm = request.getParameter("emailConfirm");

		HttpSession session = request.getSession();
		String certificationCode = (String) session.getAttribute("certificationCode");
		boolean bool = certificationCode.equals(emailConfirm);
		session.setAttribute("okok", bool);

		session.removeAttribute("certificationCode");

		return bool;		
	}
	
	
	
	@RequestMapping(value = "/ok.we", method = RequestMethod.GET)
	@ResponseBody
	public boolean ok(HttpServletRequest request) throws Exception {
		boolean result = false;
		HttpSession session = request.getSession();
		result = (boolean) session.getAttribute("okok");
		return result;
		
	}

	
	
	
	
	
}
