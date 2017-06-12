package com.tdd.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.tdd.domain.ShopCar;
import com.tdd.domain.User;

@SuppressWarnings("unchecked")
public class ShopCardDaoImpl extends BaseDaoImpl<ShopCar> implements ShopCarDao {

	public ShopCar getSameGood(Long goods_id, User user) {
		DetachedCriteria criteria = DetachedCriteria.forClass(ShopCar.class);
		criteria.add(Restrictions.eq("user.user_id", user.getUser_id()));
		criteria.add(Restrictions.eq("goods_id", goods_id));
		List<ShopCar> list = (List<ShopCar>)  this.getHibernateTemplate().findByCriteria(criteria);
		if (list != null && list.size() > 0) {
			System.out.println("ShopCar/DAO/________查到相同商品"+list.get(0));
			return list.get(0);
		}
		
		return null;
	}

	//商品级联删除购物车
	public void delete_goods(Long goods_id) {
		DetachedCriteria criteria = DetachedCriteria.forClass(ShopCar.class);
		criteria.add(Restrictions.eq("goods_id", goods_id));
		List<ShopCar> list = (List<ShopCar>)  this.getHibernateTemplate().findByCriteria(criteria);
		List<ShopCar> shopCar = new ArrayList<ShopCar>();
		if (list != null && list.size() > 0) {
			for(int i = 0 ; i < list.size() ; i++) {
					System.out.println("ShopCar/DAO/________更新无效商品"+list.get(i));
					DetachedCriteria s_criteria = DetachedCriteria.forClass(ShopCar.class);
					criteria.add(Restrictions.eq("goods_id", list.get(i).getCar_id()));
					shopCar = (List<ShopCar>) this.getHibernateTemplate().findByCriteria(s_criteria);
					if (shopCar != null && shopCar.size() > 0){
						shopCar.get(0).setCar_state("0");
						shopCar.get(0).setCar_note("商品失效");
						this.getHibernateTemplate().update(shopCar.get(0));
						System.out.println("ShopCar/DAO/________更新无效商品对象"+shopCar.get(0));
					}
				}
		}
	}



}
