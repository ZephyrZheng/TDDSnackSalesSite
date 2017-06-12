package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.tdd.dao.ShopCarDao;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

@Transactional
public class ShopCarServiceImpl implements ShopCarService {

	private ShopCarDao shopCarDao;
	public void setShopCarDao(ShopCarDao shopCarDao) {
		this.shopCarDao = shopCarDao;
	}
	
	public List<ShopCar> findAll() {
		return shopCarDao.findAll();
	}

	public List<ShopCar> findByPage(int intPage, int number, DetachedCriteria criteria) {
		return shopCarDao.findByPage(intPage, number, criteria);
	}

	public void update(ShopCar shopCar) {
		shopCarDao.update(shopCar);
	}

	public void delete(ShopCar shopCar) {
		shopCarDao.delete(shopCar);
	}

	public ShopCar findByID(Long car_id) {
		return shopCarDao.findById(car_id);
	}

	public void save(ShopCar shopCar) {
		shopCarDao.save(shopCar);
	}

	//查询是否购物车存在用户相同商品
	public ShopCar getSameGood(Long goods_id, User user) {
		return shopCarDao.getSameGood(goods_id,user);
	}

	public void delete_goods(Long goods_id) {
		shopCarDao.delete_goods(goods_id);
	}
	
	
}
