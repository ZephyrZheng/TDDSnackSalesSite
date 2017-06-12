package com.tdd.dao;

import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

public interface ShopCarDao extends BaseDao<ShopCar>{

	ShopCar getSameGood(Long goods_id, User user);

	void delete_goods(Long goods_id);
	
}
