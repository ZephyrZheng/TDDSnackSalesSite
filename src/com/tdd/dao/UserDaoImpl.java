package com.tdd.dao;

import org.hibernate.Query;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.tdd.domain.Orders;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;
@SuppressWarnings("unchecked")
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

	public User login(User user) {
		String u_name = user.getUser_name();
		String u_pass = user.getUser_pwd();
		System.out.println("Input_______________ user_name:"+u_name+"user_pwd:"+u_pass);
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		criteria.add(Restrictions.eq("user_name", u_name));
		criteria.add(Restrictions.eq("user_pwd", u_pass));
		List<User> list = (List<User>)  this.getHibernateTemplate().findByCriteria(criteria);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	public List<ShopCar> getShopCart(Long u_id) {
		System.out.println("连接查询id_____"+u_id);
		Query query = (Query) this.getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery("from User u inner join fetch u.shopcar as sc where u.user_id = "+u_id);
		List<User> list =  query.list();
		//System.out.println("未去重list_____:"+list);
		
		if(list==null||list.size()!=0){
			List<ShopCar> shopcartlist = new ArrayList<ShopCar>() ;
			//去重存入shopcartlist
			Set<User> set = new HashSet<User>(list);
			for(User user:set){
				shopcartlist.addAll(user.getShopcar());
				//System.out.println("List___"+shopcartlist);
			}
			System.out.println("DaoImpl/ShopCarlist___"+shopcartlist);
			return shopcartlist;
		}
		return null;
	}

	public List<Orders> getOrders(Long user_id,String Order_Q) {
		String q = "";
		if (Order_Q.equals("Unconfirmed")){
			//查询未确认
			q = "select DISTINCT u from User u inner join fetch u.orders as Od where u.user_id = "+user_id
					+ " and Od.ord_state ='0' order by Od.ord_id";
		}else if(Order_Q.equals("confirmed")){
			//已确认未付款
			q = "select DISTINCT u from User u inner join fetch u.orders as Od where u.user_id = "+user_id
					+ " and Od.ord_state ='1' and Od.pay_state ='0' order by Od.ord_id";
		}else if(Order_Q.equals("paied")){
			//确认且付款
			q = "select DISTINCT u from User u inner join fetch u.orders as Od where u.user_id = "+user_id
					+ " and Od.ord_state ='1' and Od.pay_state ='1' order by Od.ord_id";
		}
		
		System.out.println("查询条件__________："+q);
		Query query = (Query)this.getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery(q);
		List<User> list = query.list();
		//遍历
//		for(User attribute : list) {
//			  System.out.println("UserDaoImpl/遍历list"+attribute.getOrders());
//			}
		if (list==null||list.size()!=0) {
			List<Orders> orders_ls = new ArrayList<Orders>();
			Set<User> set = new HashSet<User>(list);
			for(User user : set){
				orders_ls.addAll(user.getOrders());
			}
			//System.out.println("DaoImpl/去重Ordlist___"+orders_ls);
			return orders_ls;
		}
		return null;
	}

//	public void save(User user) {
//		// 把数据，保存到数据库中
//		this.getHibernateTemplate().save(user);
//	}
//
//	public List<User> findAll() {
//		return (List<User>) this.getHibernateTemplate().find("from User");
//	}
//
//	public void delete(User user) {
//		this.getHibernateTemplate().delete(user);
//	}
//
//	public void update(User user) {
//		this.getHibernateTemplate().update(user);
//	}
//
//	public User findById(Long user_id) {
//		return this.getHibernateTemplate().get(User.class, user_id);
//	}
//	
//	//查询每页数据
//	public List<User> findByPage(int intPage, int number, DetachedCriteria criteria) {
//		//(Hibernate 框架提供分页)根据传入页号和页大小 计算显示list
//		List<User> lists = (List<User>) this.getHibernateTemplate().findByCriteria(criteria, 
//				(intPage-1)*number, number);
//		return lists;
//	}

}
