package com.spring.wetre.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wetre.board.service.InterBoardService;
import com.spring.wetre.common.*;
import com.spring.wetre.model.*;

/// #30. 컨트롤러 선언 ///
@Component
@Controller
public class BoardController {

		
		//=== #35. 의존객체 주입하기(DI: Dependency Injection) ===
		@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
		private InterBoardService service;
		
		// === #51. 게시판 글쓰기 폼페이지 요청 ===
		@RequestMapping(value="/qna/qnaAdd.we", method= {RequestMethod.GET})
		public ModelAndView requirePrivateLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) { 
			// === #124. 답변글쓰기가 추가된 경우 ===
			String fk_qna_seq = request.getParameter("fk_qna_seq");
			String groupno = request.getParameter("groupno");
			String depthno = request.getParameter("depthno");
			
			mv.addObject("fk_qna_seq", fk_qna_seq);
			mv.addObject("groupno", groupno);
			mv.addObject("depthno", depthno);
		   //////////////////////////////////////////////////
			
			mv.setViewName("board/qnaAdd.tiles1");
			
			return mv;
		}
		
		// === #53. 게시판 글쓰기 완료 요청 ===
		@RequestMapping(value="/qna/qnaAddEnd.we", method= {RequestMethod.POST}) 
		public String addEnd(BoardVO boardvo, HttpServletRequest request) {	
			
			String content = boardvo.getQ_context();
			
			// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 *** //
			boardvo.setQ_context(MyUtil.replaceParameter(content));  	 
			
			
			System.out.println(boardvo.getQ_context());
			
			
			content = boardvo.getQ_context().replaceAll("\r\n", "<br/>");
			/*boardvo.setContent(content);*/
			
		
			int n = service.add(boardvo); 
			request.setAttribute("n", n);
			
			return "board/qnaAddEnd.tiles1";
			
		}
		
		// === #103. 검색어 입력시 자동글 완성하기 3 === 
		   @RequestMapping(value="/wordSearchShowQnA.we", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
		   @ResponseBody
		   public String wordSearchShow(HttpServletRequest request) {
			   
			   String searchType = request.getParameter("searchType");
			   String searchWord = request.getParameter("searchWord");
			   
			   HashMap<String,String> paraMap = new HashMap<String,String>();
			   paraMap.put("searchType", searchType);
			   paraMap.put("searchWord", searchWord);
			   
			   List<String> wordList = service.wordSearchShow(paraMap);
			   
			   JSONArray jsonArr = new JSONArray();
			   
			   if(wordList != null) {
				   for(String word : wordList) {
					   JSONObject jsonObj = new JSONObject();
					   jsonObj.put("word", word);
					   jsonArr.put(jsonObj);
				   }
			   }
			   
			   String result = jsonArr.toString();
			   
			   return result;
		   }
		
		// === #57. 글목록 보기 페이지 요청 ===
		@RequestMapping(value="/qnaList.we", method= {RequestMethod.GET})
		public ModelAndView list(HttpServletRequest request, ModelAndView mv) {
		
		List<BoardVO> boardList = null;
			
		String str_currentShowPageNo = request.getParameter("currentPageNo"); 
		
		int totalCount = 0;         // 총게시물 건수
		int sizePerPage = 10;        // 한 페이지당 보여줄 게시물 수
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;          // 총 페이지 수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;           // 시작 행번호
		int endRno   = 0;           // 끝 행 번호
		int blockSize = 10;
		
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
		
		// 검색조건이 없을 경우의 총 게시물 건수(totalCount)
		if("".equals(searchWord)) {
			totalCount = service.getTotalCountWithNOsearch();
		}
		
		// 검색조건이 있을 경우의 총 게시물 건수(totalCount)
		else {
			totalCount = service.getTotalCountWithSearch(paraMap);
		}
		
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage ); 
		
		
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		} //------------------
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 
		paraMap.put("startRno",String.valueOf(startRno));
		paraMap.put("endRno",String.valueOf(endRno));
		
		boardList = service.boardListWithPaging(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지 , 검색이 없든지 다 포함한것)
		
		if(!"".equals(searchWord)) {
			mv.addObject("paraMap", paraMap);
		}
		
		
		// 페이지 번호 리스트 만듦
				int loop = 1;
				int prev = 0;
				int next = 0;
				int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; // 페이지 번호
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
				
				
				// 페이지바 관련
				mv.addObject("prev", prev);
				mv.addObject("next", next);
				mv.addObject("pageNoList", pageNoList);
				mv.addObject("currentPageNo", currentShowPageNo);
				
		
		String gobackURL = MyUtil.getCurrentURL(request);

		mv.addObject("gobackURL", gobackURL);
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes"); 
		
		mv.addObject("boardList", boardList);
		mv.setViewName("board/q&a.tiles1");
			
			return mv;
		}
		
		
		 // === #61. 글1개를 보여주는 페이지 요청 ===
		   @RequestMapping(value="/view.we", method= {RequestMethod.GET})	
		   public ModelAndView view(HttpServletRequest request, ModelAndView mv) {
			   
			   // 조회하고자 하는 글번호 받아오기
			   String seq = request.getParameter("qna_idx");
			   
			   String gobackURL = request.getParameter("gobackURL");
			   mv.addObject("gobackURL", gobackURL);
			   
			   HttpSession session = request.getSession();
			   PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
			   
			   String userid = null; 
			   
			   if(loginuser != null) {
				   userid = loginuser.getP_userid(); 
				   // 로그인 되어진 사용자의 userid 
			   }
			   
			   // === #67. !!! 글1개를 보여주는 페이지 요청은 select 와 함께 
			   //     DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
			   //     이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
			   //     매번 글조회수 증가가 발생한다.
			   //     그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
			   //     단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은 
			   //     실행하지 않도록 해주어야 한다. !!! === //
			   
			   BoardVO boardvo = null;
			   
			   // 위의 글목록보기 #68. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
			   if("yes".equals(session.getAttribute("readCountPermission")) ) {
				   // 글목록보기를 클릭한 다음 특정글을 조회해온 경우이다.
			   
			      boardvo = service.getView(seq, userid);
			      // 글조회수 증가와 함께 글1개 조회를 해주는 것
			      
			      session.removeAttribute("readCountPermission");
			      // 중요함!! session 에 저장된 readCountPermission을 삭제한다.
			   }
			   else {
				  boardvo = service.getViewWithNoAddCount(seq);
				  // 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것
			   }
			   
			   mv.addObject("boardvo", boardvo);
			   mv.setViewName("board/qnaView.tiles1");
			   
			   return mv;
		   }
		   
		   
		// === #70. 글수정 페이지 요청 ===
		   @RequestMapping(value="/edit.we", method= {RequestMethod.GET})
		   public ModelAndView requirePrivateLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) { 
			   
			   // 글 수정해야할 글번호 가져오기
			   String qna_idx = request.getParameter("qna_idx");
			   
			   // 글 수정해야할 글1개 내용 가져오기
			   BoardVO boardvo = service.getViewWithNoAddCount(qna_idx);
			   // 글조회수(readCount) 증가 없이 그냥 글1개만 가져오는 것
			   
			   HttpSession session = request.getSession();
			   PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
			   
			   if( !loginuser.getP_userid().equals(boardvo.getP_userid()) ) { 
				   String msg = "다른 사용자의 글은 수정이 불가합니다.";
				   String loc = "javascript:history.back()";
				   
				   mv.addObject("msg", msg);
				   mv.addObject("loc", loc);
				   mv.setViewName("msg");
			   }
			   else {
				   // 자신의 글을 수정할 경우 
				   // 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
				   mv.addObject("boardvo", boardvo);
				   
				   mv.setViewName("board/qnaEdit.tiles1");
			   }
			   
			   return mv;
		   }
			

		   // === #71. 글수정 페이지 완료하기 ===
		   @RequestMapping(value="/qnaEditEnd.we", method= {RequestMethod.POST})
		   public ModelAndView requirePrivateLogin_editEnd(HttpServletRequest request, HttpServletResponse response, BoardVO boardvo, ModelAndView mv) {
			   
			   String content = boardvo.getQ_context();
			   
			   // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 *** //
			   content = MyUtil.replaceParameter(content);
			   content = content.replaceAll("\r\n", "<br/>");
			   
			   boardvo.setQ_context(content);
			   
			   /* 글 수정을 하려면 원본글의 글암호와 수정시 입력해준 암호가 일치할때만
			           수정이 가능하도록 해야 한다. */
			   int n = service.edit(boardvo);
			   
			   if(n == 0) {
				   mv.addObject("msg", "암호가 일치하지 않아 글 수정이 불가합니다.");
			   }
			   else {
				   mv.addObject("msg", "글수정 성공!!");
			   }
			   
			   mv.addObject("loc", request.getContextPath()+"/view.we?qna_idx="+boardvo.getQna_idx());
			   mv.setViewName("msg");
			   
			   return mv;
		   }
		   
		   
		   // === #77. 글삭제 페이지 요청 ===
		   @RequestMapping(value="/del.we", method= {RequestMethod.GET})
		   public ModelAndView requirePrivateLogin_del(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) { 
			
			   // 삭제해야할 글번호를 받아온다.
			   String qna_idx = request.getParameter("qna_idx");
			   
			   // 삭제해야할 글1개 내용 가져오기
			   BoardVO boardvo = service.getViewWithNoAddCount(qna_idx);
			   
			   // 글조회수(readCount) 증가 없이 그냥 글1개만 가져오는 것
			   
			   HttpSession session = request.getSession();
			   PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
			   
			   if( !loginuser.getP_userid().equals(boardvo.getP_userid()) ) { 
				   String msg = "다른 사용자의 글은 삭제가 불가합니다.";
				   String loc = "javascript:history.back()";
				   
				   mv.addObject("msg", msg);
				   mv.addObject("loc", loc);
				   mv.setViewName("msg");
			   }
			   else {
				   // 자신의 글을 삭제할 경우
				   // 글삭제시 입력한 암호가 글작성시 입력해준 암호와 일치하는지
				   // 알아오도록 del.jsp 페이지로 넘긴다.
				   mv.addObject("qna_idx", qna_idx);
				   mv.setViewName("board/qnaDel.tiles1");
				   // /Board/src/main/webapp/WEB-INF/views/tiles1/board/del.jsp 파일을 생성한다.
			   }
			   
			   return mv;
		   }
		   
		   
		   // === #78. 글삭제 페이지 완료하기 ===
		   @RequestMapping(value="/delEnd.we", method= {RequestMethod.POST})
		   public ModelAndView delEnd(HttpServletRequest request, ModelAndView mv) {
			 
			   try {
				   // 삭제해야할 글번호 및 사용자가 입력한 암호를 받아온다.
				   String qna_idx = request.getParameter("qna_idx");
				   String pw = request.getParameter("pw");
				   
				   BoardVO boardvo = new BoardVO();
				   boardvo.setQna_idx(qna_idx);
				   boardvo.setQ_pwd(pw);
				   
				   int n = service.del(boardvo);
				   
				   if(n == 0) {
					   mv.addObject("msg", "암호가 일치하지 않아 글 삭제가 불가합니다.");
				   }
				   else {
					   mv.addObject("msg", "글삭제 성공!!");
				   }
				   
				   mv.addObject("loc", request.getContextPath()+"/qnaList.we");
				   mv.setViewName("msg");
			   
			    } catch (Throwable e) {
					e.printStackTrace();
				}
			   
			    return mv;
		   }
		   
		   
		
	
}
