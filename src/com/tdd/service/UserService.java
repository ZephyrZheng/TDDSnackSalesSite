package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.domain.Orders;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

public interface UserService {

	//添加
	void save(User user);

	//由主键查找用户
	public User findById(Long user_id);
	
	//查询所有
	public List<User> findAll();
	
	public void delete(User user);
	
	public void update(User user);

	List<User> findByPage(int intPage, int number, DetachedCriteria criteria);

	User login(User user);

	List<ShopCar> getShopCart(Long u_id);

	List<Orders> getOrders(Long user_id, String order_Q);

	Boolean regist(User user);

}
