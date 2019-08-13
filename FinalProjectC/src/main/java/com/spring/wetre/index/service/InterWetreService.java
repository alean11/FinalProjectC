package com.spring.wetre.index.service;

import java.util.List;

import com.spring.wetre.model.AccVO;

public interface InterWetreService {

	List<AccVO> getRecomList();
	
	AccVO getRandomONe(int accidx);
	
	
}
