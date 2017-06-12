package com.tdd.dao;

import java.util.List;

import com.tdd.domain.Orders;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

public interface UserDao extends BaseDao<User>{

	User login(User user);

	List<ShopCar> getShopCart(Long u_id);

	List<Orders> getOrders(Long user_id, String order_Q);

//	void save(User user);
//
//	List<User> findAll();
//
//	void delete(User user);
//
//	void update(User user);
//
//	User findById(Long user_id);
//
//	List<User> findByPage(int intPage, int number, DetachedCriteria criteria);

}
