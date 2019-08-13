package com.spring.wetre.board.model;

import java.util.HashMap;
import java.util.List;

import com.spring.wetre.model.BoardVO;


public interface InterBoardDAO {

	int add(BoardVO boardvo);          // 글쓰기(파일첨부가 없는 글쓰기)
	
	BoardVO getView(String seq); // 1개 글 보여주기
	
	void setAddReadCount(String seq); // 글조회수 1증가하기

	boolean checkPW(BoardVO boardvo); // 글수정 및 글삭제시 암호일치 여부 알아오기 

	int updateBoard(BoardVO boardvo); // 글 1개를 수정한다.

	int deleteBoard(BoardVO boardvo); // 글 1개를 삭제한다.

	List<String> wordSearchShow(HashMap<String, String> paraMap); // 검색어 입력시 자동글 완성하기 

	int getTotalCountWithNOsearch(); // 검색조건이 없을 경우의 총 게시물 건수(totalCount) 

	int getTotalCountWithSearch(HashMap<String, String> paraMap); // 검색조건이 있을 경우의 총 게시물 건수(totalCount) 

	List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap); // 페이징 처리한 글목록 가져오기(검색이 있든지 , 검색이 없든지 다 포함한것)

	int getGroupnoMax(); // tblBoard 테이블에서 groupno 컬럼의 최대값 구하기 

}
