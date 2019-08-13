package com.spring.wetre.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wetre.board.model.InterBoardDAO;
import com.spring.wetre.model.*;


// === #31. Service 선언 ===
@Service
public class BoardService implements InterBoardService {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterBoardDAO dao;
	
	// === #54. 글쓰기(파일첨부가 없는 글쓰기) ===
	@Override
	public int add(BoardVO boardvo) {

		// === #126. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여
		//           tblBoard 테이블에 insert 를 해주어야 한다.
		//           원글쓰기 이라면 tblBoard 테이블의 groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해서 insert 해야 하고,  
		//           답변글쓰기 이라면 넘겨받은 값을 그대로 insert 해주어야 한다.
		
		// == 원글쓰기인지, 답변글쓰기인지 구분하기 == 
		if(boardvo.getFk_qna_seq() == null || boardvo.getFk_qna_seq().trim().isEmpty() ) {  
			// 원글쓰기인 경우
			int groupno = dao.getGroupnoMax()+1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
		//////////////////////////////////////////////
		
		int n = dao.add(boardvo);
		return n;
	}

	// === #62. 1개 글 보여주기. ===
	// (먼저, 로그인을 한 상태에서 다른 사람의 글을 조회할 경우에는 글조회수 컬럼 1증가해야 한다.) 
	@Override
	public BoardVO getView(String seq, String userid) {
		                             // userid 는 로그인한 사용자의 userid 이다.
		                             // 만약에 로그인을 하지 않은 상태이라면 userid 는 null 이다.
		BoardVO boardvo = dao.getView(seq);
		
		if( !boardvo.getP_userid().equals(userid) ) {
			// 글조회수 증가는 다른 사람의 글을 읽을때만 증가하도록 해야 한다.
			// 로그인 하지 않은 상태에서는 글조회수 증가는 없다.
			
			dao.setAddReadCount(seq);  // 글조회수 1증가하기
			boardvo = dao.getView(seq);
		}
		
		return boardvo;
	}


	// === #69. 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것 ===
	@Override
	public BoardVO getViewWithNoAddCount(String seq) {
		BoardVO boardvo = dao.getView(seq);
		return boardvo;
	}


	// === #72. 1개글 수정하기 ===
	@Override
	public int edit(BoardVO boardvo) {
		
		// 수정하려하는 글에 대한 원래의 암호를 읽어와서 
		// 수정시 입력한 암호와 비교를 한다.
		boolean bool = dao.checkPW(boardvo);
		
		if(!bool) // 암호가 일치 하지 않는 경우
			return 0;
		else {
			// 글 1개를 수정한다.
			int n = dao.updateBoard(boardvo);
			
			return n;
		}
	}


/*	// === #98. 페이징 처리를 안한 검색어가 있는 전체 글목록 보여주기 ===
	@Override
	public List<BoardVO> boardListSearch(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearch(paraMap);
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
	public List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListWithPaging(paraMap); 
		return boardList;
	}


	@Override
	public int del(BoardVO boardvo) throws Throwable {
	
		boolean bool = dao.checkPW(boardvo);

		if(!bool) // 암호가 일치 하지 않는 경우
			return 0;
		else {
		
			// 글 1개를 수정한다.
			int n = dao.deleteBoard(boardvo);
			return n;
			}
	}

	
}
