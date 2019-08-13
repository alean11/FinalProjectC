package com.spring.wetre.accommodation;

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

import com.spring.wetre.accommodation.service.InterAccommodationService;
import com.spring.wetre.common.MyUtil;
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
		
		// 얻어온 지역명을 나눠서 배열로 바꿔줌.
		String[] sunnyRegionArr = null;
		String[] cloudyRegionArr =  null;
		String[] badRegionArr =  null;
		if(sunnyRegionAjax != null && !"".equals(sunnyRegionAjax))
			sunnyRegionArr = sunnyRegionAjax.split(",");
		if(cloudyRegionAjax != null && !"".equals(cloudyRegionAjax))
			cloudyRegionArr = cloudyRegionAjax.split(",");
		if(badRegionAjax != null && !"".equals(badRegionAjax))
			badRegionArr = badRegionAjax.split(",");

		
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
			optMap.put("blendSearchWord", blendSearchWord);
			optMap.put("regionArr", "");
		}
		
		// 날씨(blendWeatherOpt)만 왔을 경우. 날씨 있는게 참, 검색어 없는게 참.
		if( (blendSearchWord == null || "".equals(blendSearchWord)) &&
			(blendWeatherOpt != null && !"".equals(blendWeatherOpt)) ) {
						
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
			optMap.put("blendSearchWord", "");
			optMap.put("regionArr", "");
		}
		

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
		totalPage = (int) Math.ceil( (double)totalAccCnt/sizePerPage ); // 총 페이지수 계산
		
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
		
		// 이전
		if(pageNo != 1) {
			prev = pageNo-1;
		}

		// 일반 페이지 번호들
		while( !(loop>blockSize || pageNo>totalPage) ) {
			pageNoList.add(pageNo);
			loop++;
			pageNo++;
		}// end of while-----------
		
		// 다음
		if(!(pageNo>totalPage)) {
			next = pageNo;
		}
		
		// 뷰단에 보내자 //
		// 헤더 관련
		mv.addObject("menuname", "Map");
		mv.addObject("menulink", request.getContextPath()+"/map.we"); 
		mv.addObject("pagename", "Accommodation");
		mv.addObject("pagelink", request.getContextPath()+"/accommodation/accList.we");

		
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
	
	
	
	
	
	
	
	/////////////////////////////  상세페이지 시작   ///////////////////////////////////
	
	@RequestMapping(value="/accommodation/accView.we", method= {RequestMethod.GET})
	public ModelAndView accView(HttpServletRequest request, ModelAndView mv, HttpServletResponse response) {
		
		String str_acc_idx = request.getParameter("acc_idx");
				
		int acc_idx = 0;
		if(str_acc_idx != null && str_acc_idx != "")
			acc_idx = Integer.parseInt(str_acc_idx);
				
		try {
						
			// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
			AccVO avo = service.getOneAccInfomation(acc_idx);
			
			// 숙박시설 추가이미지 조회해오기
			List<HashMap<String,String>> addaccImgList = service.getAddaccImg(acc_idx);
									
			
			if(avo == null) {
		 		// GET방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 고유번호를 입력한 경우  
		 		mv.addObject("errorAcc", "검색하신 "+acc_idx+"에 대한 객실은 존재하지 않습니다.");
		 		mv.setViewName("accommodation/acc_errorpage.tiles1");
		 	}
		 	else {
		 		// 숙박시설 목록이 존재하는 경우
		 		
		 		// 태그 테이블에 숫자를 업데이트 함. (근데 인서트는 없음)
		 		service.hoteltag(str_acc_idx);
		 		
		 		mv.addObject("avo", avo);
		 		mv.addObject("addaccImgList", addaccImgList);		 				 		
		 		request.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
		 		mv.setViewName("accommodation/acc_view.tiles1");
		 	}
				
		} catch (Throwable e) {
			// GET방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
			mv.addObject("errorAcc", "검색하신 "+acc_idx+"제품은 존재하지 않습니다.");
	 		mv.setViewName("accommodation/acc_errorpage.tiles1");
		}

		
		// 구글 지도 사용하기
		String acc_addr1 = service.getAccMapList(acc_idx);
		
		mv.addObject("acc_addr1", acc_addr1);
		return mv;
	}
	
	
	
	// ajax를 이용해서 객실 정보 조회하기
	@RequestMapping(value="/accommodation/acc_view2.we", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String acc_view2(HttpServletRequest request) {
		
		String book_start = request.getParameter("book_start");
		String book_end = request.getParameter("book_end");
		String adult = request.getParameter("adult");
		String kids = request.getParameter("kids");
		String acc_idx = request.getParameter("acc_idx");
		
				
		HashMap<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("book_start", book_start);
		paraMap.put("book_end", book_end);
		paraMap.put("adult", adult);
		paraMap.put("kids", kids);
		paraMap.put("acc_idx", acc_idx);
		
		// 객실 종류 및 요금 조회하기
		List<HashMap<String, String>> roomList = service.getRoomTypeAndPrice(paraMap);
				
		String result = "";
			
		JSONArray jsonArr = new JSONArray();
				
		if(roomList != null) {
			for(HashMap<String, String> room : roomList) {
				
			    JSONObject json = new JSONObject();				
			    json.put("acc_idx", room.get("acc_idx"));
			    json.put("r_idx", room.get("r_idx"));
				json.put("rtype_idx", room.get("rtype_idx"));
				json.put("rtype_name", room.get("rtype_name"));
				json.put("rtype_cnt", room.get("rtype_cnt"));
				json.put("totalpay", room.get("totalpay"));
				json.put("BM_AMENITY", room.get("BM_AMENITY"));
				json.put("BM_DEVICE", room.get("BM_DEVICE"));
				json.put("BM_BR_ADDFEE", Integer.parseInt(room.get("BM_BR_ADDFEE")));
				json.put("book_start", room.get("book_start"));
				json.put("book_end", room.get("book_end"));
						 
				jsonArr.put(json);
			}
				
				result = jsonArr.toString();
		}
				
		return result;	
	}
	
	
	
	
	// ajax를 이용해서 좋아요 출력하기
	@RequestMapping(value="/accommodation/like.we", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String PrivateLike(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			JSONObject jsonobj = new JSONObject();	
			String userid = request.getParameter("userid");
			String str_acc_idx = request.getParameter("acc_idx");
			int acc_idx = Integer.parseInt(str_acc_idx);
			
			
			HashMap<String, Object> paraMap = new HashMap<String, Object>();
			paraMap.put("userid", userid);
			paraMap.put("acc_idx", acc_idx);
					
			try {
				
				 int n = service.like(paraMap);
				 
				 if(n == 1) {
					 jsonobj.put("msg", "해당 제품에 \n좋아요를 클릭하셨습니다.");
				 }
			} catch (Throwable e) {
					 jsonobj.put("msg", "이미 좋아요를 클릭하셨기에 \n두번이상 좋아요는 불가합니다.");
			}
			
			String result = jsonobj.toString();
			
			return result;
	}
	

	
	
	// ajax를 이용해서 싫어요 출력하기
	@RequestMapping(value="/accommodation/disLike.we", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String PrivateDisLike(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			JSONObject jsonobj = new JSONObject();	
			String userid = request.getParameter("userid");
			String str_acc_idx = request.getParameter("acc_idx");
			int acc_idx = Integer.parseInt(str_acc_idx);
						
			HashMap<String, Object> paraMap = new HashMap<String, Object>();
			paraMap.put("userid", userid);
			paraMap.put("acc_idx", acc_idx);
					
			try {
				
				 int n = service.disLike(paraMap);
				 
				 if(n == 1) {
					 jsonobj.put("msg", "해당 제품에 \n싫어요를 클릭하셨습니다.");
				 }
			} catch (Throwable e) {
					 jsonobj.put("msg", "이미 싫어요를 클릭하셨기에 \n두번이상 싫어요는 불가합니다.");
			}
			
			String result = jsonobj.toString();
			
			return result;
	}
	
	
	
	
	// 좋아요 싫어요 갯수 구하기
	@RequestMapping(value="/accommodation/likeDislikeCount.we", method= {RequestMethod.GET})
	@ResponseBody
	public String likeDislikeCount(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String acc_idx = request.getParameter("acc_idx");
		
		
		HashMap<String, Integer> likeDislikeMap = service.getLikeDislikeCount(acc_idx);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("LIKECNT", likeDislikeMap.get("LIKECNT"));
		jsonObj.put("DISLIKECNT", likeDislikeMap.get("DISLIKECNT"));
		
		String result = jsonObj.toString();
		
		return result;
	}
	
	
	
	
	// 댓글 쓰기
	@RequestMapping(value="/accommodation/commentRegister.we", method= {RequestMethod.POST})
	public ModelAndView commentRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) throws Exception {
		
		String comments = request.getParameter("comments");
		String acc_idx = request.getParameter("acc_idx");
		
		
		HttpSession session = request.getSession();
		String userid = ((PersonalVO) session.getAttribute("loginuser")).getP_userid();
		
		CommentVO cmtvo = new CommentVO();
		cmtvo.setFk_userid(userid);
		cmtvo.setAcc_idx((acc_idx));
		cmtvo.setComments(comments);
				
		try {
			int n = service.addComment(cmtvo); // 얘는 select가 아니라 insert 하겠다 라는 코드이다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mv.setViewName("accommodation/acc_view.tiles1");
		return mv;
	}
	
	
	// 댓글 보여주기
	@RequestMapping(value="/accommodation/commentList.we", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String commentList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String acc_idx = request.getParameter("acc_idx");
				
		JSONArray jsArr = new JSONArray();
		
		try {
			List<CommentVO> commentList = service.commentVOList(acc_idx);
			
			if(commentList != null && commentList.size() > 0) {
				for(CommentVO cmtvo : commentList) {
					JSONObject jsonobj = new JSONObject();
					jsonobj.put("contents", cmtvo.getComments()); // json의 키값 설정														
					jsonobj.put("userid", cmtvo.getFk_userid()); // json의 키값 설정
					jsonobj.put("com_writedate", cmtvo.getCom_writedate()); // json의 키값 설정
										
					// import시 org.json은 put을 쓴다. 반면 simple 은 add로 쓴다.
					jsArr.put(jsonobj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		
		String result = jsArr.toString();
		request.setAttribute("result", result);
		
		return result;
		
	}
	
	
	
	
	// 지도 검색 페이지
	@RequestMapping(value = "/map.we", method = { RequestMethod.GET })
	public ModelAndView map(HttpServletRequest request, ModelAndView mv) {
		
		List<AccVO> storemapList = service.getStoreMap();
		
		mv.addObject("menuname", "Accommodation"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("menulink", request.getContextPath()+"/accommodation/accList.we"); // 헤더에 메뉴에 링크 주는거
		mv.addObject("pagename", "Map"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("pagelink", request.getContextPath()+"/map.we"); // 헤더에 메뉴에 링크 주는거
		
		mv.addObject("storemapList", storemapList);
		mv.setViewName("accommodation/map.tiles1");

		return mv;
	}	

	
	
	
	
}


