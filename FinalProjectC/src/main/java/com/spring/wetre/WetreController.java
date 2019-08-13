package com.spring.wetre;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wetre.index.service.InterWetreService;
import com.spring.wetre.model.AccVO;



@Controller
public class WetreController {

	
	@Autowired  //타입에 따라 알아서 Bean을 주입해준다.
	private InterWetreService service;
	
	
	
	//메인페이지 요청
	@RequestMapping(value="/index.we", method= {RequestMethod.GET})
	public ModelAndView index(HttpServletRequest request, ModelAndView mv)  {
		
		List<AccVO> avoList = service.getRecomList();
		
		int accidx = 0; 
				
		accidx = (int)(Math.random()*92)+6;
		//구간안에서 랜덤한 숫자 구하는 함수
		
		AccVO accvo = service.getRandomONe(accidx);
		mv.addObject("accvo", accvo);
		mv.addObject("avoList", avoList);
		
		mv.setViewName("main/index");  

		return mv;
	}
	
	
	
	@RequestMapping(value="/foreCastSL.we", method= {RequestMethod.GET})
	public ModelAndView foreCast(HttpServletRequest request, ModelAndView mv)  {
		
		/*mv.addObject("stnid", request.getParameter("stnid"));*/
		
		mv.addObject("lat", request.getParameter("lat"));
		mv.addObject("lon", request.getParameter("lon"));

		mv.addObject("pagename", "Wether"); // 헤더에 메뉴 이름 뜨게 하는거
		mv.addObject("pagelink", request.getContextPath()+"/foreCastSL.we"); // 헤더에 메뉴에 링크 주는거
		
		mv.setViewName("weather/foreCastSL.tiles1");  //보여주는 파일쓰기 사이트주소아님
		//  /Board/src/main/webapp/WEB-INF/views/main/index.jsp 파일을 생성한다.     
		return mv;
	}
	
	
	
	
	
	
	
	// #y00. about us 페이지
	@RequestMapping(value="/aboutus.we", method= {RequestMethod.GET})
	public String aboutus() {

		return "wetre/aboutus.tiles1";
		
	} // end of about us 페이지 -------------
		
	
	
	
	
	
}
