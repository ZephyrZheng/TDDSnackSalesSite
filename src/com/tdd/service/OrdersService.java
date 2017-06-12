package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.domain.Orders;

public interface OrdersService {

	List<Orders> findAll();

	List<Orders> findByPage(int intPage, int number, DetachedCriteria criteria);

	Orders findById(Long id);
	
	void update(Orders orders);

	void delete(Orders orders);

	void save(Orders orders);

	Orders findByOrd_Num(String paymentID);

}
