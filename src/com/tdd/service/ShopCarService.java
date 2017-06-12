package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

public interface ShopCarService {

	List<ShopCar> findAll();

	List<ShopCar> findByPage(int intPage, int number, DetachedCriteria criteria);

	void update(ShopCar shopCar);

	void delete(ShopCar shopCar);

	ShopCar findByID(Long car_id);

	void save(com.tdd.domain.ShopCar shopCar);

	ShopCar getSameGood(Long goods_id, User user);

	void delete_goods(Long goods_id);

}
