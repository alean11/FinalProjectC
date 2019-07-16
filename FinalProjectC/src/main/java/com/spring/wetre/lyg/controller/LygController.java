package com.spring.wetre.lyg.controller;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/// #30. 컨트롤러 선언 ///
@Component
/* - XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   - 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
   - 생략 가능한데, 써본거임.
*/
@Controller
public class LygController {

	
	// 지도페이지
	@RequestMapping(value="/contact.we", method= {RequestMethod.GET})
	public ModelAndView contact(ModelAndView mv) {
		
		mv.setViewName("wetre/contact.tiles1");
		
		return mv;
	}
	// 예약페이지
	@RequestMapping(value="/reserve.we", method= {RequestMethod.GET})
	public ModelAndView reserve(ModelAndView mv) {
		
		mv.setViewName("wetre/reserve.tiles1");
		
		return mv;
	}
	
	
}
