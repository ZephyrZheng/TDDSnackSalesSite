package com.tdd.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.tdd.domain.Orders;
@SuppressWarnings("unchecked")
public class OrdersDaoImpl extends BaseDaoImpl<Orders> implements OrdersDao {

	public Orders findByOrd_Num(String paymentID) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Orders.class);
		criteria.add(Restrictions.eq("ord_number", paymentID));
		List<Orders> orders = (List<Orders>) this.getHibernateTemplate().findByCriteria(criteria);
		if (orders!=null && !orders.isEmpty()) {
			System.out.println("OrdersDaoImpl/根据Ord_Num查找订单："+orders.get(0));
			return orders.get(0);
		}
		return null;
	}


//	public List<Orders> findByPage(int intPage, int number, DetachedCriteria criteria) {
//		List<Orders> lists = (List<Orders>) this.getHibernateTemplate().findByCriteria(criteria, 
//				(intPage-1)*number, number);
//		return lists;
//	}
//
//	public List<Orders> findAll() {
//		return (List<Orders>) this.getHibernateTemplate().find("from Orders");
//	}
//
//	public void update(Orders orders) {
//		this.getHibernateTemplate().update(orders);
//	}

}
