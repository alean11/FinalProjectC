package com.spring.wetre.chy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
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
	private InterChyService service;

	
	
	/// #y1. 호텔 리스트 페이지 요청 ///
	@RequestMapping(value="accommodation/accList.we", method= {RequestMethod.GET})
	public ModelAndView accList(HttpServletRequest request, ModelAndView mv) {
		
		// #y2. 리스트 뷰단에 뿌려줄 지역명 및 코드를 불러옴.
		List<HashMap<String, String>> regionList =  service.getRegionList();
		
		
		/// #y3. 목록 뽑기 ///
		
		// ajax로 보낸 날씨별 지역명 얻어옴.
		String sunnyRegion = request.getParameter("sunny");
		String cloudyRegion = request.getParameter("cloudy");
		String badRegion = request.getParameter("bad");
		
		String[] sunnyRegionArr = (sunnyRegion != null)?sunnyRegion.split(","):null;
		String[] cloudyRegionArr = (cloudyRegion != null)?cloudyRegion.split(","):null;
		String[] badRegionArr = (badRegion != null)?badRegion.split(","):null;
		

		// 옵션으로 선택한 것들 얻어옴.
		String blendSearchWord = request.getParameter("blendSearchWord");
		String book_start = request.getParameter("book_start");
		String book_end = request.getParameter("book_end");
		String ay_fee = request.getParameter("ay_fee");
		String k_fee = request.getParameter("k_fee");
		String blendWeatherOpt = request.getParameter("blendWeatherOpt"); // advanced 할 때 봐서 문제 없으면 name 동일하게 하기

		
		
		// 옵션 선택한거 장난 막아야 됨.
		
		
		
		// 보내야 되는 변수들의 타입이 달라서 맵에 담아줌.
		HashMap<String, Object> optMap = new HashMap<String, Object>();
		optMap.put("sunnyRegionArr", sunnyRegionArr);
		optMap.put("cloudyRegionArr", cloudyRegionArr);
		optMap.put("badRegionArr", badRegionArr);
		optMap.put("blendSearchWord", blendSearchWord);
		optMap.put("book_start", book_start);
		optMap.put("book_end", book_end);
		optMap.put("ay_fee", ay_fee);
		optMap.put("k_fee", k_fee);
		optMap.put("blendWeatherOpt", blendWeatherOpt);
		
		
		// 검색값이 존재할 때 리스트 뽑아옴: 기본적으로는 첫화면이 아닌 이상 어른1, 아이1, 날씨좋음이 넘어옴.
		List<AccVO> accList = null;
		if( "sunny".equalsIgnoreCase(blendWeatherOpt) ) {
			accList =  service.getAccList(optMap);
		}
		else if ( "cloudy".equalsIgnoreCase(blendWeatherOpt) ) {
			accList =  service.getAccList(optMap);
		}
		else if ( "bad".equalsIgnoreCase(blendWeatherOpt) ) {
			accList =  service.getAccList(optMap);
		}
		else {
			accList =  service.getAccAllList();
		}
		
		
		// 뷰단에 보내자
		mv.addObject("menuname", "Accommodation"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("pagename", "Search List"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("menulink", request.getContextPath()+"/accommodation/accList.we"); // 헤더에 메뉴에 링크 주는거
		mv.addObject("pagelink", "link"); // 헤더에 메뉴에 링크 주는거
		
		mv.addObject("accList", accList);
		mv.addObject("regionList", regionList);
		mv.setViewName("accommodation/accommodation.tiles1");
		// 위치: /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/accommodation/accommodation.jsp

		return mv;
	} // end of 호텔 리스트 페이지 요청 ------------

	
	/// #y3. 호텔 리스트 뜨자마자 날씨api로 정보 받아옴 ///
	@RequestMapping(value="accommodation/kWeatherXML.we", method= {RequestMethod.GET})
	public String weatherApi() {
		
		return "api/kWeatherXML";
		
	} // end of 호텔 리스트 뜨자마자 날씨api로 정보 받아옴 ------------


	
	
	
	
	
}


