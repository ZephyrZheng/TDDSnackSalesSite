package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.tdd.dao.OrdersDao;
import com.tdd.domain.Orders;

@Transactional
public class OrdersServiceImpl implements OrdersService {

	private OrdersDao ordersDao;
	public void setOrdersDao(OrdersDao ordersDao) {
		this.ordersDao = ordersDao;
	}

	public List<Orders> findAll() {
		return ordersDao.findAll();
	}

	public List<Orders> findByPage(int intPage, int number, DetachedCriteria criteria) {
		return ordersDao.findByPage(intPage,number,criteria);
	}

	public void update(Orders orders) {
		ordersDao.update(orders);
	}

	public Orders findById(Long id) {
		return ordersDao.findById(id);
	}

	public void delete(Orders orders) {
		ordersDao.delete(orders);
	}

	public void save(Orders orders) {
		ordersDao.save(orders);
	}

	public Orders findByOrd_Num(String paymentID) {
		return ordersDao.findByOrd_Num(paymentID);
	}

	
}
