package com.spring.wetre.payment;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wetre.common.MyUtil;
import com.spring.wetre.model.CartVO;
import com.spring.wetre.model.PersonalVO;
import com.spring.wetre.payment.service.InterPaymentService;


@Controller
public class PaymentController {

	
	/// Service 의존객체 주입 ///
	@Autowired
	private InterPaymentService service;
	
	
	// #y6. 결제 페이지 띄우기
	@RequestMapping(value="/payment.we", method= {RequestMethod.POST})
	public ModelAndView requirePrivateLogin_payment(HttpServletRequest request, HttpServletResponse response,ModelAndView mv) {
		
		// 상세 페이지에서 넘어온 값을 받아옴.
		String acc_name = request.getParameter("acc_name");
		String acc_grade = request.getParameter("acc_grade");
		String rtype_name = request.getParameter("rtype_name");
		String rtype_cnt = request.getParameter("rtype_cnt");
		String acc_addr1 = request.getParameter("acc_addr1");
		String acc_addr2 = request.getParameter("acc_addr2");
		String acc_tel1 = request.getParameter("acc_tel1");
		String acc_tel2 = request.getParameter("acc_tel2");
		String acc_tel3 = request.getParameter("acc_tel3");
		String r_idx = request.getParameter("r_idx");
		String rtype_idx = request.getParameter("rtype_idx");
		String book_start = request.getParameter("book_start");
		String book_end = request.getParameter("book_end");
		String accPrice = request.getParameter("accPrice");
		String adultNum = request.getParameter("adultNum");
		String kidsNum = request.getParameter("kidsNum");
		
		System.out.println(acc_name+","+acc_grade+","+rtype_name+","+rtype_cnt+","+acc_addr1+","+acc_addr2
						   +","+acc_tel1+","+acc_tel2+","+acc_tel3+","+r_idx+","+rtype_idx
						   +","+book_start+","+book_end+","+accPrice+","+adultNum+","+kidsNum);	
		
		// 유저 정보는 세션에 있는거 받아오자
		HttpSession session = request.getSession();
		PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
		String p_name = loginuser.getP_name();
		String p_userid = loginuser.getP_userid();
		int idx = loginuser.getIdx();
		
		
		
		// 뷰단에 보내자
		mv.addObject("acc_name", acc_name);
		mv.addObject("acc_grade", acc_grade);
		mv.addObject("rtype_name", rtype_name);
		mv.addObject("rtype_cnt", rtype_cnt);
		mv.addObject("acc_addr1", acc_addr1);
		mv.addObject("acc_addr2", acc_addr2);
		mv.addObject("acc_tel1", acc_tel1);
		mv.addObject("acc_tel2", acc_tel2);
		mv.addObject("acc_tel3", acc_tel3);
		mv.addObject("r_idx", r_idx);
		mv.addObject("rtype_idx", rtype_idx);
		mv.addObject("book_start", book_start);
		mv.addObject("book_end", book_end);
		mv.addObject("accPrice", accPrice);
		mv.addObject("adultNum", adultNum);
		mv.addObject("kidsNum", kidsNum);
		mv.addObject("p_name", p_name);
		mv.addObject("p_userid", p_userid);
		mv.addObject("idx", idx);


		// 타이틀 관련
		mv.addObject("pagename", "Payment");
		
		mv.setViewName("personal/payment.tiles1");
		// 파일위치: /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/personal/payment.jsp
		
		return mv;
		
	} // end of 결제 페이지 띄움 ------------------

	
	
	
	// #y7. 결제: 아임포트
	@RequestMapping(value="/paymentEnd.we", method= {RequestMethod.POST})
	public ModelAndView requirePrivateLogin_paymentEnd(HttpServletRequest request, HttpServletResponse response,ModelAndView mv) {
		
		// 유저 정보 확인 //
		String idx = request.getParameter("idx");
		if(idx == null) idx = "";
		
		HttpSession session = request.getSession();
		PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
		
		// 로그인은 했는데, idx가 로그인 정보랑 일치하지 않을 경우
		if( !idx.equals(String.valueOf(loginuser.getIdx())) ) {
			String msg = "다른 사람 계정으로 결제할 순 없어!";
			String loc = "javascript:history.back()";

			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			mv.setViewName("msg");
		}
		// 로그인 했고, idx가 로그인 정보랑 일치할 경우
		else {
			
			// 뷰단에서 값 받아옴.
			String fk_acc_name = request.getParameter("fk_acc_name");
			String fk_rtype_name = request.getParameter("fk_rtype_name");
			String cart_cnt = request.getParameter("cart_cnt");
			String full_acc_addr = request.getParameter("full_acc_addr");
			String full_acc_tel = request.getParameter("full_acc_tel");
			String r_idx = request.getParameter("r_idx");
			String rtype_idx = request.getParameter("rtype_idx");
			String book_start = request.getParameter("book_start");
			String book_end = request.getParameter("book_end");
			String reserver = request.getParameter("reserver");
			String contactInfo = request.getParameter("contactInfo");
			String cart_price = request.getParameter("cart_price");
			String requestTxt = request.getParameter("requestTxt");
			String expectedTime = request.getParameter("expectedTime");
			String payMethod = request.getParameter("payMethod");
			String adultNum = request.getParameter("adultNum");
			String kidsNum = request.getParameter("kidsNum");			
			
			// 유저가 직접 입력하는 부분은 공격 막기
			reserver = MyUtil.replaceParameter(reserver);
			requestTxt = MyUtil.replaceParameter(requestTxt);
			
			
			// 아임포트에 꽂아주자			
			// 유저정보
			request.setAttribute("p_userid", loginuser.getP_userid());
			request.setAttribute("p_name", loginuser.getP_name());
			request.setAttribute("idx", idx);

			// 예약 정보
			request.setAttribute("fk_acc_name", fk_acc_name);
			request.setAttribute("fk_rtype_name", fk_rtype_name);
			request.setAttribute("cart_cnt", cart_cnt);
			request.setAttribute("full_acc_addr", full_acc_addr);
			request.setAttribute("full_acc_tel", full_acc_tel);
			request.setAttribute("r_idx", r_idx);
			request.setAttribute("rtype_idx", rtype_idx);
			request.setAttribute("book_start", book_start);
			request.setAttribute("book_end", book_end);
			request.setAttribute("reserver", reserver);			
			request.setAttribute("contactInfo", contactInfo);
			request.setAttribute("cart_price", cart_price);
			request.setAttribute("requestTxt", requestTxt);
			request.setAttribute("expectedTime", expectedTime);
			request.setAttribute("payMethod", payMethod);
			request.setAttribute("adultNum", adultNum);
			request.setAttribute("kidsNum", kidsNum);

			mv.setViewName("paymentGateway"); // 아임포트 결제창: 타일즈 쓰면 안 됨.
			// 파일위치: /FinalProjectC/src/main/webapp/WEB-INF/views/paymentGateway.jsp
		}
	
		return mv;
	} // end of 결제 페이지 띄움 ------------------


	
	
	// #y8. 결제 후 유저 예약정보 테이블에 정보 넣기
	@RequestMapping(value="/reserveInsert.we", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String requirePrivateLogin_reserveInsert(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		String result = "";
		
		try {	
			
			String p_userid = request.getParameter("p_userid");
			String p_name = request.getParameter("p_name");
			String fk_acc_name = request.getParameter("fk_acc_name");
			String fk_rtype_name = request.getParameter("fk_rtype_name");
			String cart_cnt = request.getParameter("cart_cnt");
			String full_acc_addr = request.getParameter("full_acc_addr");
			String full_acc_tel = request.getParameter("full_acc_tel");
			String r_idx = request.getParameter("r_idx");
			String rtype_idx = request.getParameter("rtype_idx");
			String book_start = request.getParameter("book_start");
			String book_end = request.getParameter("book_end");
			String reserver = request.getParameter("reserver");
			String contactInfo = request.getParameter("contactInfo");
			String cart_price = request.getParameter("cart_price");
			String requestTxt = request.getParameter("requestTxt");
			String expectedTime = request.getParameter("expectedTime");
			String payMethod = request.getParameter("payMethod");
			String adultNum = request.getParameter("adultNum");
			String kidsNum = request.getParameter("kidsNum");
			
			
			HashMap<String, String> reserveMap = new HashMap<String, String>();
			reserveMap.put("p_userid", p_userid);
			reserveMap.put("p_name", p_name);
			reserveMap.put("fk_acc_name", fk_acc_name);
			reserveMap.put("fk_rtype_name", fk_rtype_name);
			reserveMap.put("cart_cnt", cart_cnt);
			reserveMap.put("full_acc_addr", full_acc_addr);
			reserveMap.put("full_acc_tel", full_acc_tel);
			reserveMap.put("r_idx", r_idx);
			reserveMap.put("rtype_idx", rtype_idx);
			reserveMap.put("book_start", book_start);
			reserveMap.put("book_end", book_end);
			reserveMap.put("reserver", reserver);
			reserveMap.put("contactInfo", contactInfo);
			reserveMap.put("cart_price", cart_price);
			reserveMap.put("requestTxt", requestTxt);
			reserveMap.put("expectedTime", expectedTime);
			reserveMap.put("payMethod", payMethod);
			reserveMap.put("adultNum", adultNum);
			reserveMap.put("kidsNum", kidsNum);
			
			int reserveResult = service.insertReserveInfo(reserveMap);
			
			String msg = "";
	
			if(reserveResult == 0)
				msg = "예약에 실패했어..관리자한테 문의해줘!";
			else
				msg = "예약 됐어!";
	
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("msg", msg);
			
			result = jsonObj.toString();
		
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return result;
		
	} // end of 결제 후 유저 예약정보 테이블에 정보 넣기 ------------------
	
	
	
	
	// 예약목록 확인 페이지
	@RequestMapping(value = "/myPage.we", method = RequestMethod.GET)
	public ModelAndView myPage(ModelAndView mv, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		String userid = ((PersonalVO)session.getAttribute("loginuser")).getP_userid();
		
		List<CartVO> cvoList = service.selectCartList(userid);
		
		mv.addObject("cvoList", cvoList);
		mv.setViewName("personal/List.tiles1");
		return mv;
	}

	
	
	// 예약 1개 확인 페이지
	@RequestMapping(value = "/myPageDetail.we", method = RequestMethod.GET)
	public ModelAndView myPageDetail(ModelAndView mv, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		String userid = ((PersonalVO)session.getAttribute("loginuser")).getP_userid();
		String cartno = request.getParameter("cartno");
		
		HashMap<String, String> para = new HashMap<String, String>();
		para.put("userid", userid);
		para.put("cartno", cartno);
		
		CartVO cvo = service.selectCartOne(para);
		
		mv.addObject("cvo", cvo);
		mv.setViewName("personal/myPage.tiles1");
		
		return mv;		
	}
	
	
	
	
}
