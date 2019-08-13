package com.spring.wetre.index.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wetre.index.model.InterWetreDAO;
import com.spring.wetre.model.AccVO;

@Service
public class WetreService implements InterWetreService {

	
	@Autowired
	private InterWetreDAO dao;
	
	
	@Override
	public List<AccVO> getRecomList() {
		return dao.getRecomList();
	}

	@Override
	public AccVO getRandomONe(int accidxService) {
		return dao.getRandomONe(accidxService);
	}

}
