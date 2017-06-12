package com.tdd.dao;

import com.tdd.domain.Goods;

public class GoodsDaoImpl extends BaseDaoImpl<Goods> implements GoodsDao {

//	public void save(Goods good) {
//		this.getHibernateTemplate().save(good);
//	}
//
//	public void delete(Goods good) {
//		this.getHibernateTemplate().delete(good);
//	}
//
//	public List<Goods> findAll() {
//		return (List<Goods>) this.getHibernateTemplate().find("from Goods");
//	}
//	
//	public List<Goods> finByPage(int intPage, int number, DetachedCriteria criteria) {
//		List<Goods> lists = (List<Goods>) this.getHibernateTemplate().findByCriteria(criteria, 
//				(intPage-1)*number, number);
//		return lists;
//	}
//
//	public void update(Goods good) {
//		this.getHibernateTemplate().update(good);
//	}
//
//	public Goods findById(Long goods_id) {
//		return (Goods) this.getHibernateTemplate().get(Goods.class, goods_id);
//	}
	
}
