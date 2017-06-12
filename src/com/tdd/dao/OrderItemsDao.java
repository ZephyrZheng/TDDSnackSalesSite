package com.tdd.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.domain.OrderItems;

public interface OrderItemsDao extends BaseDao<OrderItems> {

	List<OrderItems> findByOrd_id(DetachedCriteria criteria);

}
