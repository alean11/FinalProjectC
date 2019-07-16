package com.spring.wetre.chy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.SHA256;

/// #30. 컨트롤러 선언 ///
@Component
/* - XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   - 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
   - 생략 가능한데, 써본거임.
*/
@Controller
public class TestController {

	
	/// #36. 메인페이지 요청 ///
	@RequestMapping(value="accommodation/accList.we", method= {RequestMethod.GET})
	public ModelAndView accList(ModelAndView mv) {
		
		mv.setViewName("accommodation/accommodation.tiles1");
		
		return mv;
		// 위치는 여기: /FinalProjectC/src/main/webapp/WEB-INF/views/main/index.jsp
		// header랑 footer는 따로 있고, 이 index 파일은 content로 들어가는 것임.
	} // end of 메인페이지 요청 ------
	
	
}
