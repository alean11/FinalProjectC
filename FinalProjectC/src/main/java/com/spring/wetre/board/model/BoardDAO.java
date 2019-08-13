package com.spring.wetre.board.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.*;

// === #32. DAO 선언 ===
@Repository
public class BoardDAO implements InterBoardDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private SqlSessionTemplate sqlsession;

	
	// === #55.글쓰기(파일첨부가 없는 글쓰기) ===
	@Override
	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("board.addQnA", boardvo);
		return n;
	}

	// === #63. 1개 글 보여주기 === //
	@Override
	public BoardVO getView(String seq) {
		BoardVO boardvo = sqlsession.selectOne("board.getViewQnA", seq);
		return boardvo;
	}
	// === #64. 글조회수 1증가하기 === //
	@Override
	public void setAddReadCount(String seq) {
		sqlsession.update("board.setAddReadCountQnA", seq);
	}

	// === #73. 글수정 및 글삭제시 암호일치 여부 알아오기 === 
	@Override
	public boolean checkPW(BoardVO boardvo) {
		int n = sqlsession.selectOne("board.checkPWQnA", boardvo); 
		
		if(n==1) 
			return true;
		else
			return false;
	}

	// === #75. 글 1개를 수정한다. ===
	@Override
	public int updateBoard(BoardVO boardvo) {
		int n = sqlsession.update("board.updateBoardQnA", boardvo);
		return n;
	}

	// === #80. 1개글 삭제하기  ===
	@Override
	public int deleteBoard(BoardVO boardvo) {
		int n = sqlsession.update("board.deleteBoardQnA", boardvo);
		return n;
	}

/*	// === #99. 페이징 처리를 안한 검색어가 있는 전체 글목록 보여주기 ===
	@Override
	public List<BoardVO> boardListSearch(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("board.boardListSearchQnA", paraMap);
		return boardList;
	}*/

	
	// === #105. 검색어 입력시 자동글 완성하기 5 === 
	@Override
	public List<String> wordSearchShow(HashMap<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("board.wordSearchShowQnA", paraMap);
		return wordList;
	}

	// === #111. 검색조건이 없을 경우의 총 게시물 건수(totalCount) === 
	@Override
	public int getTotalCountWithNOsearch() {
		int count = sqlsession.selectOne("board.getTotalCountWithNOsearchQnA");
		return count;
	}

	
	// === #114. 검색조건이 있을 경우의 총 게시물 건수(totalCount) === 
	@Override
	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int count = sqlsession.selectOne("board.getTotalCountWithSearchQnA", paraMap); 
		return count;
	}

	
	// === #117. 페이징 처리한 글목록 가져오기(검색이 있든지 , 검색이 없든지 다 포함한것) ===
	@Override
	public List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("board.boardListWithPagingQnA", paraMap);
		return boardList;
	}

	
	// === #127. tblBoard 테이블에서 groupno 컬럼의 최대값 구하기 === 
	@Override
	public int getGroupnoMax() {
		int max = sqlsession.selectOne("board.getGroupnoMaxQnA");
		return max;
	}
	
	
	
}
