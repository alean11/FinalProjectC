package com.spring.wetre.board.service;

import java.util.HashMap;
import java.util.List;

import com.spring.wetre.model.*;


public interface InterBoardNoticeService {

	int add(BoardNoticeVO boardvo);          // 글쓰기(파일첨부가 없는 글쓰기) 
	
	BoardNoticeVO getView(String seq, String userid); // 1개 글 보여주기. 
	                                            // 글 조회수 증가는 다른 사람의 글을 읽을 때만 증가하도록 한다. 
	                                            // 로그인 하지 않은 상태에서 글을 읽을때 조회수 증가가 일어나지 않도록 한다. 

	BoardNoticeVO getViewWithNoAddCount(String seq); // 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것

	int edit(BoardNoticeVO boardvo); // 1개글 수정하기 

	int del(BoardNoticeVO boardvo) throws Throwable; // 1개글 삭제하기 (댓글쓰기가 있는 게시판)

/*	List<BoardNoticeVO> boardListSearch(HashMap<String, String> paraMap); // 페이징 처리를 안한 검색어가 있는 전체 글목록 보여주기
*/
	List<String> wordSearchShow(HashMap<String, String> paraMap); // 검색어 입력시 자동글 완성하기 

	int getTotalCountWithNOsearch(); // 검색조건이 없을 경우의 총 게시물 건수(totalCount)

	int getTotalCountWithSearch(HashMap<String, String> paraMap); // 검색조건이 있을 경우의 총 게시물 건수(totalCount) 

	List<BoardNoticeVO> boardListWithPaging(HashMap<String, String> paraMap); // 페이징 처리한 글목록 가져오기(검색이 있든지 , 검색이 없든지 다 포함한것)

}
