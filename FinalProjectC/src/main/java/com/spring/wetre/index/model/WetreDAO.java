package com.spring.wetre.index.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.AccVO;

@Repository
public class WetreDAO implements InterWetreDAO {

	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<AccVO> getRecomList() {
		return sqlsession.selectList("wetre.getRecomList");
	}

	@Override
	public AccVO getRandomONe(int accidx) {
		return sqlsession.selectOne("wetre.getRandomONe", accidx);
	}

}
