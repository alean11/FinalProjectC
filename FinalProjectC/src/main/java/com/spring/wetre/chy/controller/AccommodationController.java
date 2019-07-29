package com.spring.wetre.chy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
		
		/*if(acc_gradeArr != null) {
			for(String acc_grade : acc_gradeArr) {
				System.out.println("호텔등급:"+acc_grade);
			}
		}*/
		
		// 옵션 선택한거 장난 막아야 됨.

		
		
		// 옵션 중 가격은 값이 없을 경우 최소값 0, 최대값 7백만원 해줌. -> DB에 넣은 방값 중에 계산해서 7백 넘어가는거 있으면 잡아줘야 됨;
		if(accListPrice1 == null || "".equals(accListPrice1))
			accListPrice1 = "0";
		if(accListPrice2 == null || "".equals(accListPrice2))
			accListPrice2 = "777777";
		
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
		optMap.put("startRno", 1);
		optMap.put("endRno", 9);
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
		for(String sunny : (String[])test) {
			System.out.println("좋음 들어갔니?"+sunny);
		}*/
		
		// DB로 가자 //
		List<AccVO> accList = service.getAccList(optMap); // 검색어 포함 상품목록
		List<HashMap<String, String>> regionList =  service.getRegionList(); // 지역명
		List<HashMap<String, Object>> accGradeCntList = service.getAccGradeCnt(optMap); // 호텔 등급별 개수
		List<HashMap<String, Object>> accTypeCntList = service.getAccTypeCnt(optMap); // 호텔 타입별 개수
		
		
		
		// 뷰단에 보내자 //
		// 헤더 관련
		mv.addObject("menuname", "Accommodation"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("pagename", "Search List"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("menulink", request.getContextPath()+"/accommodation/accList.we"); // 헤더에 메뉴에 링크 주는거
		mv.addObject("pagelink", "link"); // 헤더에 메뉴에 링크 주는거
		
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
		mv.addObject("acc_gradeArr", acc_gradeArr);
		mv.addObject("acc_typeArr", acc_typeArr);
		
		// 날씨 이미지 관련
		mv.addObject("sunnyRegionArr", sunnyRegionArr);
		mv.addObject("cloudyRegionArr", cloudyRegionArr);
		mv.addObject("badRegionArr", badRegionArr);

		// 리스트
		mv.addObject("accList", accList);
		mv.addObject("regionList", regionList);
		mv.addObject("accGradeCntList", accGradeCntList);
		mv.addObject("accTypeCntList", accTypeCntList);

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
		
		/*int[] observeArr = new int[205];
		for(int i=89, j=0; i<observeArr.length; i++) {
			observeArr[j] = i+1;
			System.out.println(observeArr[j]);
		}*/
		
		// 값으로 넣어줄 날짜 뽑아야 됨
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		
		String str_year = String.valueOf(year);
		String str_month = String.valueOf(month);
		String str_day = String.valueOf(day);
		
		if( str_month.length() != 2  ) {
			str_month = "0"+str_month;
		}
		if( str_day.length() != 2  ) {
			str_day = "0"+str_day;
		}
		
		
		String str_hour = "";
		
		if( 6 < hour && hour < 18) {
			str_hour = "0600";
		}
		if( 18 < hour ) {
			str_hour = "1800";
		}
		if(hour < 6) {
			str_day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH)-1);
			str_hour = "1800";
		}
		
		System.out.println(str_year+str_month+str_day+str_hour);
		
		request.setAttribute("tmFc", str_year+str_month+str_day+str_hour);
		
		return "api/kLongWeatherXML";
		
	} // end of 호텔 리스트 뜨자마자 날씨api로 정보 받아옴 ------------


	
	
	
	
	
}


