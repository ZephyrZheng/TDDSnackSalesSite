package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.dao.OrderItemsDao;
import com.tdd.domain.OrderItems;

public class OrderItemsServiceImpl implements OrderItemsService {

	private OrderItemsDao orderItemsDao;
	public void setOrderItemsDao(OrderItemsDao orderItemsDao) {
		this.orderItemsDao = orderItemsDao;
	}
	
	public List<OrderItems> findAll() {
		return orderItemsDao.findAll();
	}

	public List<OrderItems> findByPage(int intPage, int number, DetachedCriteria criteria) {
		return orderItemsDao.findByPage(intPage, number, criteria);
	}

	public void update(OrderItems orderItems) {
		this.orderItemsDao.update(orderItems);
	}

	public OrderItems findById(Long ori_id) {
		return orderItemsDao.findById(ori_id);
	}

	public void delete(OrderItems orderItems) {
		orderItemsDao.delete(orderItems);
	}

	public void save(OrderItems orderItems) {
		orderItemsDao.save(orderItems);
	}

	public List<OrderItems> findByOrd_Id(DetachedCriteria criteria) {
		return orderItemsDao.findByOrd_id(criteria);
	}
	
}
