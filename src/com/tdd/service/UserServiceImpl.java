package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

import com.tdd.dao.UserDao;
import com.tdd.domain.Orders;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

@Transactional
public class UserServiceImpl implements UserService{

	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}


	public void save(User user) {
		userDao.save(user);
	}


	public List<User> findAll() {
		return userDao.findAll();
	}


	public User findById(Long user_id) {
		return userDao.findById(user_id);
	}


	public void delete(User user) {
		userDao.delete(user);
	}


	public void update(User user) {
		userDao.update(user);
	}

	public List<User> findByPage(int intPage, int number, DetachedCriteria criteria) {
		return userDao.findByPage(intPage,number,criteria);
	}


	public User login(User user) {
		return userDao.login(user);
	}


	public List<ShopCar> getShopCart(Long u_id) {
		return userDao.getShopCart(u_id);
	}


	public List<Orders> getOrders(Long user_id,String Order_Q) {
		return userDao.getOrders(user_id,Order_Q);
	}


	public Boolean regist(User user){
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		criteria.add(Restrictions.eq("user_name", user.getUser_name()));
		//查找名字返回名字相同的列表
		List<User> list = userDao.findByName(criteria);

		//判断列表是否为空
		if (list == null || list.size() == 0) {
			userDao.save(user);
			return true;
		}
		return false;
	}

}
