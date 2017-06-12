package com.tdd.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.tdd.domain.OrderItems;

@Transactional
public interface OrderItemsService {

	List<OrderItems> findAll();

	List<OrderItems> findByPage(int intPage, int number, DetachedCriteria criteria);

	void update(OrderItems orderItems);

	OrderItems findById(Long ori_id);

	void delete(OrderItems orderItems);

	void save(OrderItems orderItems);

	List<OrderItems> findByOrd_Id(DetachedCriteria criteria);

}
