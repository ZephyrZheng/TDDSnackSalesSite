package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.tdd.dao.GoodsDao;
import com.tdd.domain.Goods;
@Transactional
public class GoodsServiceImpl implements GoodsService {

	private GoodsDao goodsDao;
	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}

	public void save(Goods good) {
		goodsDao.save(good);
	}

	public void delete(Goods good) {
		goodsDao.delete(good);
	}

	public List<Goods> findAll() {
		return goodsDao.findAll();
	}

	public List<Goods> findByPage(int intPage, int number, DetachedCriteria criteria) {
		return goodsDao.findByPage(intPage,number,criteria);
	}
	
	public void update(Goods good) {
		goodsDao.update(good); 
	}

	public Goods findById(Long goods_id) {
		return goodsDao.findById(goods_id);
	}

	public List<Goods> findByName(DetachedCriteria criteria) {
		return goodsDao.findByName(criteria);
	}

}
