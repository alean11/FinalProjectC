package com.spring.wetre.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wetre.board.model.InterNoticeBoardDAO;
import com.spring.wetre.model.*;



// === #31. Service 선언 ===
@Service
public class BoardNoticeService implements InterBoardNoticeService {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterNoticeBoardDAO dao;
	
	// === #54. 글쓰기(파일첨부가 없는 글쓰기) ===
	@Override
	public int add(BoardNoticeVO noticevo) {

		// === #126. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여
		//           tblBoard 테이블에 insert 를 해주어야 한다.
		//           원글쓰기 이라면 tblBoard 테이블의 groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해서 insert 해야 하고,  
		//           답변글쓰기 이라면 넘겨받은 값을 그대로 insert 해주어야 한다.
		
		int n = dao.add(noticevo);
		return n;
	}

	// === #62. 1개 글 보여주기. ===
	// (먼저, 로그인을 한 상태에서 다른 사람의 글을 조회할 경우에는 글조회수 컬럼 1증가해야 한다.) 
	@Override
	public BoardNoticeVO getView(String seq, String userid) {

		BoardNoticeVO noticevo = dao.getView(seq);
		
			dao.setAddReadCount(seq);  // 글조회수 1증가하기
			noticevo = dao.getView(seq);
			
		return noticevo;
	}


	// === #69. 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것 ===
	@Override
	public BoardNoticeVO getViewWithNoAddCount(String seq) {
		BoardNoticeVO noticevo = dao.getView(seq);
		return noticevo;
	}


	// === #72. 1개글 수정하기 ===
	@Override
	public int edit(BoardNoticeVO noticevo) {
		
			// 글 1개를 수정한다.
			int n = dao.updateBoard(noticevo);
			
			return n;
	}


/*	// === #98. 페이징 처리를 안한 검색어가 있는 전체 글목록 보여주기 ===
	@Override
	public List<BoardNoticeVO> boardListSearch(HashMap<String, String> paraMap) {
		List<BoardNoticeVO> boardList = dao.boardListSearch(paraMap);
		return boardList;
	}*/


	// === #104. 검색어 입력시 자동글 완성하기 4 === 
	@Override
	public List<String> wordSearchShow(HashMap<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}


	// === #110. 검색조건이 없을 경우의 총 게시물 건수(totalCount) === 
	@Override
	public int getTotalCountWithNOsearch() {
		int count = dao.getTotalCountWithNOsearch();
		return count;
	}


	// === #113. 검색조건이 있을 경우의 총 게시물 건수(totalCount) === 
	@Override
	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int count = dao.getTotalCountWithSearch(paraMap);
		return count;
	}


	// === #116. 페이징 처리한 글목록 가져오기(검색이 있든지 , 검색이 없든지 다 포함한것) === 
	@Override
	public List<BoardNoticeVO> boardListWithPaging(HashMap<String, String> paraMap) {
		List<BoardNoticeVO> boardList = dao.boardListWithPaging(paraMap); 
		return boardList;
	}


	@Override
	public int del(BoardNoticeVO noticevo) throws Throwable {
			// 글 1개를 수정한다.
			int n = dao.deleteBoard(noticevo);
			return n;
	}

	
}
