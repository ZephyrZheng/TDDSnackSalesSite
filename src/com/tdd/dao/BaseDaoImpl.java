package com.tdd.dao;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;


/*
 *	通用Dao实现类，所有Dao实现类直接继承BaseDaoImpl 
 */
@SuppressWarnings("all")
public class BaseDaoImpl<T> extends HibernateDaoSupport implements BaseDao<T> {

	//定义成员属性(待传入)
	private Class clazz; 
	public BaseDaoImpl(){
		System.out.println("BaseDaoImpl构造方法，在子类(待传入类对象)加载时候执行______________");
		//该方法在子类加载时候执行 ，此时this表示子类
		Class c = this.getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			ParameterizedType pType = (ParameterizedType) type;
			//获取传入类对象
			Type[] types = pType.getActualTypeArguments();
			this.clazz = (Class) types[0];
		}
	}
	
	public void save(T t) {
		this.getHibernateTemplate().save(t);
	}

	public void delete(T t) {
		this.getHibernateTemplate().delete(t);
	}

	public void update(T t) {
		this.getHibernateTemplate().update(t);
	}

	//通过主键查询
	public T findById(Long id) {
		return (T) this.getHibernateTemplate().get(clazz, id);
	}

	//查询所有数据
	public List<T> findAll() {
		return (List<T>) this.getHibernateTemplate().find("from "+clazz.getSimpleName());
	}

	public List<T> findByPage(int intPage, int number, DetachedCriteria criteria) {
		//(Hibernate 框架提供分页)根据传入页号和页大小 计算显示list
		List<T> lists = (List<T>) this.getHibernateTemplate().findByCriteria(criteria, 
				(intPage-1)*number, number);
		return lists;
	}

	public List<T> findByName(DetachedCriteria criteria) {
		//(Hibernate 框架提供分页)根据传入页号和页大小 计算显示list
		List<T> lists = (List<T>) this.getHibernateTemplate().findByCriteria(criteria);
		return lists;
	}

}
