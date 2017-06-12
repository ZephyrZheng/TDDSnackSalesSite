package com.tdd.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.tdd.domain.OrderItems;
@SuppressWarnings("unchecked")
public class OrderItemsDaoImpl  extends BaseDaoImpl<OrderItems> implements OrderItemsDao {

	public List<OrderItems> findByOrd_id(DetachedCriteria criteria) {
		return (List<OrderItems>) this.getHibernateTemplate().findByCriteria(criteria);
	}

	

}
