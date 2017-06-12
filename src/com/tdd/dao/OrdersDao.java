package com.tdd.dao;

import java.util.List;

import com.tdd.domain.Orders;

public interface OrdersDao extends BaseDao<Orders>{

	Orders findByOrd_Num(String paymentID);


//	List<Orders> findByPage(int intPage, int number, DetachedCriteria criteria);
//
//	List<Orders> findAll();
//
//	void update(Orders orders);

}
