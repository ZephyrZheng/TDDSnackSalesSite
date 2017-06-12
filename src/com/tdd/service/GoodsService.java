package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.domain.Goods;

public interface GoodsService {

	void save(Goods good);

	void delete(Goods good);

	List<Goods> findAll();

	List<Goods> findByPage(int intPage, int number, DetachedCriteria criteria);

	void update(Goods good);

	Goods findById(Long goods_id);

	List<Goods> findByName(DetachedCriteria criteria);

}
