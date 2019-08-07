package com.spring.wetre.chy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.MyUtil;
import com.spring.wetre.chy.service.*;
import com.spring.wetre.model.*;

/// 컨트롤러 선언 ///
@Controller
public class AccommodationController {

	
	/// Service 의존객체 주입 ///
	@Autowired
	private InterAccommodationService service;

	
	
	/// #y1. 호텔 리스트 페이지 요청 ///
	@RequestMapping(value="/accommodation/accList.we", method= {RequestMethod.GET})
	public ModelAndView accList(HttpServletRequest request, ModelAndView mv) {
		
		/// #y2. 목록 뽑기 ///
		
		// ajax로 보낸 날씨별 지역명 얻어옴: 콤마 넣어서 합쳐둔 문자열임.
		String sunnyRegionAjax = request.getParameter("sunny");
		String cloudyRegionAjax = request.getParameter("cloudy");
		String badRegionAjax = request.getParameter("bad");
		
		System.out.println("좋음hidden: "+sunnyRegionAjax);
		System.out.println("흐림hidden: "+cloudyRegionAjax);
		System.out.println("나쁨hidden: "+badRegionAjax);
		
		// 얻어온 지역명을 나눠서 배열로 바꿔줌.
		String[] sunnyRegionArr = null;
		String[] cloudyRegionArr =  null;
		String[] badRegionArr =  null;
	
		if(sunnyRegionAjax != null && !"".equals(sunnyRegionAjax)) {
			//sunnyRegionAjax = sunnyRegionAjax.substring(0, sunnyRegionAjax.lastIndexOf(",")); // 마지막 콤마 뺐었는데, 이거 빼면 다시 뷰단으로 보낼 때 콤마가 없고, 재검색할때 그 값을 받아오면 콤마 없어서 여기서 에러남. 그래서 지움.
			sunnyRegionArr = sunnyRegionAjax.split(",");
			/*for(String sun : sunnyRegionArr) { System.out.println("좋음if문: "+sun); }*/
		}
		if(cloudyRegionAjax != null && !"".equals(cloudyRegionAjax)) {
			//cloudyRegionAjax = cloudyRegionAjax.substring(0, cloudyRegionAjax.lastIndexOf(","));
			cloudyRegionArr = cloudyRegionAjax.split(",");
			/*for(String cl : cloudyRegionArr) { System.out.println("흐림if문: "+cl); }*/
		}
		if(badRegionAjax != null && !"".equals(badRegionAjax)) {
			//badRegionAjax = badRegionAjax.substring(0, badRegionAjax.lastIndexOf(","));
			badRegionArr = badRegionAjax.split(",");
			/*for(String bad :badRegionArr) { System.out.println("나쁨if문: "+bad); }*/
		}

		
		// 만약 얻어온 지역명이 없다면, 값을 '없음' 으로 넣어줘야 함. 그래야 검색했을 때 결과가 안 뜸.
		String[] none = {"없음"};
		if(sunnyRegionAjax == null || "".equals(sunnyRegionAjax))
			sunnyRegionArr = none;
		if(cloudyRegionAjax == null || "".equals(cloudyRegionAjax))
			cloudyRegionArr = none;
		if(badRegionAjax == null || "".equals(badRegionAjax))
			badRegionArr = none;
		
		
		
		// 검색 옵션으로 선택한 것들 얻어옴.
		String blendSearchWord = request.getParameter("blendSearchWord");
		String book_start = request.getParameter("book_start");
		String book_end = request.getParameter("book_end");
		String adultNum = request.getParameter("adultNum");
		String kidsNum = request.getParameter("kidsNum");
		String blendWeatherOpt = request.getParameter("blendWeatherOpt"); // 클라이언트가 선택한 날씨. advanced 할 때 봐서 문제 없으면 name 동일하게 하기
		String accListPrice1 = request.getParameter("accListPrice1");
		String accListPrice2 = request.getParameter("accListPrice2");
		String blendWeatherDaysOpt = request.getParameter("blendWeatherDaysOpt"); // 검색 옵션 유지 시키려고 가져온 것임.
		String[] acc_gradeArr = request.getParameterValues("acc_grade");
		String[] acc_typeArr = request.getParameterValues("acc_type");
		
		System.out.println("accListPrice1: "+accListPrice1);
		System.out.println("accListPrice2: "+accListPrice2);
		System.out.println("adultNum: "+adultNum);
		System.out.println("kidsNum: "+kidsNum);
		System.out.println("예약시작일: "+book_start);
		System.out.println("예약끝일: "+book_end);
		System.out.println("검색어: "+blendSearchWord);
		System.out.println("날씨옵션: "+blendWeatherOpt);
		System.out.println("날씨기간: "+blendWeatherDaysOpt);
		if(acc_gradeArr != null) {
			for(String acc_grade : acc_gradeArr) {
				System.out.println("호텔등급:"+acc_grade);
			}
		}

		
				
		// 옵션 선택한거 장난 막아야 됨.
		
		
		
		// 옵션 중 가격은 값이 없을 경우 최소값 0, 최대값 7백만원 해줌. -> DB에 넣은 방값 중에 계산해서 7백 넘어가는거 있으면 잡아줘야 됨;
		if(accListPrice1 == null || "".equals(accListPrice1))
			accListPrice1 = "0";
		if(accListPrice2 == null || "".equals(accListPrice2))
			accListPrice2 = "7777777";
		
		// 옵션 중 인원수는 값이 없을 경우, 전체 값을 뽑아야 하니까 기본값 1 줌.
		if(adultNum == null || "".equals(adultNum))
			adultNum = "1";
		if(kidsNum == null || "".equals(kidsNum))
			kidsNum = "1";
		

		// 보내야 되는 변수들의 타입이 달라서, 맵에 담아줌.
		HashMap<String, Object> optMap = new HashMap<String, Object>();
		optMap.put("book_start", book_start);
		optMap.put("book_end", book_end);
		optMap.put("adultNum", adultNum);
		optMap.put("kidsNum", kidsNum);
		optMap.put("accListPrice1", accListPrice1);
		optMap.put("accListPrice2", accListPrice2);
		optMap.put("acc_gradeArr", acc_gradeArr);
		optMap.put("acc_typeArr", acc_typeArr);
		
		// 검색어(blendSearchWord)만 왔을 경우
		if( (blendSearchWord != null && !"".equals(blendSearchWord)) &&
			(blendWeatherOpt == null || "".equals(blendWeatherOpt))) {
			
			System.out.println(">>>>>>>>> 검색어만 왔음");
			optMap.put("blendSearchWord", blendSearchWord);
			optMap.put("regionArr", "");
		}
		
		// 날씨(blendWeatherOpt)만 왔을 경우. 날씨 있는게 참, 검색어 없는게 참.
		if( (blendSearchWord == null || "".equals(blendSearchWord)) &&
			(blendWeatherOpt != null && !"".equals(blendWeatherOpt)) ) {
			
			System.out.println(">>>>>>>>> 날씨옵션만 왔음");
			
			optMap.put("blendSearchWord", "");
			
			if("sunny".equalsIgnoreCase(blendWeatherOpt))
				optMap.put("regionArr", sunnyRegionArr);
			else if("cloudy".equalsIgnoreCase(blendWeatherOpt))
				optMap.put("regionArr", cloudyRegionArr);
			else if("bad".equalsIgnoreCase(blendWeatherOpt))
				optMap.put("regionArr", badRegionArr);
			else
				optMap.put("regionArr", "");
			
		}
		
		// 검색어(blendSearchWord)와 날씨(blendWeatherOpt) 다 왔을 경우
		if( (blendSearchWord != null && !"".equals(blendSearchWord)) &&
			(blendWeatherOpt != null && !"".equals(blendWeatherOpt)) ) {
			
			System.out.println(">>>>>>>>> 검색어&날씨 둘 다 옴");
			
			optMap.put("blendSearchWord", blendSearchWord);

			if("sunny".equalsIgnoreCase(blendWeatherOpt))
				optMap.put("regionArr", sunnyRegionArr);
			else if("cloudy".equalsIgnoreCase(blendWeatherOpt))
				optMap.put("regionArr", cloudyRegionArr);
			else if("bad".equalsIgnoreCase(blendWeatherOpt))
				optMap.put("regionArr", badRegionArr);
			else
				optMap.put("regionArr", "");
			
		}
		
		// 날씨지역이랑 검색어 전부 안 온 경우
		if( (blendSearchWord == null || "".equals(blendSearchWord)) &&
			(blendWeatherOpt == null || "".equals(blendWeatherOpt)) ) {
			
			System.out.println(">>>>>>>>> 검색어&날씨 둘 다 안 왔음");
						
			optMap.put("blendSearchWord", "");
			optMap.put("regionArr", "");
		}

		/*Object test = optMap.get("regionArr");
		for(String sunny : (String[])test) {System.out.println("좋음 들어갔니?"+sunny);}*/
		

		// 페이징 처리 위한 변수 생성
		String str_currentPageNo = request.getParameter("currentPageNo"); // 현재 페이지 번호를 받아옴.
		int currentPageNo = 0; // 현재 페이지 번호. 초기치는 1페이지로 설정
		int totalAccCnt = 0; // 총 게시물 개수
		int sizePerPage = 9; // 한 페이지 당 보여줄 행 개수(블럭 사이즈랑 다른 것임).
		int totalPage = 0; // 총 페이지수(페이지바에 뜰 개수 말하는거)
		int startRno = 0;// DB에서 셀렉트한 데이터 행들의 시작행번호
		int endRno = 0; // DB에서 셀렉트한 데이터 행들의 끝행 번호
		int blockSize = 5; // 페이지바에 숫자 몇개씩 나오게 할건지.
		
		totalAccCnt = service.getAccListCount(optMap); // 검색어 (미)포함 총 게시물 수
		System.out.println("총게시물수: "+totalAccCnt);
		// 총 페이지수 계산
		totalPage = (int) Math.ceil( (double)totalAccCnt/sizePerPage );
		System.out.println("총 페이지 수: "+totalPage);
		
		// 페이지 번호 장난 막기: 총 게시물수가 필요해서 밑으로 내림.
		if(str_currentPageNo == null) {
			currentPageNo = 1;
		}
		else {
			try {
				currentPageNo = Integer.parseInt(str_currentPageNo);
				
				if(currentPageNo < 1 || currentPageNo > totalPage) {
					currentPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentPageNo = 1;
			}
		} // end of 페이지 번호 장난 막기 ----------

		// 가져올 게시글의 범위 구하기
		startRno = ((currentPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		optMap.put("startRno", startRno);
		optMap.put("endRno", endRno);
		System.out.println("startRno: "+startRno);
		System.out.println("endRno: "+endRno);
		
		// DB로 가자 //
		List<AccVO> accList = service.getAccList(optMap); // 검색어 (미)포함 상품목록
		List<HashMap<String, Object>> accGradeCntList = service.getAccGradeCnt(optMap); // 호텔 등급별 개수
		List<HashMap<String, Object>> accTypeCntList = service.getAccTypeCnt(optMap); // 호텔 타입별 개수
		
		
		// 페이지 번호 리스트 만듦
		int loop = 1;
		int prev = 0;
		int next = 0;
		int pageNo = ((currentPageNo - 1)/blockSize) * blockSize + 1; // 페이지 번호
		List<Integer> pageNoList = new ArrayList<Integer>();
		System.out.println("반복문 들어가기 전 페이지 숫자(pageNo): "+pageNo);
		
		// 이전
		if(pageNo != 1) {
			prev = pageNo-1;
		}

		// 일반 페이지 번호들
		while( !(loop>blockSize || pageNo>totalPage) ) {
			pageNoList.add(pageNo);
			loop++;
			pageNo++;
			System.out.println("반복문 안 페이지 숫자(pageNo): "+pageNo);
		}// end of while-----------
		
		// 다음
		if(!(pageNo>totalPage)) {
			next = pageNo;
		}
		System.out.println("결과적으로 나온 페이지 숫자(pageNo): "+pageNo);
		
		
		for(int i : pageNoList) {
			System.out.println("페이지 리스트: "+i);
		}
		
		// 뷰단에 보내자 //
		// 헤더 관련
		mv.addObject("pagename", "Accommodation"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("pagelink", request.getContextPath()+"/accommodation/accList.we"); // 헤더에 메뉴에 링크 주는거
		
		// 옵션 유지 관련
		mv.addObject("blendSearchWord", blendSearchWord);
		mv.addObject("blendWeatherOpt", blendWeatherOpt);
		mv.addObject("book_start", book_start);
		mv.addObject("book_end", book_end);
		mv.addObject("adultNum", adultNum);
		mv.addObject("kidsNum", kidsNum);
		mv.addObject("accListPrice1", accListPrice1);
		mv.addObject("accListPrice2", accListPrice2);
		mv.addObject("sunnyRegionAjax", sunnyRegionAjax);
		mv.addObject("cloudyRegionAjax", cloudyRegionAjax);
		mv.addObject("badRegionAjax", badRegionAjax);
		mv.addObject("blendWeatherDaysOpt", blendWeatherDaysOpt);
		mv.addObject("acc_typeArr", acc_typeArr);
		mv.addObject("acc_gradeArr", acc_gradeArr);
		
		// 날씨 이미지 관련
		mv.addObject("sunnyRegionArr", sunnyRegionArr);
		mv.addObject("cloudyRegionArr", cloudyRegionArr);
		mv.addObject("badRegionArr", badRegionArr);

		// 페이지바 관련
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		mv.addObject("pageNoList", pageNoList);
		mv.addObject("currentPageNo", currentPageNo);
		
		// 리스트
		mv.addObject("accList", accList);
		mv.addObject("accGradeCntList", accGradeCntList);
		mv.addObject("accTypeCntList", accTypeCntList);

		// 뭔지 모르지만 일단 냅둠.
		String gobackURL = MyUtil.getCurrentURL(request);
		mv.addObject("gobackURL", gobackURL);

		mv.setViewName("accommodation/accommodation.tiles1");
		// 위치: /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/accommodation/accommodation.jsp

		return mv;
	} // end of 호텔 리스트 페이지 요청 ------------

	
	
	
	/// #y3. 현재 날씨 정보를 api로 받아옴 ///
	@RequestMapping(value="/accommodation/kNowWeatherXML.we", method= {RequestMethod.GET})
	public String kNowWeatherApi(HttpServletRequest request) {
		
		return "api/kNowWeatherXML";
		
	} // end of 현재 날씨 정보를 api로 받아옴 ------------
	
	
	
	
	/// #y4. 중기예보 날씨정보를 api로 받아옴: '도'별로만 예보가 뜸.  ///
	@RequestMapping(value="/accommodation/kLongWeatherXML.we", method= {RequestMethod.GET})
	public String weatherApi(HttpServletRequest request) {

		String regid = request.getParameter("regid");
		
		// 값으로 넣어줄 날짜 뽑아야 됨
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		
		String str_year = String.valueOf(year);
		String str_month = String.valueOf(month);
		String str_day = String.valueOf(day);
		
		if( str_month.length() != 2  )
			str_month = "0"+str_month;
		if( str_day.length() != 2  )
			str_day = "0"+str_day;
		
		String str_hour = "";
		if( 6 < hour && hour < 18)
			str_hour = "0600";
		if( 18 < hour )
			str_hour = "1800";
		if(hour < 6) {
			str_day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH)-1);
			str_hour = "1800";
		}
		
		// System.out.println(str_year+str_month+str_day+str_hour);
		
		request.setAttribute("regid", regid);
		request.setAttribute("tmFc", str_year+str_month+str_day+str_hour);
		
		return "api/kLongWeatherXML";
		
	} // end of 중기예보 날씨정보를 api로 받아옴: '도'별로만 예보가 뜸. ------------


	
	// #y5. 검색어 자동 완성3
	@RequestMapping(value="/accommodation/autoSearchWord.we", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String wordSearchShow(HttpServletRequest request) {
		
		String blendSearchWordAjax = request.getParameter("blendSearchWordAjax");
		/*System.out.println("검색어 자동완성 컨트롤러 왔음: "+blendSearchWordAjax);*/
		
		HashMap<String, String> ajaxMap = new HashMap<String, String>();
		ajaxMap.put("blendSearchWordAjax", blendSearchWordAjax);
		// 주의!! 만약 매퍼에서 if문을 사용하고, 그 안에 들어갈 값으로 String 타입을 보낼 경우 에러남.
		// String의 경우는 getter 메소드가 없기 때문에, 파라미터 인자로 String을 그대로 보내면 에러가 난다는 듯.
		
		List<AccVO> accAddrNameList = service.autoSearchWord(ajaxMap); // 호텔주소 & 호텔이름 뽑아옴.
		List<HashMap<String, String>> accRegionList = service.getRegionList(ajaxMap); // 호텔 위치한 지역 뽑아옴.
		
		JSONArray jsonArr = new JSONArray();

		if(accAddrNameList != null) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("accAddrNameList", accAddrNameList);
			jsonArr.put(jsonObj);
		}
		if(accRegionList != null) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("accRegionList", accRegionList);
			jsonArr.put(jsonObj);
		}
		
		String result = jsonArr.toString();
		return result;
		
	} // end of 검색어 자동 완성 ------------------
	
	
	
	// #y9. 실시간 채팅 창 띄우기
	@RequestMapping(value="/realTimeChat.we", method= {RequestMethod.GET})
	public String realTimeChat() {

		return "realTimeChat";
		
	} // end of 실시간 채팅 -------------
	
	
	
	// #y10. 태그 클라우드 ajax
	@RequestMapping(value="/accommodation/tagCloud.we", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String tagCloud() {

		List<HashMap<String, Object>> tagList = service.getTagList();
		
		JSONArray jsonArr = new JSONArray();

		if(tagList != null) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("tagList", tagList);
			jsonArr.put(jsonObj);
		}

		String result = jsonArr.toString();
		return result;
		
	} // end of 실시간 채팅 -------------
	
	
	
	
/*	// #y11. 챗봇한테 보내줄 JSON 파일
	@RequestMapping(value="/accommodation/chatBot.we", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public ModelAndView chatBot(HttpServletRequest request, ModelAndView mv) {

		String botRequest = request.getParameter("botRequest");
		System.out.println("리퀘스트 왓니?: "+botRequest);
		
		String result = "";
		if("3".equals(botRequest)) { 
		
			// 3. 지금 가장 핫한 호텔/리조트
			List<HashMap<String, Object>> tagList = service.getTagList();
			
			if(tagList != null) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("tagList", tagList);
				result = jsonObj.toString();
			}			
		} // end of 지금 가장 핫한 호텔/리조트 ------
		
		mv.addObject("result", result);
		mv.setViewName("api/chatBotJSON");
		
		return mv;
		
	} // end of 실시간 채팅 -------------
*/	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 결제관련: 영진이랑 합칠 때 동일 컨트롤러에 넣어야 함.
	
	// #y6. 결제 페이지 띄우기
	@RequestMapping(value="/payment.we", method= {RequestMethod.GET}) // 이거 나중에 POST로 바꿀 것!!
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
	
	
	
	
	
	
	
	
	
	
	
	
	
}


