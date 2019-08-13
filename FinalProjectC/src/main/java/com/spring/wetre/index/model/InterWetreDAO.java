package com.spring.wetre.index.model;

import java.util.List;

import com.spring.wetre.model.AccVO;

public interface InterWetreDAO {

	List<AccVO> getRecomList();

	AccVO getRandomONe(int accidx);
	
}
